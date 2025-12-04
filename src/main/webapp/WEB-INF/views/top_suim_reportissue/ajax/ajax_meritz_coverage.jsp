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
<c:if test="${coverage_edit_type eq 'view' }">
	<table id="table_issue_meritz">
		<tr>
			<th width="40%">담보명</th>
			<th width="30%">가입금액</th>
			<th width="30%">청구금액</th>
		</tr>
		<c:choose>
			<c:when test="${coverageInfoList.size() == 0}">
				<td colspan="3">입력된 담보정보가 없습니다.</td>
			</c:when>
			<c:otherwise>
				<c:forEach items="${coverageInfoList}" var="item" varStatus="status">			
					<tr>
						<td>${item.coverageNm}</td>
						<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.joinPrice}" pattern="#,###" /></td>
						<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.billPrice}" pattern="#,###" /></td>
						<td></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>				
	</table>
</c:if>

<c:if test="${coverage_edit_type eq 'edit' }">
	<form name="coverageEditForm" id="coverageEditForm" method="post">
	<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suim_rpt_no}">
	<input type="hidden" id="coverage_edit_type" name="coverage_edit_type" value="view">
	<table id="table_issue_meritz">
		<tr name="coverage_tr">
			<th width="40%">담보명
				<img src="./resources/ls_img/btn_add_s.gif" onclick="fnCoverage_add();" style="cursor:pointer"/>
			</th>
			<th width="30%">가입금액</th>
			<th width="30%">청구금액</th>
		</tr>
		<c:if test="${ rowSpan eq 0 }">
			<tr>
				<td><input type="text" id="coverage_nm" name="coverage_nm"></td>
				<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
				<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="bill_price" name="bill_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
			</tr>
		</c:if>
		<c:forEach items="${coverageInfoList}" var="item" varStatus="status">
			<tr>
				<td><input type="text" id="coverage_nm" name="coverage_nm" value="${item.coverageNm}"></td>
				<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="${item.joinPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
				<td style="text-align: right;padding-right:5px;">
					<input type="text" class="money" id="bill_price" name="bill_price" value="${item.billPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)">
					<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnCoverage_del('${item.suimRptNo }','${item.ckey}');" style="cursor:pointer" />
				</td>
			</tr>
		</c:forEach>		
	</table>			
	</form>
</c:if>