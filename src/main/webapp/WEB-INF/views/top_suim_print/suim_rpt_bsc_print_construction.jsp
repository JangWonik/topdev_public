<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/general_report.css?v=2017072611172222"/>
<script src="./resources/jquery/jquery.inputmask.bundle.min.js"></script>

<script type="text/javascript">
function fnReportWord(){
    var cw=screen.availWidth;
    var ch=screen.availHeight;

    var sw=1000; //띄울 창의 넓이
    var sh=740;  //띄울 창의 높이

    var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
    var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

//     window.open('/cstRptInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=word','word','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
}

function fnConstructReportPrint(){	
    var cw=screen.availWidth;
    var ch=screen.availHeight;

    var sw=700; //띄울 창의 넓이
    var sh=550;  //띄울 창의 높이

    var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
    var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

    window.open('/constructionRptInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
};

</script>
<div class="reportWrap">
	<div class="reportContent">
	
		<input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
		<input type="hidden" id="rpt_print_no" value="${reportPrint30.rptPrintNo}">
		<div class="text-right">
            <a href="constructionRptInfo?rpt_print_no=${reportPrint30.rptPrintNo}&cmd=word&suim_rpt_no=${param.suim_rpt_no}"><img src="./resources/ls_img/report/btn_word.gif"></a>
            <a href="#noloc" onclick="fnConstructReportPrint()"><img src="./resources/ls_img/report/icon_print.gif"></a>
        </div>
	        <div>
			<img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56">
			<p class="text-center" style="padding-top: 6px;"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
			<p class="text-center">
				<span style="font-size: 9pt;">
			         전화 : ${reportTeamInfo.teamTelephone} &nbsp;팩스 : ${reportTeamInfo.teamFax} &nbsp;이메일 : ${reportInvgUser.email}
			    </span>
			</p>
			<p class="text-center" style="padding-top: 2px;">
	                <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" height="3" border="0" class="img-responsive center-block">
	        </p>
		</div>
		<div style="margin-top: 10px;">
			<div style="width: 65%; float: left">
                <p class="title">수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신 : ${reportBscInfo.ptnrName}</p>
                <p class="title">참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조 : ${reportBscInfo.ptnrDeptNm}
                    <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
                        〔 담당 : ${reportBscInfo.ptnrMbrNm} 님 〕
                    </c:if>
                </p>
            </div>
			<div style="width: 35%; float: left">
                <p class="title">Report No. ${reportBscInfo.suimAcceptNo}</p>
                <p class="title">
                    <c:choose>
                        <c:when test="${reportBscInfo.invoiceDate == null || reportBscInfo.invoiceDate == ''}">
                            날짜 정보없음
                        </c:when>
                        <c:otherwise>
                            보고서 제출일 : ${reportBscInfo.invoiceDate}
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
                <p class="title">제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 :
                    <c:if test="${reportBscInfo.beneficiaryNm != ''}">${reportBscInfo.insuranceNm}
                        &quot;<b>${reportBscInfo.policyholderNm}</b>&quot;
                    </c:if>
                    <b>손해사정서</b>
                </p>
                <p class="title">증 권 번 호 : 제 ${reportBscInfo.policyNo} 호</p>
                <p class="title">사 고 번 호 : ${reportBscInfo.accidentNo}</p>
			<div style="clear: both"></div>
			<div>
                <p style="margin-top: 20px; padding: 0px 5px;">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    귀사의 요청에 의거하여 피보험자 &quot;${reportBscInfo.beneficiaryNm} &quot; 에 대한 사고조사를 실시하고, 
                    그 결과에 대한 최종 보고서를 다음과 같이 제출합니다.
                  
                </p>
            </div>
		
			<!-- 서명란 -->
			<div style="margin-top: 50px;">
            <table class="approval" align="center">
                <colgroup>
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                </colgroup>
                <tr>
                    <th>구분</th>
                    <th>성명</th>
                    <th>서명</th>
                    <th>연락처</th>
                </tr>
                <%-- 담당 손해사정사 정보로 변경 시작 --%>               	               	               	
				<c:forEach items="${certiManager4ReportUser}" var="certiUserVo">
					<c:if test="${certiUserVo.certi_state_val eq '손해사정사'}">
						<tr>
		                    <td>${certiUserVo.certi_state_val}</td>
		                    <td>${certiUserVo.user_name}</td>
		                    <td><img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50" height="50"></td>
		                    <td><c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone} </c:if></td>
		                </tr>
					</c:if>
				</c:forEach>
                <!-- <tr>
                    <td>손해사정사</td>
                    <td>윤경수</td>
                    <td><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></td>
                    <td>070-8255-3000</td>
                </tr> -->
                <%-- 담당 손해사정사 정보로 변경 끝 --%>
                <tr>
                    <td>팀&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장</td>
                    <td>
                        ${reportAprvUser.userName}<br/>
                        <c:if test="${reportAprvUser.workLevel != null && reportAprvUser.workLevel != ''}">
                            (${reportAprvUser.disWorkLevel})
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${reportAprvUser.userSign != null}">
                                <img width="50" height="50" src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${reportAprvUser.userNo}/${reportAprvUser.userSign}"/>
                            </c:when>
                            <c:otherwise>
                                사인없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reportAprvUser.handphone}</td>
                </tr>
                <tr>
                    <td>조 &nbsp;&nbsp;사 &nbsp;&nbsp;자</td>
                    <td>${reportInvgUser.userName } <br />(${reportInvgUser.disWorkLevel})</td>
                    <td>
                        <c:choose>
                            <c:when test="${reportInvgUser.userSign != null}">
                                <img width="50" height="50" src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${reportInvgUser.userNo}/${reportInvgUser.userSign}"/>
                            </c:when>
                            <c:otherwise>
                                사인없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reportInvgUser.handphone }</td>
                </tr>
            </table>
        </div>
        
        <script type="text/javascript">
				function fnContractEdit(){
					$("#div_contract_detail_view").hide();
					$("#btn_contract_edit").hide();
					$("#div_contract_detail_edit").show();
				}
				
				function fnContractClose(){
					$("#div_contract_detail_view").show();
					$("#btn_contract_edit").show();
					$("#div_contract_detail_edit").hide();					
				}
			
				function fnContractSave(){
					if($("#address").val() == ""){
						alert("주소를 입력해주세요.");
						$("#address").focus();
						return;
					}
					if($("#deduction_start_date").val() == ""){
						alert("공제시작일자를 입력해주세요.");
						$("#deduction_start_date").focus();
						return;
					}					
					if($("#deduction_end_date").val() == ""){
						alert("공제종료일자를 입력해주세요.");
						$("#deduction_end_date").focus();
						return;
					}					
					
					var param = {};
					param.rptPrintNo								=  $("#rpt_print_no").val();
 					param.suim_rpt_no							=  $("#suim_rpt_no").val();
					param.address   								=  $("#address").val();
					param.deduction_start_date   			=  $("#deduction_start_date").val();
					param.deduction_end_date  	    		=  $("#deduction_end_date").val();
					param.deduction_remarks   				=  $("#deduction_contract_remarks").val();
					param.stock_remarks   					=  $("#stock_remarks").val();
					param.contractor_remarks   				=  $("#contractor_remarks").val();
					param.worker_remarks   					=  $("#worker_remarks").val();
					param.address_remarks  					=  $("#address_remarks").val();
					param.deduction_period_remarks   	=  $("#deduction_period_remarks").val();
					param.compensation_limit_remarks	=  $("#compensation_limit_remarks").val();
					param.deduction_amount_remarks   	=  $("#deduction_amount_remarks").val();
					param.terms_remarks   					=  $("#terms_remarks").val();
					
					var url = "./report_contract_detail_update";
					
					$.ajax({
						type: "POST",
						url: url,
						data: param,
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						dataType: "html",
	                    timeout: 20000,
	                    success: function(data){
	                    	$("#div_contract_detail").html("");
							$("#div_contract_detail").html(data);
							alert("저장에 성공하였습니다.");

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
			
			<div id="div_contract_detail">
				<div id="div_contract_detail_view">        
			       	<div class="display-table" style="margin-top: 50px;">
			            <div class="display-cell">
			                <p class="subtitle">1. 공제계약사항</p>
			            </div>
				        <div class="display-cell text-right">
			               	<a id="btn_contract_edit" href="#noloc" onclick="fnContractEdit();"><img src='./resources/ne_img/btn_edite.gif'></a>
			           	</div>
			        </div>
		        	<table>
		        		<colgroup>
		        			<col width="20%">
		        			<col width="50%">
		        			<col width="15%">
		        			<col width="15%">
		        		</colgroup>	
		        		<tr> 
		        			<th>항     목</th>
		        			<th>계약사항</th>
		        			<th>계약사항검토</th>
		        			<th>비     고</th>
		        		</tr>
		     			<tr>
			     			<th>공제종목</th>
			     			<td>${reportBscInfo.insuranceNm}</td>
			     			<td>일치</td>
			     			<c:choose>
			     			<c:when test="${contractDetail.deductionRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.deductionRemarks}</td></c:otherwise>
			     			</c:choose>	
			     		</tr>	
		     			<tr>
			     			<th>증권번호</th>
			     			<td>${reportBscInfo.policyNo}</td>
			     			<td>일치</td>
		     				<c:choose>
			     			<c:when test="${contractDetail.stockRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.stockRemarks}</td></c:otherwise>
			     			</c:choose>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>계약자</th>
			     			<td>${reportBscInfo.policyholderNm}</td>
			     			<td>일치</td>
		     				<c:choose>
			     			<c:when test="${contractDetail.contractorRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.contractorRemarks}</td></c:otherwise>
			     			</c:choose>		     			
			     		</tr>
		     			<tr>
			     			<th>피공제자</th>
			     			<td>${reportBscInfo.beneficiaryNm}</td>
			     			<td>일치</td>
		     				<c:choose>
			     			<c:when test="${contractDetail.workerRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.workerRemarks}</td></c:otherwise>
			     			</c:choose>			     			
			     		</tr>
		     			<tr>
			     			<th>주       소</th>
			     			<td>${contractDetail.address}</td>
			     			<td>일치</td>
		     				<c:choose>
			     			<c:when test="${contractDetail.addressRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.addressRemarks}</td></c:otherwise>
			     			</c:choose>			     			
			     		</tr>		     		
		     			<tr>
			     			<th>공제기간</th>
			     			<td>${contractDetail.deductionStartDate} ~ ${contractDetail.deductionEndDate}</td>
			     			<td>공제기간 내</td>
		     				<c:choose>
			     			<c:when test="${contractDetail.deductionPeriodRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.deductionPeriodRemarks}</td></c:otherwise>
			     			</c:choose>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>보상한도</th>
			     			<td>법정보상 한도</td>
			     			<td>일치</td>
		     				<c:choose>
			     			<c:when test="${contractDetail.compensationLimitRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.compensationLimitRemarks}</td></c:otherwise>
			     			</c:choose>			     			
			     		</tr>		     		
		     			<tr>
			     			<th>공제금액</th>
			     			<td>-</td>
			     			<td>일치</td>
		     				<c:choose>
			     			<c:when test="${contractDetail.deductionAmountRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.deductionAmountRemarks}</td></c:otherwise>
			     			</c:choose>			     			
			     		</tr>		     		
		     			<tr>
			     			<th>적용약관</th>
			     			<td>해외근로자재해공제 보통 약관 <br />비업무상재해 확장 추가특별약관</td>
			     			<td>일치</td>
		     				<c:choose>
			     			<c:when test="${contractDetail.termsRemarks == ''}"><td>-</td></c:when>
			     			<c:otherwise><td>${contractDetail.termsRemarks}</td></c:otherwise>
			     			</c:choose>		     			
			     		</tr>		     				     					     		
		       			</table>
					</div>
				<div id="div_contract_detail_edit"  style="display: none;">  
					<div class="display-table" style="margin-top: 50px;">
			            <div class="display-cell">
			                <p class="subtitle">1. 공제계약사항</p>
			            </div>
				        <div class="display-cell text-right">
			               	<a id="btn_contract_save" href="#noloc" onclick="fnContractSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
			               	<a id="btn_contract_close" href="#noloc" onclick="fnContractClose();"><img src='./resources/ne_img/btn/btn_close.gif'></a>
			           	</div>
		        	</div>           
		        	<table>
		        		<colgroup>
		        			<col width="20%">
		        			<col width="50%">
		        			<col width="15%">
		        			<col width="15%">
		        		</colgroup>	
		        		<tr> 
		        			<th>항     목</th>
		        			<th>계약사항</th>
		        			<th>계약사항검토</th>
		        			<th>비     고</th>
		        		</tr>
		     			<tr>
			     			<th>공제종목</th>
			     			<td >${reportBscInfo.insuranceNm}</td>
			     			<td>일치</td>
			     			<td><input type="text" id="deduction_contract_remarks" value="${contractDetail.deductionRemarks}" maxlength="40"></td>		     			
			     		</tr>	
		     			<tr>
			     			<th>증권번호</th>
			     			<td>${reportBscInfo.policyNo}</td>
			     			<td>일치</td>
			     			<td><input type="text" id="stock_remarks" value="${contractDetail.stockRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>계약자</th>
			     			<td>${reportBscInfo.policyholderNm}</td>
			     			<td>일치</td>
			     			<td><input type="text" id="contractor_remarks"  value="${contractDetail.contractorRemarks}" maxlength="40"></td>		     			
			     		</tr>
		     			<tr>
			     			<th>피공제자</th>
			     			<td>${reportBscInfo.beneficiaryNm}</td>
			     			<td>일치</td>
			     			<td><input type="text" id="worker_remarks"  value="${contractDetail.workerRemarks}" maxlength="40"></td>		     			
			     		</tr>
		     			<tr>
			     			<th>주       소</th>
			     			<td>
			     				<input type="text" id="address" value="${contractDetail.address}">
			     			</td>
			     			<td>일치</td>
			     			<td><input type="text" id="address_remarks"  value="${contractDetail.addressRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>공제기간</th>
			     			<td style="text-align: center">
	                        	<input type="text" id="deduction_start_date" class="calendar" name="stDate" value="${contractDetail.deductionStartDate}" style="width: 100px;" value="${contractDetail.deductionStartDate}" maxlength="10"/> ~ 
	                        	<input type="text" id="deduction_end_date" class="calendar" name="edDate" value="${contractDetail.deductionEndDate}" style="width: 100px;" value="${contractDetail.deductionEndDate}" maxlength="10"/><br/>
	                    	</td>
			     			<td>공제기간 내</td>
			     			<td><input type="text" id="deduction_period_remarks" value="${contractDetail.deductionPeriodRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>보상한도</th>
			     			<td>법정보상 한도</td>
			     			<td>일치</td>
			     			<td><input type="text" id="compensation_limit_remarks" value="${contractDetail.compensationLimitRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>공제금액</th>
			     			<td>-</td>
			     			<td>일치</td>
			     			<td><input type="text" id="deduction_amount_remarks" value="${contractDetail.deductionAmountRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>적용약관</th>
			     			<td>해외근로자재해공제 보통 약관 <br />비업무상재해 확장 추가특별약관</td>
			     			<td>일치</td>
			     			<td><input type="text" id="terms_remarks" value="${contractDetail.termsRemarks}" maxlength="40"></td>		     			
			     		</tr>		     				     					     		
		       			</table>
				</div>
			</div>
        
        
        
        
		 <!-- 2. 청구공제금(추산) -->
        <div class="display-table" style="margin-top: 50px;">
            <div class="display-cell">
                <p class="subtitle">2. 청구공제금(추산)</p>
            </div>
			<div class="display-cell text-right">
              	<input type="text" id="exchange_rate_date" class="calendar" name="exchage_rate_date"  style="width: 30%;" maxlength="10" value="${reportPrint30.exchangeRateDate}"/>
				<a href="#noloc" id="btn_exchage_rate_save" onclick="fnExchangeDate();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
				
<%-- 				<c:if test="${reportPrint30.exchangeRateDate != null }"> --%>
					<a id="btn_insure_add" href="#noloc" onclick="fnOtherWorkerAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
<%--             	</c:if> --%>
            </div>
        </div>
        <script type="text/javascript">
        	function fnExchangeDate(){
        		if($("#exchange_rate_date").val() == ""){
        			alert("환율기준날짜를 선택해주세요.");
        			$("#exchange_rate_date").focus();
        			return;
        		}
        		
        		var param = {};
        		param.exchage_rate_date 	 = $("#exchange_rate_date").val();
        		param.suim_rpt_no			 	 = $("#suim_rpt_no").val();
        		
        		var url = "./report_exchange_date_update";
        		
    			$.ajax({
    				type: "POST",
    				url: url,
    				data: param,
    				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    				dataType: "html",
    				timeout: 20000,
    				success: function(data){
                    	$("#divPrintConstruction").html("");                        	
    					$("#divPrintConstruction").html(data); 
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
        	
       		function fnOtherWorkerAdd(){
       			$("#btn_insure_add").hide();
       			$("#tr_other_worker_add").show();
       		}
        	
            function fnOtherWorkerCancel() {
                $("#btn_insure_add").show();
                $("#tr_other_worker_add").hide();
            }
		
			function fnOtherWorkerSave(){
				if($("#worker_name").val() == ""){
					alert("재해근로자를 입력해 주세요.");
					$("#worker_name").focus();
					return;
				}
				if($("#worker_type").val() == ""){
					alert("구분을 선택해 주세요.");
					$("#worker_type").focus();
					return;
				}				
				if($("#ssn").val() == ""){
					alert(" 주민등록번호를 입력해 주세요.");
					$("#ssn").focus();
					return;
				}				
				if($("#country").val() == ""){
					alert("현장명을 입력해 주세요.");
					$("#country").focus();
					return;
				}	
				if($("#damage_amount").val() == ""){
					alert("손해액을 입력해 주세요.");
					$("#damaged_amount").focus();
					return;
				}	
			var selectCountry = $("#country").val();
			var param = {};
			param.rptPrintNo					= $("#rpt_print_no").val();
			param.worker_name				= $("#worker_name").val();
			param.worker_type 				= $("#worker_type option:selected").val();
			param.ssn 							= $("#ssn").val();
			
			if(selectCountry == "999"){
				param.country 				= $("#input_country").val();
			}else{
				param.country					= selectCountry;
			}
			param.damage_amount 		= $("#damage_amount").val().numDecimal();
			param.exchange_rate 			= $("#exchange_rate").val().numDecimal();
			param.deduction_amount 		= $("#deduction_amount").val().numDecimal();
			param.deduction_remarks		= $("#deduction_remarks").val();
			param.suimRptNo 				= $("#suim_rpt_no").val();
			param.unit 							= $("#unit").val();
			
			var url="./report_other_worker_insert";
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",
				timeout: 20000,
				success: function(data){
// 					$("#div_other_worker").html(data);
// 					fnOtherWorkerCancel();
                	$("#divPrintConstruction").html("");                        	
					$("#divPrintConstruction").html(data);
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
			
			
			function fnOtherWorkerEdit(idx){
				$("#tr_other_worker_view" + idx).hide();
				$("#tr_other_worker_edit" + idx).show();
			}
		
			function fnOtherWorkerClose(idx){
				$("#tr_other_worker_view" + idx).show();
				$("#tr_other_worker_edit" + idx).hide();
			}
		
			function fnOtherWorkerUpdate(serialNo,rptPrintNo,idx){
				
				if(confirm("수정하시겠습니까?")){	
					if($("#worker_name" + idx).val() == ""){
						alert("재해근로자를 입력해 주세요.");
						$("#worker_name" + idx).focus();
						return;
					}				
					if($("#worker_type" + idx).val() == ""){
						alert("구분을 선택해 주세요.");
						$("#worker_type" + idx).focus();
						return;
					}				
					if($("#ssn" + idx).val() == ""){
						alert("주민등록번호를 입력해 주세요.");
						$("#ssn" + idx).focus();
						return;
					}				
					if($("#country" + idx).val() == ""){
						alert("현장명을 입력해 주세요.");
						$("#country" + idx).focus();
						return;
					}	
					if($("#damage_amount" + idx).val() == ""){
						alert("손해액을 입력해 주세요.");
						$("#damaged_amount" + idx).focus();
						return;
					}	
					var selectCountry = $("#country" +idx).val();
					var param = {};
					param.rptPrintNo					= rptPrintNo;
					param.serial_no					= serialNo;
					param.worker_name				= $("#worker_name" + idx).val();
					param.worker_type 				= $("#worker_type" + idx).val();
					param.ssn 							= $("#ssn" + idx).val();
					
					if(selectCountry == "999"){
						param.country 				= $("#input_country" +idx).val();
					}else{
						param.country					= selectCountry;
					}
					param.damage_amount 		= $("#damage_amount" + idx).val().numDecimal();
					param.exchange_rate 			= $("#exchange_rate" + idx).val().numDecimal();
					param.deduction_amount 		= $("#deduction_amount" + idx).val().numDecimal();
					param.deduction_remarks		= $("#deduction_remarks" + idx).val();
					param.suimRptNo 				= $("#suim_rpt_no").val();
					param.unit 							= $("#unit" +idx).val();

					var url = "./report_other_worker_update";
					
					$.ajax({
						type: "POST",
						url: url,
						data: param,
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						dataType: "html",
						timeout: 20000,
	                    success: function(data){
                        	$("#divPrintConstruction").html("");  
							$("#divPrintConstruction").html(data); 
	                        alert("수정 성공하였습니다.");
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
			
            function fnOtherWorkerDelete(serialNo,rptPrintNo){
                if (confirm("삭제하시겠습니까?")){
                    var param = {};
					param.serialNo = serialNo;              
					param.rptPrintNo = rptPrintNo;
					param.suimRptNo = $("#suim_rpt_no").val();
					
                    var url = "./report_other_worker_delete";
					
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: param,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        dataType: "html",
                        timeout: 20000,
                        success: function(data){
                        	$("#divPrintConstruction").html("");                        	
							$("#divPrintConstruction").html(data);                        	
                            alert("삭제 성공하였습니다.");
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
          
//             function fnChgWorkerType(that){
// 				var workerType = that.value;
// 				if (workerType == 1){
// 					$("#deduction_remarks_span" ).html("전신환매도율");
// 					$("#deduction_remarks").val("전신환매도율");
					
// 					$("#deduction_remarks").attr("type","hidden");
// 				}else{
// 					$("#deduction_remarks_span").html("");					
// 					$("#deduction_remarks").attr("type","text");
// 				}
//             }


            function fnChgWorkerType(that,idx){
				var workerType = that.value;
				if (workerType == 1){
					$("#deduction_remarks_span"+idx ).html("전신환매도율");
					$("#deduction_remarks"+idx).val("전신환매도율");
					
					$("#deduction_remarks"+idx).attr("type","hidden");
				}else{
					$("#deduction_remarks_span"+idx).html("");
					$("#deduction_remarks"+idx).val("");
					
					$("#deduction_remarks"+idx).attr("type","text");
				}
            }
            
            function fnChgExchangeRate(that){
				var countryName = that.value;
				var countryUnit = $("#country option:selected").attr("unit");
				var countryRate = $("#country option:selected").attr("rate");
				
				$("#unit").val( countryUnit );
				$("#exchange_rate").val( countryRate );
            }
			            
            function fnDeductionCalc(that, idx){
				var countryName = that.value;
				var countryUnit = $("#country" + idx + " option:selected").attr("unit");
				var countryRate = $("#country" + idx + " option:selected").attr("rate");
				
				$("#unit"+ idx).val("");
				$("#exchange_rate"+ idx).val("");
				
				$("#unit"+ idx).val( countryUnit );
				$("#exchange_rate"+ idx).val( countryRate );
				
				if ($("#damage_amount"+idx).val() != ""){
					var tmpSum = Math.round($("#damage_amount"+idx).val().numDecimal() * $("#exchange_rate"+ idx).val().numDecimal());
					$("#deduction_amount"+idx).val(tmpSum);
				}
            }
        	function fnOnkeyDeductionCalc(idx,that){
    			var damage_amount = $("#damage_amount"+idx).val().numDecimal();
    			var exchange_rate = $("#exchange_rate"+idx).val().numDecimal();
    			var deductionSum	= 	Math.round(damage_amount * exchange_rate);
    			
    			$("#deduction_amount"+idx).val( deductionSum );
    			that.focus();
    			
        	}
            
        	function fnCountryInput(that, idx){
            	if(that.value == '999'){
            		$("#input_country" +idx).show();
            	}else{
            		$("#input_country" +idx).hide();
            	}
            }
			
        	function fnOnkeyLimitWordNumber(idx, that){
				if($(that).val().length == 7){
					alert('제한길이가 초과되었습니다.');
				}
        	};
        </script>
        <div id="div_other_worker">
        	<table>
        		<colgroup>
        			<col width="10%">
        			<col width="10%">
        			<col width="12%">
        			<col width="12%">
        			<col width="12%">
        			<col width="8%">
        			<col width="14%">
        			<col width="14%">
<%--         			<col width="11%"> --%>
        			<col width="8%">
        		</colgroup>	
        		<tr>
        			<th>재해근로자</th>
        			<th>구분</th>
        			<th>생년월일</th>
        			<th>현장명</th>
        			<th>손해액</th>
        			<th>단위</th>
        			<th>적용환율 <br />(전신환매도율)</th>
        			<th>청구공제금</th>
<!--         			<th>비고</th> -->
        			<th>-</th>
        		</tr>
        		
        		<tr id="tr_other_worker_add" style="display:none;">
        			<td class="deduction" >
        				<input type="text" id="worker_name" value="" maxlength="40">
        			</td>
        			<td class="deduction">
        				<select id="worker_type" onchange="fnChgWorkerType(this,'');" style="padding:0px;width:61px;" class="select_worker_type">
        					<option value="">-선택-</option>
							<option value="1">부책</option>
							<option value="2">면책</option>
							<option value="3">보완</option>
							<option value="4">일부보완</option>
        				</select>
        			</td>
					<td class="deduction">
        				<input type="text" id="ssn" value="" maxlength="7" onkeydown="fnOnkeyLimitWordNumber('',this);">
        			</td>
        			<td class="deduction">
        				<select class="country" id="country" onchange="fnDeductionCalc(this,'');fnCountryInput(this,'');"  style="width:100%;padding:0px;font-size:11px;">
        					<option value="0">-선택-</option>
        					<option value="999" style="font-size:11px;">직접입력</option>
        					<c:forEach var="item" items="${countryList}" varStatus="status" >
        						<option value="${item.country}" rate="${item.rateExchange}" unit="${item.countryUnit}">${item.country}</option>
        					</c:forEach>
        				</select>
        				<input type="text" id="input_country" style="display: none;" maxlength="80">
        			</td>
        			<td>
        				<input type="text" id="damage_amount" value="" class="inputMoney" maxlength="40" style="width:100%; padding-right: 0px;" onchange="fnOnkeyDeductionCalc('',this);">
        			</td>
        			<td class="deduction">
        				<input type="text" id="unit" value="" maxlength="80">
        			 </td>
        			 <td class="deduction">
        				<input type="text" id="exchange_rate" value="" class="inputMoney" maxlength="40" style="width:100%;" onchange="fnOnkeyDeductionCalc('',this);">
        			</td>
        			<td class="deduction">
        				<input type="text" id="deduction_amount" class="inputMoney" value="">
        			</td>
<!--         			 <td> -->
<!--        			 		<span id="deduction_remarks_span"></span> -->
<!--         				<input type="text" id="deduction_remarks" value="" maxlength="40"> -->
<!--         			</td> -->
        			<td style="text-align:center; padding:0px;">
        				<a href="#noloc" id="btn_insure_save" onclick="fnOtherWorkerSave();"><img src='./resources/ne_img/btn/btn_save.gif' ></a>
        				<a href="#noloc" id="btn_insure_cancel" onclick="fnOtherWorkerCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        			</td>	        		
        		</tr>        		
        		
        		
        		<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >
	        		<c:choose>
	        			<c:when test="${item.workerType == 1}">
	        				<c:set var="fontStyle" value='' />
        				 </c:when>
	        			<c:when test="${item.workerType == 2}"> 
	        				<c:set var="fontStyle" value='style="color:red;"' />
        				</c:when>
	        			<c:otherwise>
	        				<c:set var="fontStyle" value='' />
        				</c:otherwise>
	        		</c:choose>
	        		
	        		<tr id="tr_other_worker_view${status.index}">
	        			<td>
	        				<span ${fontStyle}> ${item.workerName}</span>
        				</td>
        				
	        			<td>
	        				<span ${fontStyle}> 
	        					<c:choose>
	        						<c:when test="${item.workerType == 1}">부책</c:when>
	        						<c:when test="${item.workerType == 2}">면책</c:when>
	        						<c:when test="${item.workerType == 3}">보완</c:when>
	        						<c:when test="${item.workerType == 4}">일부보완</c:when>
	        					</c:choose>
        					</span>
        				</td>
        				
	        			<td>
	        				<span ${fontStyle}> ${item.ssn}</span>
        				</td>
        				
	        			<td>
	        				<span ${fontStyle}> ${item.country}</span>
        				</td>
        				
	        			<td style="text-align: right">
	        				<span ${fontStyle} class="inputMoney">${item.damageAmount}&nbsp;</span>
        				</td>
        				
        				<td><!-- 단위 td -->
<%--         					<c:forEach var="exchange" items="${countryList}" varStatus="exchgStatus" > --%>
<%--         						<c:if test="${item.country == exchange.country}">${exchange.countryUnit}</c:if> --%>
<%--         					</c:forEach> --%>
							<span ${fontStyle}>${item.countryUnit}</span>
        				</td>        				      				
        				
			        	<td style="text-align: right">
<%-- 			        		<span ${fontStyle}><fmt:formatNumber value="${item.exchangeRate}" pattern="###,###,###.00"/>&nbsp;</span> --%>
			        		<span ${fontStyle} class="inputMoney">${item.exchangeRate}&nbsp;</span>
		        		</td>
		        		
	        			<td style="text-align: right">
        					<span ${fontStyle} class="inputMoney">${item.deductionAmount}</span>원
       					</td>
       					
<!-- 		        		<td> -->
<%-- 		        			<span ${fontStyle}> ${item.deductionRemarks}</span> --%>
<!-- 	        			</td> -->
	        			
		        		<td style="text-align:center">
		        			<a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherWorkerEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
		        			<a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherWorkerDelete('${item.serialNo}',${item.rptPrintNo});"><img src='./resources/ls_img/btn_del_s.gif'></a>
		        		</td>
	        		</tr>
	        		
        		 	<tr id="tr_other_worker_edit${status.index}" style="display: none;">
        				<td style="padding: 4px 1px 4px 1px;">
        					<input type="text" id="worker_name${status.index}" value="${item.workerName}" >
        					<input type="hidden" id="serial_no${status.index}" value="${item.serialNo}"/>
        				</td>
        				<td class="deduction">
	        				<select id="worker_type${status.index}" onchange="fnChgWorkerType(this,${status.index});" style="width:100%; padding:0px;" class="select_worker_type">
	        					<option value="" <c:if test="${item.workerType == ''}">selected="selected"</c:if>>-선택-</option>
								<option value="1" <c:if test="${item.workerType == 1}">selected="selected"</c:if>>부책</option>
								<option value="2" <c:if test="${item.workerType == 2}">selected="selected"</c:if>>면책</option>
								<option value="3" <c:if test="${item.workerType == 3}">selected="selected"</c:if>>보완</option>
								<option value="4" <c:if test="${item.workerType == 4}">selected="selected"</c:if>>일부보완</option>
	        				</select>     
        				</td>
        				<td class="deduction">
        					<input type="text" id="ssn${status.index}" value="${item.ssn}">
        				</td>
        				<td class="deduction">
	        				<select class="country"  id="country${status.index}" onchange="fnDeductionCalc(this,'${status.index}');fnCountryInput(this,'${status.index}');" style="width:100%; padding:0px;">
	        					<option value="0">-선택-</option>
	        					<c:set var="input_country" value="0" />
	        					<c:forEach var="exchange" items="${countryList}">
	        						<option value="${exchange.country}" <c:if test="${item.country == exchange.country}">selected="selected"</c:if> rate="${exchange.rateExchange}" unit="${exchange.countryUnit}">${exchange.country}</option>
	        						<c:if test="${item.country == exchange.country}">
	        							<c:set var="input_country" value="1"/>
	        						</c:if>
	        					</c:forEach>
	        					<option value="999" <c:if test="${input_country == 0}">selected</c:if>>직접입력</option>
	        				</select>
	        				        
        					<c:if test="${input_country == 0}">
        						<input type="text" id="input_country${status.index}" value="${item.country}" maxlength="80">				
        					</c:if>
        					<c:if test="${input_country == 1}">
        						<input type="text" id="input_country${status.index}" style="display: none;" maxlength="80">	
        					</c:if>			
        				</td> 
        				<td class="deduction">
        					<input type="text" id="damage_amount${status.index}" value="${item.damageAmount}" style="width:100%;padding-right: 0px;" class="inputMoney" onchange="fnOnkeyDeductionCalc('${status.index}',this);">
        				</td>
        				<td class="deduction">
							<input type="text" id="unit${status.index}" value="${item.countryUnit}">
        				</td>        				
        				<td style="padding: 4px 1px 4px 1px;">
        					<input type="text" id="exchange_rate${status.index}" value="${item.exchangeRate}" class="inputMoney" onchange="fnOnkeyDeductionCalc('${status.index}',this);">
        				</td>  
        				<td class="deduction">
        					<input type="text" id="deduction_amount${status.index}" class="inputMoney" value="${item.deductionAmount}">
        				</td>        				  
<!--         				<td> -->
<%--         					<c:choose> --%>
<%--         						<c:when test="${item.workerType == 1}"> --%>
<%--         							<span id="deduction_remarks_span${status.index}">전신환매도율</span> --%>
<%--         							<input type="hidden" id="deduction_remarks${status.index}" value="전신환매도율 " > --%>
<%--        							</c:when> --%>
<%--         						<c:otherwise> --%>
<%--         							<span id="deduction_remarks_span${status.index}"></span> --%>
<%--         							<input type="text" id="deduction_remarks${status.index}" value="${item.deductionRemarks}" > --%>
<%--         						</c:otherwise> --%>
<%--         					</c:choose> --%>
<!--         				</td>    -->
	        			<td style="text-align:center; padding:0px;" >
	        				<a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherWorkerUpdate('${item.serialNo}',${item.rptPrintNo},'${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	        				<a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherWorkerClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif'></a>
	        			</td>        				     				        				    				        				       				
        			</tr>
	        	</c:forEach>
	        		<tr>
	        			<td style="text-align:center;">합계</td>
	        			<td></td>
	        			<td></td>
	        			<td></td>
	        			<td></td>
	        			<td></td>
	        			<td></td>
	        			<td style="text-align:right;"><span class="inputMoney">${deductionSum}</span>원</td>
	        			<td></td>
	        		</tr>
        	</table>
        	</div>
        	<table>
				<tr >
<!-- 	            	<p style="margin-top: 0px; padding: 0px 5px;"> -->
						<td style="width:80%; border: 0px !important;font-size:13px;">※ 상기 환율은 ${reportPrint30.exchangeRateDate}일자 외환은행 국가별 최초고시 환율을 적용함  </td>
						<td style="text-align:right;width:20%;border: 0px !important; ">(단위 : 원)</td>
<!-- 	           	 	</p> -->
				</tr>
			</table>
			<div  style="float:right;">
               	<a href="constructionRptInfo?rpt_print_no=${reportPrint30.rptPrintNo}&cmd=excel1&suim_rpt_no=${param.suim_rpt_no}"><img src="./resources/ls_img/report/btn_excel.gif"></a>
            </div>
<!-- 			<div class="display-cell text-right">(단위 : 원) </div> -->
			
        <script type="text/javascript">
		function fnOtherWorkerPaymentSave(serialNo,rptPrintNo,idx){
			 if (confirm("수정하시겠습니까?")){
				if($("#payment_place" + idx).val() == ""){
					alert("지급처를 입력해 주세요.");
					$("#payment_place" + idx).focus();
					return;
				}				
				if($("#bank" + idx).val() == ""){
					alert("은행을 입력해 주세요.");
					$("#bank" + idx).focus();
					return;
				}				
				if($("#account_number" + idx).val() == ""){
					alert("계좌번호를 입력해 주세요.");
					$("#account_number" + idx).focus();
					return;
				}				

				
				var param = {};
				param.rptPrintNo					= rptPrintNo;
				param.serial_no					= serialNo;
				param.payment_place			= $("#payment_place" + idx).val();
				param.bank 						= $("#bank" + idx).val();
				param.account_number 		= $("#account_number" + idx).val();
				param.payment_amount		= $("#payment_amount" + idx).val().numDecimal();
				param.payment_remarks 		= $("#payment_remarks" + idx).val();
				param.suimRptNo 				= $("#suim_rpt_no").val();
				
				var url = "./report_other_worker_payment_insert";
				
				$.ajax({
					type: "POST",
					url: url,
					data: param,
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "html",
					timeout: 20000,
	                success: function(data){
                    	$("#divPrintConstruction").html("");                        	
						$("#divPrintConstruction").html(data); 
						alert("저장에 성공하였습니다.");
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
			function fnOtherWorkerPaymentEdit(idx){
				$("#tr_other_worker_payment_view" + idx).hide();
				$("#tr_other_worker_payment_update" + idx).show();
			}
		
			function fnOtherWorkerPaymentCancel(idx){
				$("#tr_other_worker_payment_view" + idx).show();
				$("#tr_other_worker_payment_update" + idx).hide();				
			}
      
        </script>
        
        <div id="div_other_worker_payment">               
	         <div class="display-table" style="margin-top: 50px;">
	            <div class="display-cell">
	                <p class="subtitle">3. 지급공제금 지급처</p>
	            </div>
	        </div>
        
        	<table>
        		<colgroup>
        			<col width="15%">
        			<col width="10%">
        			<col width="10%">
        			<col width="25%">
        			<col width="20%">
        			<col width="12%">
        			<col width="8%">
        		</colgroup>	
        		<tr>
        			<th>지급처</th>
        			<th>대상자</th>
        			<th>은행명</th>
        			<th>계좌번호</th>
        			<th>지급액</th>
        			<th>비고</th>
        			<th>-</th>
        		</tr>
        		
        		<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >	        		
	        		<c:if test="${item.workerType == 1 || item.workerType == 4}">
			     		<tr id="tr_other_worker_payment_view${status.index}">
			     			<td>${item.paymentPlace}</td>
			     			<td>${item.workerName}</td>
			     			<td>${item.bank}</td>
			     			<td>${item.accountNumber}</td>
			     			<td style="text-align: right">
			     				<span class="inputMoney">${item.paymentAmount}</span>원
		     				</td>
			     			<td>${item.paymentRemarks}</td>
			     			<td style="text-align:center">
			      			<a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherWorkerPaymentEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
			      			<a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherWorkerDelete('${item.serialNo}',${item.rptPrintNo});"><img src='./resources/ls_img/btn_del_s.gif'></a>	        			
			     			</td> 
			     		</tr>
	        		
			     		<tr id="tr_other_worker_payment_update${status.index}" style="display: none;">
			     			<td>
			     				<input type="text" id="payment_place${status.index}" value="${item.paymentPlace}" maxlength="40">
			     			</td>
			     			<td>${item.workerName}</td>
			     			<td>
			     				<input type="text" id="bank${status.index}" value="${item.bank}" maxlength="40">
			     			</td>
			     			<td>
			     				<input type="text" id="account_number${status.index}" value="${item.accountNumber}" maxlength="40">
			     			</td>
			     			<td>
			     				<input type="text" id="payment_amount${status.index}" value="${item.paymentAmount}" class="inputMoney" maxlength="40">
			     			</td>
			     			<td>
			     				<input type="text" id="payment_remarks${status.index}" value="${item.paymentRemarks}" maxlength="40">
			     			</td>
			     			<td style="text-align:center">
			     				<a href="#noloc" id="btn_insure_save" onclick="fnOtherWorkerPaymentSave('${item.serialNo}',${item.rptPrintNo},'${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
			     				<a href="#noloc" id="btn_insure_cancel" onclick="fnOtherWorkerPaymentCancel('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
			     			</td>
			     		</tr>
		     		</c:if>
        		</c:forEach>
       			<tr>
        			<td style="text-align:center;">총계</td>
        			<td></td>
        			<td></td>
        			<td></td>
        			<td style="text-align:right;"><span class="inputMoney">${paymentSum}</span>원</td>
        			<td></td>
        			<td></td>
        		</tr>
       		</table>
		</div>
		<br />
		<div  style="float:right;">
			<a href="constructionRptInfo?rpt_print_no=${reportPrint30.rptPrintNo}&cmd=excel2&suim_rpt_no=${param.suim_rpt_no}"><img src="./resources/ls_img/report/btn_excel.gif"></a>
        </div>	
			

			
		<script type="text/javascript">
		function fnCompensationSave(idx){
			

			if($("#disease").val() == ""){
				alert("질병을 입력해주세요.");
				$("#disease").focus();
				return;
			}
			if($("#rewarded_dmg_type option:selected").val() == ""){
				alert("손해규정을 선택해주세요.");
				$("#rewarded_dmg_type").focus();
				return;
			}					
			if($("#unrewarded_dmg_type option:selected").val() == ""){
				alert("관련법규를 선택해주세요.");
				$("#unrewarded_dmg_type").focus();
				return;
			}					
			
			var param = {};
// 			$("#judgement_reason").each(function(idx)){
// 				alert(idx);
// 				var reason = $("#judgement_reason" +idx).val();
// 			}
			
// 			var reason = $("#judgement_reason" +idx).val();
			

			//여기서부터 찾아볼 것
			//1. document.getElementsByName
			//2. $(obj).each(function(i)
			//3. arr1.push($(this).val());
			//4. $.ajaxSettings.traditional = true;
			
			var serialNo = document.getElementsByName("worker_serial_no");
			var reason = document.getElementsByName("judgement_reason");
		   
			var serialNoArr = [];
			var reasonArr = [];
		    
		    $(serialNo).each(function(i) {
		    	serialNoArr.push($(this).val());
		    });
		    
		    $(reason).each(function(i) {
		    	reasonArr.push($(this).val());
		    });
		    
		    $.ajaxSettings.traditional = true;
		    
			param.rptPrintNo								=  $("#rpt_print_no").val();
			param.suimRptNo 							=  $("#suim_rpt_no").val();
			param.disease  	    						=  $("#disease").val();
// 			param.rewarded_dmg_type   			=  $("#rewarded_dmg_type").val();
// 			param.unrewarded_dmg_type   			=  $("#unrewarded_dmg_type").val();
// 			param.standard_disease					=  $("#standard_disease").val();
			param.judgement_reason					=  $("#judgement_reason" +idx).val();
			param.serialNo = serialNoArr;
			param.reason = reasonArr;
			
			
			var url = "./report_compensation_response_update";
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",
                timeout: 20000,
                success: function(data){
//                 	$("#div_compensation_response").html("");
// 					$("#div_compensation_response").html(data);
                	$("#divPrintConstruction").html("");                        	
					$("#divPrintConstruction").html(data); 
					alert("저장에 성공하였습니다.");
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
		
		function fnCompensationEdit(){
			$("#div_compensation_response_edit").show();				
			$("#div_compensation_response_view").hide();
		}
		
		function fnCompensationClose(){
			$("#div_compensation_response_edit").hide();				
			$("#div_compensation_response_view").show();
		}
		
        function fnShowUnrewardType(that, idx){
        	var unrewardType = that.value;
        	if(unrewardType == 5){
        		$("#standard_disease" +idx).show();
        	}else{
        		$("#standard_disease" +idx).hide();
        	}
        }
        
        function fnSetJudgeReason(that,idx){
			//var policyNm = "${reportBscInfo.beneficiaryNm}";
			//var disease = $("#disease").val();
// 			$("#unrewarded_dmg_type option:selected").val();
			var m1 = $("#rwd_dmg_type1" +idx+ " option:selected").text();
			var m2 = $("#unrewarded_dmg_type" +idx+ " option:selected").text();

			var no_provide_worker = $("#no_provide_worker" +idx).attr("worker");
// 			alert(no_provide_worker);
			
			if(idx == 0){
				var str1 = "그러나 피보험자 " + no_provide_worker + "인 경우 " + m1 + "에 해당되지 않은 손해, 즉 " + m2 + "에 해당되어 보험금 지급 책임이 없습니다.";
			}else{
				var str1 = "피보험자 " + no_provide_worker + "인 경우 " + m1 + "에 해당되지 않은 손해, 즉 " + m2 + "에 해당되어 보험금 지급 책임이 없습니다.";
			}
			
			$("#judgement_reason" +idx).val("");
			$("#judgement_reason" +idx).val(str1);
        }
        
        function fnSetJudgeReasonDisease(that,idx){
        	var m1 = $("#rwd_dmg_type1" +idx+ " option:selected").text();
			var m2 = $("#unrewarded_dmg_type" +idx+ " option:selected").text();
			var m3 = $("#standard_disease" +idx+ " option:selected").text();
			
			var no_provide_worker = $("#no_provide_worker" +idx).attr("worker");
			
			if(idx == 0){
				var str1 = "그러나 피보험자 " + no_provide_worker + "인 경우 " + m1 + "에 해당되지 않은 손해, 즉 " + m2 + "(" + m3 + ") 에 해당되어 보험금 지급 책임이 없습니다.";
			}else{
				var str1 = "피보험자 " + no_provide_worker + "인 경우 " + m1 + "에 해당되지 않은 손해, 즉 " + m2 + "(" + m3 + ") 에 해당되어 보험금 지급 책임이 없습니다.";
				
			}
        	
			$("#judgement_reason" +idx).val("");
			$("#judgement_reason" +idx).val(str1);
        }
        
        
		</script>	
			
			
		<div id="div_compensation_response">	
				
	     <div id="div_compensation_response_view">               
	        <div class="display-table" style="margin-top: 50px;">
	            <div class="display-cell">
	                <p class="subtitle">4. 보상책임 등 검토</p>
	            </div>
		        <div class="display-cell text-right">
	              	<a id="btn_compensation_edit" href="#noloc" onclick="fnCompensationEdit();"><img src='./resources/ne_img/btn_edite.gif'></a>
	          	</div>
	        </div>
        	<table>
        		<colgroup>
        			<col width="20%">
        			<col width="80%">
        		</colgroup>	
        		<tr>
        			<th colspan="2">가. 피보험자의 보상책임</th>
        		</tr>
	     		<tr>
	     			<td>면  /  부  책</td>
	     			<td>
	     				${reportOtherWorkerList.size()}명 중
	     				${workerType2}명 면책 / ${workerType1}명 부책 
     				</td>
	     		</tr>
	     		<tr>
	     			<td>판  단  근  거</td>
	     			<td>
	     			 본 건 사고는 재해근로자 
	     			 	<c:if test="${reportOtherWorkerList.size() != 0}">(${reportWorkerType1[0].workerName} 외 ${reportOtherWorkerList.size()-workerType2-workerType3 -1}명)</c:if>
	     			  가 해외현장 근무 중 ${reportPrint30.disease} 외  질병 및 상해사고가 발현하여 요양후 청구한 사고로,
	     			 재해근로자의 상병명은 업무기인성 및 업무수행성이 인정되지 않는 점, 공제기간내에 발생된 점, 본 공제약관상 비업무상재해확장담보 추가 특별약관상 보상하지 않는 손해에 해당되지 아니한 점등을 근거로 판단해 볼 때,
	     			 보험금 지급에 대한 보상 책임이 있는 것으로 사료되어 지급하고자 합니다.
	     			 <c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status">
	     			 	<c:if test="${item.workerType == 2}">
	     			 		${item.judgementReason}
	     			 	</c:if>
	     			 </c:forEach>
	     			 <!-- 
 	     			<c:if test="${workerType2 != 0}">
		     			<div id="ischeck">
			     			그러나, 피보험자
			     			<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >
				     			<c:if test="${item.workerType == 2}">
				     			 	${item.workerName} 
				     			</c:if>
			     			</c:forEach>
		     			 	의 경우 해외근로자재해공제 보통약관 제2관 제3조 보상하는 손해 규정 중<br />
			     			<c:if test="${reportPrint30.rewardedDamageType == 1}">
			     				<span style="color:red;">① 조합은 피공제자의 근로자에게 생긴 업무상의 재해로 인하여 피공제자가 부담하는 손해를 이 약관 및 특별약관의 규정에 따라 보상하여 드립니다.</span>
			     			</c:if>
							<c:if test="${reportPrint30.rewardedDamageType == 2}">
			     				<span style="color:red;">② 조합은 재해의 원인이 된 사실이 공제기간 중에 생긴 경우에 한하여 보상하여 드립니다.</span>
			     			</c:if>
			     			에 해당되지 않은 손해, <br />즉 
			     			
			     			<c:if test="${reportPrint30.unrewardedDamageType ==1}">
								가입전 질병
			     			</c:if>
							<c:if test="${reportPrint30.unrewardedDamageType == 2}">
								중독, 마취, 만취 등으로 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 3}">
			     				과격한 운동이나 위험한 오락(스카이다이빙, 스쿠버다이빙, 행글라이딩, 자동차경주 등)으로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 4}">
			     				자해, 자살, 자살미수 및 이와 유사한 행위로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 5}">
			     				한국 표준질병 사인분류에 아래와 같이 분류된 질병 및 이로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 6}">
			     				매독, 임질, AIDS, 기타 이와 유사한 질병 및 이로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 7}">
			     				시력감퇴 등 생리적 노화 또는 약화 및 이로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 8}">
			     				치아에 관련된 질병 및 이로 인하여 생긴 손해
			     			</c:if>			     			
							<c:if test="${reportPrint30.unrewardedDamageType == 9}">
			     				군인이 아닌자로서 군사작전을 수행하거나 군사훈련을 받는 중에 생긴 손해
			     			</c:if>	
			     			
			     			<c:if test="${reportPrint30.unrewardedDamageType == 5}">
				     			<c:if test="${reportPrint30.standardDisease == 1}">(악성 신생물)</c:if>
				     			<c:if test="${reportPrint30.standardDisease == 2}">(당뇨병)</c:if>
				     			<c:if test="${reportPrint30.standardDisease == 3}">(만성 류마티스성 심질환)</c:if>
				     			<c:if test="${reportPrint30.standardDisease == 4}">(고혈압성 질환)</c:if>
				     			<c:if test="${reportPrint30.standardDisease == 5}">(허혈성 심질환)</c:if>
				     			<c:if test="${reportPrint30.standardDisease == 6}">(기타형의 심 질환)</c:if>
				     			<c:if test="${reportPrint30.standardDisease == 7}">(뇌혈관 질환)</c:if>
			     			</c:if>
			     			에 해당되어 보험금 지급 책임이 없습니다.
		     			</div>
	     			</c:if> 
	     			 -->    			  
	     			</td>
	     		</tr>
	     		<tr>
	     			<td>관련법규</td>
	     			<td>비업무상재해확장담보 추가특별약관</td>
	     		</tr>	     		
       			</table>
			</div>
			<div id="div_compensation_response_edit" style="display: none;">               
		        <div class="display-table" style="margin-top: 50px;">
		            <div class="display-cell">
		                <p class="subtitle">4. 보상책임 등 검토</p>
		            </div>
		        <div class="display-cell text-right">
	              	<a id="btn_compensation_save" href="#noloc" onclick="fnCompensationSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	              	<a id="btn_compensation_close" href="#noloc" onclick="fnCompensationClose();"><img src='./resources/ne_img/btn/btn_close.gif'></a>
	          	</div>
		        </div>
	        	<table>
	        		<colgroup>
	        			<col width="25%">
	        			<col width="75%">
	        		</colgroup>	
	        		<tr>
	        			<th colspan="2">가. 피보험자의 보상책임</th>
	        		</tr>
		     		<tr>
		     			<td>면  /  부  책</td>
		     			<td>
		     				${reportOtherWorkerList.size()}명 중
		     				${workerType2}명 면책 / ${workerType1}명 부책 		     			
						</td>
		     		</tr>
		     		<tr>
		     			<td>질병</td>
		     			<td><input type="text" id="disease" maxlength="40" value="${reportPrint30.disease}"></td>
		     		</tr>
		     		
		     		<c:forEach var="item" items="${reportWorkerType2}" varStatus="status" >
<%-- 			     		<c:if test="${item.workerType == 2}"> --%>
				     		<tr>
				     			<td id="no_provide_worker${status.index}" worker="${item.workerName}">면책자 ${item.workerName}
				     				<input type="hidden"  name="worker_serial_no" id="worker_serial_no" value="${item.serialNo}">
				     			</td>
				     			<td>
				     				<select id="rwd_dmg_type1${status.index}">
				     					<option value="1" <c:if test="${reportPrint30.rewardedDamageType == 1}">selected="selected"</c:if>>조합은 피공제자의 근로자에게 생긴 업무상의 재해로 인하여 피공제자가 부담하는 손해를 이 약관 및 특별약관의 규정에 따라 보상하여 드립니다</option>
				     					<option value="2" <c:if test="${reportPrint30.rewardedDamageType == 2}">selected="selected"</c:if>>조합은 재해의 원인이 된 사실이 공제기간 중에 생긴 경우에 한하여 보상하여 드립니다</option>
				     				</select>에 해당되지 않은 손해, 즉 <br />
				     				<select id="unrewarded_dmg_type${status.index}" onchange="fnShowUnrewardType(this,'${status.index}');fnSetJudgeReason(this,'${status.index}')">
				       					<option value="1" <c:if test="${reportPrint30.unrewardedDamageType == 1}">selected="selected"</c:if>>가입전 질병</option>
				       					<option value="2" <c:if test="${reportPrint30.unrewardedDamageType == 2}">selected="selected"</c:if>>중독, 마취, 만취 등으로 생긴 손해</option>
										<option value="3" <c:if test="${reportPrint30.unrewardedDamageType == 3}">selected="selected"</c:if>>과격한 운동이나 위험한 오락(스카이다이빙, 스쿠버다이빙, 행글라이딩, 자동차경주 등)으로 인하여 생긴 손해</option>
										<option value="4" <c:if test="${reportPrint30.unrewardedDamageType == 4}">selected="selected"</c:if>>자해, 자살, 자살미수 및 이와 유사한 행위로 인하여 생긴 손해</option>
										<option value="5" <c:if test="${reportPrint30.unrewardedDamageType == 5}">selected="selected"</c:if>>한국 표준질병 사인분류에 아래와 같이 분류된 질병 및 이로 인하여 생긴 손해</option>
										<option value="6" <c:if test="${reportPrint30.unrewardedDamageType == 6}">selected="selected"</c:if>>매독, 임질, AIDS, 기타 이와 유사한 질병 및 이로 인하여 생긴 손해</option>
										<option value="7" <c:if test="${reportPrint30.unrewardedDamageType == 7}">selected="selected"</c:if>>시력감퇴 등 생리적 노화 또는 약화 및 이로 인하여 생긴 손해</option>
										<option value="8" <c:if test="${reportPrint30.unrewardedDamageType == 8}">selected="selected"</c:if>>치아에 관련된 질병 및 이로 인하여 생긴 손해</option>
										<option value="9" <c:if test="${reportPrint30.unrewardedDamageType == 9}">selected="selected"</c:if>>군인이 아닌자로서 군사작전을 수행하거나 군사훈련을 받는 중에 생긴 손해</option>
				       				</select>	
				       				<c:if test="${reportPrint30.unrewardedDamageType == 5}">
					       				<select id="standard_disease${status.index}" onchange="fnSetJudgeReasonDisease(this,'${status.index}')">
					       					<option value="1" <c:if test="${reportPrint30.standardDisease == 1}">selected="selected"</c:if>>악성 신생물</option>
					       					<option value="2" <c:if test="${reportPrint30.standardDisease == 2}">selected="selected"</c:if>>당뇨병</option>
					       					<option value="3" <c:if test="${reportPrint30.standardDisease == 3}">selected="selected"</c:if>>만성 류마티스성 심질환</option>
					       					<option value="4" <c:if test="${reportPrint30.standardDisease == 4}">selected="selected"</c:if>>고혈압성 질환</option>
					       					<option value="5" <c:if test="${reportPrint30.standardDisease == 5}">selected="selected"</c:if>>허혈성 심질환</option>
					       					<option value="6" <c:if test="${reportPrint30.standardDisease == 6}">selected="selected"</c:if>>기타형의 심질환</option>
					       					<option value="7" <c:if test="${reportPrint30.standardDisease == 7}">selected="selected"</c:if>>뇌혈관 질환</option>
					       				</select>
				       				</c:if>
				       					<select id="standard_disease${status.index}" style="display: none;" onchange="fnSetJudgeReasonDisease(this,'${status.index}')">
					       					<option value="1" <c:if test="${reportPrint30.standardDisease == 1}">selected="selected"</c:if>>악성 신생물</option>
					       					<option value="2" <c:if test="${reportPrint30.standardDisease == 2}">selected="selected"</c:if>>당뇨병</option>
					       					<option value="3" <c:if test="${reportPrint30.standardDisease == 3}">selected="selected"</c:if>>만성 류마티스성 심질환</option>
					       					<option value="4" <c:if test="${reportPrint30.standardDisease == 4}">selected="selected"</c:if>>고혈압성 질환</option>
					       					<option value="5" <c:if test="${reportPrint30.standardDisease == 5}">selected="selected"</c:if>>허혈성 심질환</option>
					       					<option value="6" <c:if test="${reportPrint30.standardDisease == 6}">selected="selected"</c:if>>기타형의 심질환</option>
					       					<option value="7" <c:if test="${reportPrint30.standardDisease == 7}">selected="selected"</c:if>>뇌혈관 질환</option>
					       				</select>
				       				에 해당되어 보험금 지급 책임이 없습니다.
				     				<textarea name="judgement_reason" id="judgement_reason${status.index}" style="height:80px;">${item.judgementReason}</textarea>
				     			</td>
				     		</tr>
				     		<!-- 
				     		<tr>
				     			<td>면책자</td>
				     			<td>
				       				<select id="rewarded_dmg_type" onchange="" >
				       					<option value="1" <c:if test="${reportPrint30.rewardedDamageType == 1}">selected="selected"</c:if>>조합은 피공제자의 근로자에게 생긴 업무상의 재해로 인하여 피공제자가 부담하는 손해를 이 약관 및 특별약관의 규정에 따라 보상하여 드립니다</option>
										<option value="2" <c:if test="${reportPrint30.rewardedDamageType == 2}">selected="selected"</c:if>>조합은 재해의 원인이 된 사실이 공제기간 중에 생긴 경우에 한하여 보상하여 드립니다</option>
				       				</select><br />에 해당되지 않은 손해, 즉 <br />
				       				<select id="unrewarded_dmg_type" onchange="fnShowUnrewardType(this);">
				       					<option value="1" <c:if test="${reportPrint30.unrewardedDamageType == 1}">selected="selected"</c:if>>가입전 질병</option>
				       					<option value="2" <c:if test="${reportPrint30.unrewardedDamageType == 2}">selected="selected"</c:if>>중독, 마취, 만취 등으로 생긴 손해</option>
										<option value="3" <c:if test="${reportPrint30.unrewardedDamageType == 3}">selected="selected"</c:if>>과격한 운동이나 위험한 오락(스카이다이빙, 스쿠버다이빙, 행글라이딩, 자동차경주 등)으로 인하여 생긴 손해</option>
										<option value="4" <c:if test="${reportPrint30.unrewardedDamageType == 4}">selected="selected"</c:if>>자해, 자살, 자살미수 및 이와 유사한 행위로 인하여 생긴 손해</option>
										<option value="5" <c:if test="${reportPrint30.unrewardedDamageType == 5}">selected="selected"</c:if>>한국 표준질병 사인분류에 아래와 같이 분류된 질병 및 이로 인하여 생긴 손해</option>
										<option value="6" <c:if test="${reportPrint30.unrewardedDamageType == 6}">selected="selected"</c:if>>매독, 임질, AIDS, 기타 이와 유사한 질병 및 이로 인하여 생긴 손해</option>
										<option value="7" <c:if test="${reportPrint30.unrewardedDamageType == 7}">selected="selected"</c:if>>시력감퇴 등 생리적 노화 또는 약화 및 이로 인하여 생긴 손해</option>
										<option value="8" <c:if test="${reportPrint30.unrewardedDamageType == 8}">selected="selected"</c:if>>치아에 관련된 질병 및 이로 인하여 생긴 손해</option>
										<option value="9" <c:if test="${reportPrint30.unrewardedDamageType == 9}">selected="selected"</c:if>>군인이 아닌자로서 군사작전을 수행하거나 군사훈련을 받는 중에 생긴 손해</option>
				       				</select>	
				       				<c:if test="${reportPrint30.unrewardedDamageType == 5}">
					       				<select id="standard_disease">
					       					<option value="1" <c:if test="${reportPrint30.standardDisease == 1}">selected="selected"</c:if>>악성 신생물</option>
					       					<option value="2" <c:if test="${reportPrint30.standardDisease == 2}">selected="selected"</c:if>>당뇨병</option>
					       					<option value="3" <c:if test="${reportPrint30.standardDisease == 3}">selected="selected"</c:if>>만성 류마티스성 심질환</option>
					       					<option value="4" <c:if test="${reportPrint30.standardDisease == 4}">selected="selected"</c:if>>고혈압성 질환</option>
					       					<option value="5" <c:if test="${reportPrint30.standardDisease == 5}">selected="selected"</c:if>>허혈성 심질환</option>
					       					<option value="6" <c:if test="${reportPrint30.standardDisease == 6}">selected="selected"</c:if>>기타형의 심질환</option>
					       					<option value="7" <c:if test="${reportPrint30.standardDisease == 7}">selected="selected"</c:if>>뇌혈관 질환</option>
					       				</select>
				       				</c:if>
				       					<select id="standard_disease" style="display: none;">
					       					<option value="1" <c:if test="${reportPrint30.standardDisease == 1}">selected="selected"</c:if>>악성 신생물</option>
					       					<option value="2" <c:if test="${reportPrint30.standardDisease == 2}">selected="selected"</c:if>>당뇨병</option>
					       					<option value="3" <c:if test="${reportPrint30.standardDisease == 3}">selected="selected"</c:if>>만성 류마티스성 심질환</option>
					       					<option value="4" <c:if test="${reportPrint30.standardDisease == 4}">selected="selected"</c:if>>고혈압성 질환</option>
					       					<option value="5" <c:if test="${reportPrint30.standardDisease == 5}">selected="selected"</c:if>>허혈성 심질환</option>
					       					<option value="6" <c:if test="${reportPrint30.standardDisease == 6}">selected="selected"</c:if>>기타형의 심질환</option>
					       					<option value="7" <c:if test="${reportPrint30.standardDisease == 7}">selected="selected"</c:if>>뇌혈관 질환</option>
					       				</select>
				       				에 해당되어 보험금 지급 책임이 없습니다.
				       				
				     			</td>
				     		</tr> -->
<%-- 			     		</c:if> --%>
		     		</c:forEach>
		     		
		     		<tr>
		     			<td>관련법규</td>
		     			<td>비업무상재해확장담보 추가특별약관</td>
		     		</tr>	     		
	       		</table>
			</div>			
       	</div>
				
		<script type="text/javascript">
		function fnAccidentDateUpdate(serialNo, rptPrintNo, idx){
			if($("#accident_date" + idx).val() == ""){
				alert("사고일자를 입력해주세요.");
				$("#accident_date" + idx).focus();
				return;
			}		
			
			var param = {};
			param.rptPrintNo							=  rptPrintNo;
			param.serial_no							=  serialNo;
			param.suim_rpt_no 						=  $("#suim_rpt_no" ).val();
			param.accident_date   					=  $("#accident_date" + idx).val();
			param.immunity_reason    			=  $("#immunity_reason" + idx).val();
			param.edited_deduction_amount   =  $("#edited_deduction_amount" +idx).val().numDecimal();
			param.suimRptNo 						=  $("#suim_rpt_no").val();
			
			
			var url = "./report_accident_date_update";
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",
                timeout: 20000,
                success: function(data){
                	$("#divPrintConstruction").html("");                        	
					$("#divPrintConstruction").html(data); 
					alert("저장에 성공하였습니다.");
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
		
		function fnImmunityEdit(idx){
			$("#tr_immunity_view" +idx).hide();				
			$("#tr_immunity_edit" +idx).show();			
		}
		
		function fnImmunityClose(idx){
			$("#tr_immunity_view" +idx).show();
			$("#tr_immunity_edit" +idx).hide();
		}		
		
		function fnSupplementUpdate(serialNo , rptPrintNo, idx){
			if($("#accident_supplement_date" +idx).val() == ""){
				alert("사고일자를 입력해주세요.");
				$("#accident_supplement_date" +idx).focus();
				return;
			}		
			
			var param = {};
			param.rptPrintNo							 =  rptPrintNo;
			param.serial_no							 =  serialNo;
			param.suimRptNo 						 =  $("#suim_rpt_no").val();
			param.accident_supplement_date	 =  $("#accident_supplement_date" +idx).val();
			param.supplement_reason   			 =  $("#supplement_reason" +idx).val();
			param.part_supplement_amount 	 =  $("#part_supplement_amount" +idx).val().numDecimal();
			
// 			console.log(param);
// 			return;
			var url = "./report_supplement_accident_date_update";
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",
                timeout: 20000,
                success: function(data){
                	$("#divPrintConstruction").html("");                        	
					$("#divPrintConstruction").html(data); 
					alert("저장에 성공하였습니다.");
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
		
		
		function fnSupplementEdit(idx){
			$("#tr_supplement_view" +idx).hide();				
			$("#tr_supplement_edit" +idx).show();			
		}
		
		function fnSupplementClose(idx){
			$("#tr_supplement_view" +idx).show();
			$("#tr_supplement_edit" +idx).hide();
		}			
		
		
		</script>		
				
		<!--          면책건            -->			
   <div class="display-table" style="margin-top: 50px;">
       <div class="display-cell">
           <p class="subtitle">5. 면책건 및 삭감</p>
       </div>
   </div>
        
    <div id="div_immunity">
	     <table>
       		<colgroup>
       			<col width="15%">
       			<col width="20%">
       			<col width="15%">
       			<col width="15%">
       			<col width="26%">
       			<col width="9%">
       		</colgroup>	
       		<tr>
       			<th>성명</th>
       			<th>사고일자</th>
       			<th>국가</th>
       			<th>금액(원)</th>
       			<th>면책사유</th>
       			<th>-</th>
       		</tr>
     	<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >	
       		<c:if test="${item.workerType == 2}">
				<tr id="tr_immunity_view${status.index}">               
	     			<td>${item.workerName}</td>
		     		<td>${item.accidentDate}</td>		     			
	     			<td>${item.country}</td>
	     			<td style="text-align: right">
	     				<c:choose>
		     				<c:when test="${item.editedDeductionAmount == null }">
		     					<span  class="inputMoney">${item.deductionAmount}</span>원
		     				</c:when>
		     				<c:otherwise>
		     					<span  class="inputMoney">${item.editedDeductionAmount}</span>원
		     				</c:otherwise>
	     				</c:choose>  	     			
	     			</td>
<%-- 	     			<td style="text-align: right"><span class="inputMoney">${item.deductionAmount}</span>원</td> --%>
	     			<td>${item.immunityReason}</td>
	     			<td style="text-align:center">
	      				<a href="#noloc" id="btn_immunity_edit${status.index}" onclick="fnImmunityEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
	     			</td> 
				</tr>				
				<tr id="tr_immunity_edit${status.index}" style="display: none;">               
	     			<td>${item.workerName}</td>
		     		<td style="text-align: center">
	                       <input type="text" id="accident_date${status.index}" class="calendar" name="stDate" value="${item.accidentDate}"  style="width:90px;" maxlength="10"/> <br/>
	                   </td>		     			
	     			<td>${item.country}</td>
	     				<c:choose>
		     				<c:when test="${item.editedDeductionAmount == null }">
			     				<td style="text-align: right"><input type="text" id="edited_deduction_amount${status.index}" class="inputMoney" value="${item.deductionAmount}" maxlength="40"></td>
		     				</c:when>
		     				<c:otherwise>
			     				<td style="text-align: right"><input type="text" id="edited_deduction_amount${status.index}" class="inputMoney" value="${item.editedDeductionAmount}" maxlength="40"></td>
		     				</c:otherwise>
	     				</c:choose>   			
<%-- 	     			<td style="text-align: right"><span class="inputMoney">${item.deductionAmount}</span>원</td> --%>
	     			<td><input type="text" id="immunity_reason${status.index}" value="${item.immunityReason}" maxlength="40"></td>
	     			<td style="text-align:center">
	      				<a href="#noloc" id="btn_immunity_update${status.index}" onclick="fnAccidentDateUpdate('${item.serialNo}',${item.rptPrintNo},'${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	      				<a href="#noloc" id="btn_immunity_close${status.index}" onclick="fnImmunityClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif'></a>	        			
	     			</td> 
	     		</tr>
	     	</c:if>
	    </c:forEach>
	    </table>
		</div>	
		
		<!--        보완요청 건        -->	
        <div class="display-table" style="margin-top: 50px;">
            <div class="display-cell">
                <p class="subtitle">6. 보완요청 건</p>
            </div>
        </div>
        <div id="div_supplement">
	       	<table>
	       		<colgroup>
	       			<col width="15%">
	       			<col width="20%">
	       			<col width="15%">
	       			<col width="15%">
	       			<col width="26%">
	       			<col width="9%">
	       		</colgroup>	
	       		<tr>
	       			<th>성명</th>
	       			<th>사고일자</th>
	       			<th>국가</th>
	       			<th>금액(원)</th>
	       			<th>보완사유</th>
	       			<th>-</th>
	       		</tr>
	       		
	       	<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >	        		
	        	<c:if test="${item.workerType == 3 || item.workerType == 4}">
	     			<tr id="tr_supplement_view${status.index}">
		     			<td>${item.workerName}</td>
			     		<td>${item.accidentDate}</td>		     			
		     			<td>${item.country}</td>
		     			<td style="text-align: right">
		     				<c:choose>
			     				<c:when test="${item.partSupplementAmount == null }">
			     					<span  class="money">${item.deductionAmount}</span>원
			     				</c:when>
			     				<c:otherwise>
			     					<span  class="money">${item.partSupplementAmount}</span>원
			     				</c:otherwise>
		     				</c:choose>
		     			</td>
		     			<td>${item.supplementReason}</td>
		     			<td style="text-align:center">
		      				<a href="#noloc" id="btn_supplement_edit${status.index}" onclick="fnSupplementEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
		     			</td> 
	     			</tr>
		     		<tr id="tr_supplement_edit${status.index}" style="display: none;">
		     			<td>${item.workerName}</td>
			     		<td style="text-align: center">
	                        <input type="text" id="accident_supplement_date${status.index}" class="calendar" name="stDate" value="${item.accidentDate}" style="width:90px;" maxlength="10"/> <br/>
	                    </td>		     			
		     			<td>${item.country}</td>
<!-- 		     			<td style="text-align: right"> -->
<%-- 		     				<input type="text"  id="part_supplement_amount${status.index}"  class="money" value="${item.deductionAmount}" > --%>
<!-- 		     			</td> -->
		     				<c:choose>
			     				<c:when test="${item.partSupplementAmount == null }">
				     				<td style="text-align: right"><input type="text" id="part_supplement_amount${status.index}" class="inputMoney" value="${item.deductionAmount}" maxlength="40"></td>
			     				</c:when>
			     				<c:otherwise>
				     				<td style="text-align: right"><input type="text" id="part_supplement_amount${status.index}" class="inputMoney" value="${item.partSupplementAmount}" maxlength="40"></td>
			     				</c:otherwise>
		     				</c:choose>
			     		<td style="text-align: center">
	                        <input type="text" id="supplement_reason${status.index}" value="${item.supplementReason}" maxlength="40"/> <br/>
	                    </td>		     						     			
		     			<td style="text-align:center">
		      				<a href="#noloc" id="btn_supplement_update${status.index}" onclick="fnSupplementUpdate('${item.serialNo}',${item.rptPrintNo},'${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		      				<a href="#noloc" id="btn_supplement_close${status.index}" onclick="fnSupplementClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif'></a>	        			
		     			</td> 
		     		</tr>
		     	</c:if>
	       	</c:forEach>
	      	</table>
		</div>		
				
		<script type="text/javascript">
            function fnAttachDocUseFlagUpdate(useAt){

                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rptPrintNo         = $("#rpt_print_no").val();
                param.use_flag              = useAt;

                var url = "./report_construction_attach_doc_useflag";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "json",
                    timeout: 20000,
                    success: function(data){
                        if(useAt == '1'){
                            $("#div_attach_doc_container").show();
                        }else if(useAt == '0'){
                            $("#div_attach_doc_container").hide();
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

            function fnAttachDocEdit(idx){
                $(".tr_attach_doc_view").show();
                $(".tr_attach_doc_edit").hide();

                $("#tr_attach_doc_view" + idx).hide();
                $("#tr_attach_doc_edit" + idx).show();
            }
            function fnAttachDocClose(idx){
                $("#tr_attach_doc_view" + idx).show();
                $("#tr_attach_doc_edit" + idx).hide();
            }

            function fnAttachDocRefresh(){
                var param = {};
                param.suim_rpt_no               = $("#suim_rpt_no").val();
                param.rptPrintNo                  = $("#rpt_print_no").val();
                param.cmd                          = 'RF';

                var url = "./report_construction_attach_doc";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_attach_doc_body").html(data);
                        _initMask();
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

            function fnAttachDocAdd(msg){
                $("#ad_attach_name").val(msg);
                $("#tr_attach_doc_add").show();
            }

            function fnAttachDocCancel(){
                $("#tr_attach_doc_add").hide();
            }

            function fnAttachDocSave(idx, cmd){
                if($("#ad_attach_name" + idx).val() == ""){
                    alert("첨부자료를 입력해주세요.");
                    $("#ad_attach_name" + idx).focus();
                    return;
                }

                if($("#ad_attach_copy" + idx).val() == ""){
                    alert("부수를 입력해주세요.");
                    $("#ad_attach_copy" + idx).focus();
                    return;
                }
				
                /*
                var etc_memo = $("#ad_attach_etc_memo" + idx + " option:selected").val();     //비고
                if(etc_memo == "" || (etc_memo == "999" && $("#ad_attach_etc_memo_etc" + idx).val() == "" )){
                    if (etc_memo == "999"){
                        alert("비고 내용을 입력해 주세요.");
                        $("#ad_attach_etc_memo_etc" + idx).focus();
                    }else{
                        alert("비고 내용을 선택해 주세요.");
                        $("#ad_attach_etc_memo" + idx).focus();
                    }
                    return;
                }
				*/

                /** 넘길 데이터 정리  **/
                var param = {};
                param.suimRptNo              	 = $("#suim_rpt_no").val();
                param.rptPrintNo              	 = $("#rpt_print_no").val();
                param.cmd                      	 = cmd;
                
                if (cmd == 'U'){
                    param.serial_no               = $("#ad_serial_no" + idx).val();
                }

                param.attach_name              = $("#ad_attach_name" + idx).val();
                param.attach_copy          	 = $("#ad_attach_copy" + idx).val().num();
                param.attach_etc_memo       = $("#ad_attach_etc_memo_etc" + idx).val();
				
                /**
                if(etc_memo == "999"){
                    param.attach_etc_memo       = $("#ad_attach_etc_memo_etc" + idx).val();
                }else{
                    param.attach_etc_memo       = etc_memo;
                }
				**/
				
                var url = "./report_construction_attach_doc";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                    	$("#divPrintConstruction").html("");                        	
    					$("#divPrintConstruction").html(data); 
    					alert("저장에 성공하였습니다.");
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

            function fnADMemoChange(that, idx){

                if(that.value == '999'){
                    $("#ad_attach_etc_memo_etc" + idx).show();
                }else{
                    $("#ad_attach_etc_memo_etc" + idx).hide();
                }

            }

            function fnAttachDocDelete(idx){
                if(confirm("삭제하시겠습니까?")){
                    var param = {};
                    param.suimRptNo               = $("#suim_rpt_no").val();
                    param.rptPrintNo              = $("#rpt_print_no").val();
                    param.cmd                       = 'D';
                    param.serial_no                 = $("#ad_serial_no" + idx).val();
                    
                    var url = "./report_construction_attach_doc";

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: param,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        dataType: "html",
                        timeout: 20000,
                        success: function(data){
                        	$("#divPrintConstruction").html("");                        	
        					$("#divPrintConstruction").html(data); 
        					alert("삭제에 성공하였습니다.");
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

        </script>
        <div class="display-table" style="margin-top: 10px;">
            <div class="display-cell">
                <p class="subtitle">7.첨부자료 목록</p>
            </div>
            <div class="display-cell text-right">
                <input type="radio" id="attach_doc_use_at1" name="attach_doc_use_at" onclick="fnAttachDocUseFlagUpdate('1')"  <c:if test="${reportPrint30.sagodocFlag == 1}">checked="checked"</c:if>>&nbsp;<label for="attach_doc_use_at1">사용</label>
                &nbsp;&nbsp;<input type="radio" id="attach_doc_use_at2" name="attach_doc_use_at" onclick="fnAttachDocUseFlagUpdate('0')"  <c:if test="${reportPrint30.sagodocFlag == 0}">checked="checked"</c:if>>&nbsp;<label for="attach_doc_use_at2">미사용</label>
            </div>
        </div>
        <c:set var="div_attach_doc_container_display" value="display:none;"/>
        <c:if test="${reportPrint30.sagodocFlag == 1}">
            <c:set var="div_attach_doc_container_display" value=""/>
        </c:if>
        <div id="div_attach_doc_container" style="${div_attach_doc_container_display}">
            <div id="div_attach_doc_header">
                <button class="btn btn-default" onclick="fnAttachDocAdd('해외근로자 치료비청구건 총괄표')">해외근로자 치료비청구건 총괄표</button>
                <button class="btn btn-default" onclick="fnAttachDocAdd('')">직접입력</button>
            </div>
            <div id="div_attach_doc_body">
                <table style="margin-top: 5px;">
                    <colgroup>
                        <col width="9%">
                        <col width="37%">
                        <col width="9%">
                        <col width="36%">
                        <col width="9%">
                    </colgroup>
                    <tr>
                        <th>순번</th>
                        <th>첨부자료</th>
                        <th>부수</th>
                        <th>비고</th>
                        <th>-</th>
                    </tr>
                    <c:forEach  var="item" items="${reportAttachDocList}" varStatus="status">
                        <tr id="tr_attach_doc_view${status.index}" class="tr_attach_doc_view">
                            <td style="text-align: center">${status.count}</td>
                            <td>${item.attachName}</td>
                            <td style="text-align: center">${item.attachCopy}</td>
                            <td style="text-align: center">${item.attachEtcMemo}</td>
                            <td style="text-align: center">
                                <a href="#noloc" onclick="fnAttachDocEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                                <a href="#noloc" onclick="fnAttachDocDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                            </td>
                        </tr>
                        <tr id="tr_attach_doc_edit${status.index}" class="tr_attach_doc_edit" style="display: none;">
                            <td style="text-align: center">${status.count}</td>
                            <td>
                                <input type="hidden" id="ad_serial_no${status.index}" value="${item.serialNo}">
                                <input type="text" id="ad_attach_name${status.index}" value="${item.attachName}">
                            </td>
                            <td>
                                <input type="text" id="ad_attach_copy${status.index}" value="${item.attachCopy}" style="text-align: right" maxlength="20">
                            </td>
                            <td>
                            <!-- 
                                <select id="ad_attach_etc_memo${status.index}" onchange="fnADMemoChange(this,'${status.index}');">
                                    <option value="">---선택---</option>
                                    <c:set var="ad_memo_selected" value="0"/>
                                    <c:forEach var="item_memo" items="${reportAttachDocCodeList}">
                                        <c:if test="${item.attachEtcMemo == item_memo}">
                                            <c:set var="ad_memo_selected" value="1"/>
                                        </c:if>
                                        <option value="${item_memo}" <c:if test="${item.attachEtcMemo == item_memo}">selected</c:if>>${item_memo}</option>
                                    </c:forEach>
                                    <option value="999" <c:if test="${ad_memo_selected == 0}">selected</c:if>>직접입력</option>
                                </select>
                                <c:if test="${ad_memo_selected == 0}">
                                    <input type="text" id="ad_attach_etc_memo_etc${status.index}" value="${item.attachEtcMemo}" maxlength="80">
                                </c:if>
                                <c:if test="${ad_memo_selected != 0}">
                                    <input type="text" id="ad_attach_etc_memo_etc${status.index}" style="display: none;" maxlength="80">
                                </c:if>
                            -->
                            <input type="text" id="ad_attach_etc_memo_etc${status.index}" value="${item.attachEtcMemo}" maxlength="80">
                            </td>
                            <td style="text-align: center">
                                <a href="#noloc" onclick="fnAttachDocSave('${status.index}','U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                                <a href="#noloc" onclick="fnAttachDocClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr id="tr_attach_doc_add" style="display: none;">
                        <td style="text-align: center">${status.count}</td>
                        <td>
                            <input type="text" id="ad_attach_name" value="" maxlength="80">
                        </td>
                        <td>
                            <input type="text" id="ad_attach_copy" value="" maxlength="3" style="text-align: right;width:100%;padding-right: 0px;">
                        </td>
                        <td>
                        <!--  
                            <select id="ad_attach_etc_memo" onchange="fnADMemoChange(this,'${status.index}');">
                                <option value="">---선택---</option>
                                <c:forEach var="item_memo" items="${reportAttachDocCodeList}">
                                    <option value="${item_memo}">${item_memo}</option>
                                </c:forEach>
                                <option value="999">직접입력</option>
                            </select>
                        -->    
                            <input type="text" id="ad_attach_etc_memo_etc" maxlength="80">
                        </td>
                        <td style="text-align: center">
                            <a href="#noloc" onclick="fnAttachDocSave('','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                            <a href="#noloc" onclick="fnAttachDocCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
            <p style="">&nbsp;</p>
            <p align="center"><b> ※ 본 손해사정서는 당사의 양식과 최선의 노력으로 이해 당사자</b></p>
            <p align="center"><b>어느 일방에도 편중됨이 없이 작성되었음을 명백히 합니다.[끝]</b></p>
            <p style="">&nbsp;</p>
        </div>
        </div><!-- 전체 테이블 테두리 -->
        <br/>


</div>

<script type="text/javascript">
	$(document).ready(function() {
        _initDatePicker();
        _initMask();			
        _initSelect2();
        _initInputMask();
	});
	
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
	
	/* mask 처리 */
	function _initMask(){
        var options = {
                onKeyPress : function(cep, event, currentField, options){
                    var tid = event.currentTarget.id;
                    var tidx = tid.substr(tid.length - 1, 1);
                    //console.log(tidx);
                    //fnCaculateTotal(tidx);
                },
                reverse : true
            };

            $('input.calendar').mask('0000-00-00',options);
            $('input.money').mask('#,###,###',options);
            $('div.money').mask('999,999,999',{reverse:true});
            $('span.money').mask('999,999,999',{reverse:true});
	}
	
	function _initSelect2(){
		$(".country").select2();
		$(".select_worker_type").select2();
	}
	
	function _initInputMask(){
        $(".inputMoney").inputmask("numeric", {
        	autoGroup: true, // default: false, 정수 부분 그룹화 사용 여부
        	groupSeparator: ",", // default: "", 그룹 구분자 정의
        	digits: 3, // default: "*", 소수 크기 정의
        	allowMinus: false, // default: true, 음수 사용 여부
        	repeat: 12 // 반복 기능? 나한테는 그냥 자리수..
        });
	}
</script>

<style type="text/css">
.select2-selection--single{
	height: 32px!important;
}
.reportContent select{
	height: 32px!important;
}
#div_contract_detail table tr td{
	text-align:center;
}
#div_other_worker table tr td{
	text-align:center;
}
#div_other_worker_payment table tr td{
	text-align:center;
}
#div_immunity table tr td{
	text-align:center;
}
#div_supplement table tr td{
	text-align:center;
}

#div_other_worker table tr th{
	font-size:11px;
}
.select2-selection__rendered{
	font-size:11px!important;
}
/* #worker_type .select2-search__field{  */
/*  	display:none;  */
/* }  */
#worker_type .select2-search__field{ 
 	display:none; 
} 
</style>







