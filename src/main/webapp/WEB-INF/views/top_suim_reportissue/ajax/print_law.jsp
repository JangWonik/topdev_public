<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
           <table id="table_law_view">
<%--                 <col width="10%">
                <col width="2%">
                <col width="88%">
                <tr>
                    <th colspan="3">가. 손해배상책임 근거</th>
                </tr> --%>
                <tr>
                	<th style="width: 30px; padding-left: 20px; padding-top: 4px;">
                		<c:choose>
                			<c:when test="${rptIssue.reparationLiabilityType eq '1'}">부책</c:when>
                			<c:when test="${rptIssue.reparationLiabilityType eq '2'}">면책</c:when>
                		</c:choose>
                	</th>
                	<td style="width: 10px;">/</td>
                	<td>
                		${rptIssue.reparationLiabilityReason}
                	</td>
                </tr>
                
<%--                 <tr style="height: 10px !important;"><td colspan="3" style="border: 0px solid !important;"></td></tr>
                
                <tr>
                    <th colspan="3">나. 보험금 지급책임 근거</th>
                </tr>
                <tr>
                	<th style="text-align: right;">
                		<c:choose>
                			<c:when test="${rptIssue.insuPaymentType eq '1'}">부책</c:when>
                			<c:when test="${rptIssue.insuPaymentType eq '2'}">면책</c:when>
                		</c:choose>
                	</th>
                	<td>/</td>
                	<td>
                		${rptIssue.insuPaymentReason}
                	</td>
                </tr> --%>  
            </table>
        
            <table id="table_law_edit" style="display: none; text-align: left;">
<%--                 <col width="15%">
                <col width="85%">
                <tr>
                    <th colspan="2">
                    	가. 손해배상책임 근거
                   	</th>
                </tr> --%>
                <tr style="text-align: left;">
                	<td style="width: 120px;">
                		<select class="lawSelect"  id="select_reparation_liability_type" data-gubun="liability" style="width:50px; padding-left: 1px; padding-right: 1px;">
                			<option <c:if test="${rptIssue.reparationLiabilityType eq '1'}">selected</c:if> value="1">부책</option>
                			<option <c:if test="${rptIssue.reparationLiabilityType eq '2'}">selected</c:if> value="2">면책</option>
                		</select>
                		<button class="btn_pop_law" id="btn_pop_law" type="button" style="width:60px; padding-top: 16px; padding-bottom: 16px; padding-left: 1px; padding-right: 1px;">항목선택</button>
                	</td>
                	<td>
                		<input style="width:520px;" type="text" id="reparation_liability_reason" maxlength="100" value="${rptIssue.reparationLiabilityReason}"> 
                	</td>
                </tr>
                
<%--                 <tr style="height: 10px !important;"><td colspan="2" style="border: 0px solid !important;"></td></tr>
                
                <tr>
                    <th colspan="2">나. 보험금 지급책임 근거</th>
                </tr>
                <tr>
                	<td>
                		<select class="lawSelect2" id="select_insu_payment_type" data-gubun="insupayment">
                			<option <c:if test="${rptIssue.insuPaymentType eq '1'}">selected</c:if> value="1">부책</option>
                			<option <c:if test="${rptIssue.insuPaymentType eq '2'}">selected</c:if> value="2">면책</option>
                		</select>
                	</td> 
                	<td>
                		<select id="select_insu_payment_reason" >
                		
                		</select>
                		<input type="text" id="insu_payment_reason" maxlength="100" value="${rptIssue.insuPaymentReason}"> 
                	</td>
                </tr> --%>              
            </table>