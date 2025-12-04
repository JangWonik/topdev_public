<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
		            <table id="table_law_view">
		                <col width="10%">
		                <col width="2%">
		                <col width="88%">
		                <tr>
		                	<th >
		                		<c:choose>
		                			<c:when test="${rptIssue.insuPaymentType eq '1'}">부책</c:when>
		                			<c:when test="${rptIssue.insuPaymentType eq '2'}">면책</c:when>
		                		</c:choose>
		                	</th>
		                	<td>/</td>
		                	<td>
		                		${rptIssue.insuPaymentReason}
		                	</td>
		                </tr>  
		            </table>
		        
		            <table id="table_law_edit" style="display: none;">
<%-- 		                <col width="15%">
		                <col width="85%"> --%>
		                <tr>
		                	<td style="width: 170px;">
		                		<select class="lawSelect2" id="select_insu_payment_type" data-gubun="insupayment">
		                			<option <c:if test="${rptIssue.insuPaymentType eq '1'}">selected</c:if> value="1">부책</option>
		                			<option <c:if test="${rptIssue.insuPaymentType eq '2'}">selected</c:if> value="2">면책</option>
		                		</select>
		                	</td> 
		                	<td>
		                		<select id="select_insu_payment_reason" >
		                		
		                		</select>
		                		<input style="width:470px;" type="text" id="insu_payment_reason" maxlength="100" value="${rptIssue.insuPaymentReason}"> 
		                	</td>
		                </tr>              
		            </table>