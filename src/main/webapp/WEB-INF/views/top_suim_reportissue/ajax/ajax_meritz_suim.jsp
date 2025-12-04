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
	});
</script>
</head>
<c:if test="${ suim_edit_type eq 'view' }">
	<table id="table_issue_meritz">
		<tr>
			<th>접수번호</th>
			<th>수임일자</th>
			<th>종결일자</th>
		</tr>
		<tr>
			<td>${rptIssueMain.meritzAcceptNo}</td>
			<td>${rptIssueMain.regDate}</td>
			<td>${rptIssueMain.meritzCloseDateFmt}</td>
		</tr>
		<tr>
			<th>수임내용</th>
			<td colspan="2" style="text-align:left;padding-left:5px;">
				${fn:replace(fn:replace(fn:escapeXml(rptIssueMain.meritzSuimContent) , CRLF , '<br>'), ' ', '&nbsp;')}				
			</td>
		</tr>
	</table>
</c:if>

<c:if test="${ suim_edit_type eq 'edit' }">
	<form name="suimEditForm" id="suimEditForm" method="post">
	<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${rptIssueMain.suimRptNo}">
	<input type="hidden" id="suim_edit_type" name="suim_edit_type" value="view">
	<table id="table_issue_meritz">
		<tr>
			<th>접수번호</th>
			<th>수임일자</th>
			<th>종결일자</th>
		</tr>
		<tr>
			<td><input type="text" id="meritz_accept_no" name="meritz_accept_no" value="${rptIssueMain.meritzAcceptNo}"></td>
			<td>${rptIssueMain.regDate}</td>
			<td><input class="calendar" type="text" id="meritz_close_date" name="meritz_close_date" value="${rptIssueMain.meritzCloseDateFmt}" style="width: 70%;"/></td>
		</tr>
		<tr>
			<th>수임내용</th>
			<td colspan="2" style="text-align:center;">
				<textarea id=meritz_suim_content name="meritz_suim_content" rows="3" cols="50">${fn:replace(fn:replace(rptIssueMain.meritzSuimContent , '<br>', CRLF), ' ', '&nbsp;')}</textarea>				
			</td>
		</tr>
	</table>			
	</form>
</c:if>