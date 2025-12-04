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
<script>
	$(document).ready(function(){
		//alert('총괄표');
		$("#btn_pop_law").on("click", function () {
        	fnOpenLawModal();
        });
		
		//지급보험금 옵션처리
		$("#insupayment_disable").click( function(){
			if( $('input:checkbox[id="insupayment_disable"]').is(":checked") ){			//체크				
				$("#amt_insu_payment").prop('readonly','true');
				$("#amt_insu_payment").attr('style','background-color:#e2e2e2;text-align:right;');
			}else{			//체크해제				
				$("#amt_insu_payment").prop('readonly','');
				$("#amt_insu_payment").attr('style','background-color:#FFFFFF;text-align:right;');
			}			
		});
	});	
	
</script>
</head>
<c:if test="${ summary_edit_type eq 'view' }">
<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
	<colgroup>
	    <col width="25%">
	    <col width="75%">                    
	</colgroup>                
	<tbody>
	<tr>
		<th><b>구 분</b></th>
		<th><b>상 세 내 용</b></th>                	
	</tr>
	<tr>
	    <th><b>약 관 상 면 책  부 책 여 부</b></th>
	    <td  style="text-align: left;padding-left:5px;">
	    	<c:choose>
	    		<c:when test="${rptIssueMain.reparationLiabilityType eq '1'}">[부책] </c:when>
	    		<c:when test="${rptIssueMain.reparationLiabilityType eq '2'}">[면책] </c:when>
	    		<c:otherwise> - </c:otherwise>
	    	</c:choose>
	    	 <%-- / ${rptIssueMain.reparationLiabilityReason} --%>
	    </td>                    
	</tr>	
	<tr>
	    <th><b>지 급 보 험 금</b></th>
	    <c:choose>
	   		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
	   			<td  style="text-align: left;padding-left:5px;">단체 사고의 경우 개별 안내 금액에 따름</td>
	   		</c:when>
	   		<c:otherwise>
	   			<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtInsuPayment}" pattern="#,###" /> 원</td>
	   		</c:otherwise>
        </c:choose>	    
	                        
	</tr>
	<tr>
	    <th><b>지 급 처</b></th>
	    <td style="text-align: left;padding-left:5px;">
	    	<c:choose>
	    		<c:when test="${rptIssueMain.paymentPlace eq 1}">피보험자</c:when>
	    		<c:when test="${rptIssueMain.paymentPlace eq 2}">피해자</c:when>
	    		<c:otherwise> - </c:otherwise>
	    	</c:choose>
	    </td>                    
	</tr>
    </tbody>
</table>
</c:if>

<c:if test="${ summary_edit_type eq 'edit' }">
<table id="table_issue_contract_edit" style="border: 1px solid currentColor;">
	<colgroup>
	    <col width="25%">
	    <col width="75%">                    
	</colgroup>                
	<tbody>
	<tr>
		<th><b>구 분</b></th>
		<th><b>상 세 내 용</b></th>                	
	</tr>
	<tr>
	    <th><b>약 관 상 면 책  부 책 여 부</b></th>
	    <td  style="text-align: left;padding-left:5px;">
	    	<select class="lawSelect"  id="select_reparation_liability_type" data-gubun="liability" style="width:100px; padding-left: 1px; padding-right: 1px;">
	    		<option <c:if test="${rptIssueMain.reparationLiabilityType eq '0'}">selected</c:if> value="0">없음</option>
       			<option <c:if test="${rptIssueMain.reparationLiabilityType eq '1'}">selected</c:if> value="1">부책</option>
       			<option <c:if test="${rptIssueMain.reparationLiabilityType eq '2'}">selected</c:if> value="2">면책</option>
       		</select>
       		<%-- <button class="btn_pop_law" id="btn_pop_law" type="button" style="width:60px; padding-top: 16px; padding-bottom: 16px; padding-left: 1px; padding-right: 1px;">항목선택</button> 
       		<input style="width:300px;" type="text" id="reparation_liability_reason" maxlength="100" value="${rptIssueMain.reparationLiabilityReason}"> --%>
	    </td>                    
	</tr>	
	<tr>
	    <th><b>지 급 보 험 금</b></th>	    
	    <td  style="text-align: left;padding-left:5px;">
	    	<c:choose>
           		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
           			<input type="checkbox" id="insupayment_disable" checked /> 단체 사고의 경우 개별 안내 금액에 따름<br/>
           			<input class="money"  type="text" id="amt_insu_payment" value="${rptIssueMain.amtInsuPayment}" readonly style="background-color:#e2e2e2;text-align:right;"> 원
           		</c:when>
           		<c:otherwise>
           			<input type="checkbox" id="insupayment_disable"/> 단체 사고의 경우 개별 안내 금액에 따름<br/>
           			<input class="money"  type="text" id="amt_insu_payment" value="${rptIssueMain.amtInsuPayment}" style="text-align:right;"> 원
           		</c:otherwise>
           	</c:choose>
	    </td>            
	</tr>
	<tr>
	    <th><b>지 급 처</b></th>
	    <td style="text-align: left;padding-left:5px;">
	    	<select id="payment_place" name="payment_place" style="width:100px; padding-left: 1px; padding-right: 1px;">
	    		<option <c:if test="${rptIssueMain.paymentPlace eq 0}">selected</c:if> value="0">없음</option>
	    		<option <c:if test="${rptIssueMain.paymentPlace eq 1}">selected</c:if> value="1">피보험자</option>
	    		<option <c:if test="${rptIssueMain.paymentPlace eq 2}">selected</c:if> value="2">피해자</option>
	    	</select>	    	
	    </td>                    
	</tr>	
    </tbody>
</table>
</c:if>