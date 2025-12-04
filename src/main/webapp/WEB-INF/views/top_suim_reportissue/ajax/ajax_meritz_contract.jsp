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
		_initCalendar();
		
		//입력값에 '~' 있으면 분리해서 넣어준다.
		var sDate = '${rptIssueMain.insuTerm}';						
		if( sDate.indexOf("~") > -1 ){
			var bDate = sDate.split("~");
			$("#insu_term").val(bDate[0]);
			$("#insu_term_end").val(bDate[1]);
		}
	});
</script>
</head>
<c:if test="${ contract_edit_type eq 'view' }">
	<table id="table_issue_meritz">
		<tr>
			<th colspan="3" width="60%">증권번호</th>
			<th width="40%">상품명</th>			
		</tr>
		<tr>
			<td colspan="3">${rptIssueMain.policyNo}</td>
			<td>${rptIssueMain.insuranceNm}</td>
		</tr>
		<tr>
			<th>계약자</th>
			<th>피보험자</th>
			<th>수익자</th>
			<th>보험기간</th>
		</tr>
		<tr>
			<td>${rptIssueMain.policyholderNm}</td>
			<td>${rptIssueMain.beneficiaryNm}</td>
			<td>${rptIssueMain.meritzBeneficiary}</td>
			<td>${rptIssueMain.insuTerm}</td>
		</tr>
	</table>
</c:if>

<c:if test="${ contract_edit_type eq 'edit' }">
	<form name="contractEditForm" id="contractEditForm" method="post">
	<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${rptIssueMain.suimRptNo}">
	<input type="hidden" id="contract_edit_type" name="contract_edit_type" value="view">
		<table id="table_issue_meritz">
			<tr>
				<th colspan="3" width="60%">증권번호</th>
				<th width="40%">상품명</th>			
			</tr>
			<tr>
				<td colspan="3">${rptIssueMain.policyNo}</td>
				<td>${rptIssueMain.insuranceNm}</td>
			</tr>
			<tr>
				<th>계약자</th>
				<th>피보험자</th>
				<th>수익자</th>
				<th>보험기간</th>
			</tr>
			<tr>
				<td>${rptIssueMain.policyholderNm}</td>
				<td>${rptIssueMain.beneficiaryNm}</td>
				<td>
					<input type="text" id="meritz_beneficiary" name="meritz_beneficiary" value="${rptIssueMain.meritzBeneficiary}">
				</td>				
				<td>
					<input class="calendar" type="text" id="insu_term" name="insu_term" value="" style="width: 35%;"/>
				    &nbsp;~&nbsp;
				    <input class="calendar" type="text" id="insu_term_end" name="insu_term_end" value="" style="width: 35%;"/>
			    </td>				
			</tr>
		</table>		
	</form>
</c:if>