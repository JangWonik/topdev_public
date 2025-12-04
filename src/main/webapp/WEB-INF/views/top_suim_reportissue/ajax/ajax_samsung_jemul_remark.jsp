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
</head>
<c:if test="${ remark_edit_type eq 'view' }">
<div class="issue_lotte">
	<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
		<tr>
			<td style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>
		</tr>				
	</table>					
</div>
</c:if>
<c:if test="${ remark_edit_type eq 'edit' }">
<form name="remarkEditForm" id="remarkEditForm" method="post">
	<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
	<input type="hidden" id="remark_edit_type" name="remark_edit_type" value="view">
	<input type="hidden" id="ctype" name="ctype" value="${ctype}">
<div class="issue_lotte">
	<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
		<tr>
			<td style="text-align: left;padding-left:5px;">
				<input type="text" id="remark_val" value="${rptIssue.remarkVal}" style="width:626px" maxlength="150"/>
			</td>				
		</tr>				
	</table>					
</div>
</form>
</c:if>