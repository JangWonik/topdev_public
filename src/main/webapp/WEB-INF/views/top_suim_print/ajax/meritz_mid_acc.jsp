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
		if($("#acc_edit_type").val() != 'view'){
			_initCalendar();	
		}
	});	
	
</script>
</head>
<c:if test="${ acc_edit_type eq 'add' }">
<table id=table_issue_contract_view>
	<tr>
		<th width="17%"><b>진행일자</b></th>
		<th width="17%"><b>대상자</b></th>
		<th width="16%"><b>접촉방법</b></th>
		<th width="50%"><b>진행내용</b></th>					
   	</tr>
   	
   	<c:forEach items="${sagoList}" var="item" varStatus="status">   			
   		<tr>
	   		<td>${item.controlDate}</td>
	   		<td>${item.controlWho}</td>
	   		<td>${item.controlContact}</td>
	   		<td style="text-align:left;padding-left:10px;">${item.controlMemo}</td>
	   	</tr>
   	</c:forEach>
   	<c:if test="${sagoList.size() == 0}">   			
   		<tr>
			<td colspan="4">입력된 현장 진행사항이 없습니다.</td>
		</tr>
   	</c:if>
	
	<tr>
   		<td><input class="calendar" type="text" id="controlDateVal" value="${sToday}"></td>
   		<td><input type="text" id="controlWhoVal"></td>
   		<td><input type="text" id="controlContactVal"></td>
   		<td><input type="text" id="controlMemoVal" style="width:270px;">&nbsp; <img src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" onclick="accAdd()" title="추가하기"/></td>	   		
   	</tr>
</table>
</c:if>

<c:if test="${ acc_edit_type eq 'view' }">
<table id=table_issue_contract_view>
	<tr>
		<th width="17%"><b>진행일자</b></th>
		<th width="17%"><b>대상자</b></th>
		<th width="16%"><b>접촉방법</b></th>
		<th width="50%"><b>진행내용</b></th>					
   	</tr>
   	
   	<c:forEach items="${sagoList}" var="item" varStatus="status">   			
   		<tr>
	   		<td>${item.controlDate}</td>
	   		<td>${item.controlWho}</td>
	   		<td>${item.controlContact}</td>
	   		<td style="text-align:left;padding-left:10px;">${item.controlMemo}</td>
	   	</tr>
   	</c:forEach>
   	<c:if test="${sagoList.size() == 0}">   			
   		<tr>
			<td colspan="4">입력된 현장 진행사항이 없습니다.</td>
		</tr>
   	</c:if>   		
</table>
</c:if>

<c:if test="${ acc_edit_type eq 'edit' }">
<table id=table_issue_contract_edit>
	<tr>
		<th width="17%"><b>진행일자</b></th>
		<th width="17%"><b>대상자</b></th>
		<th width="16%"><b>접촉방법</b></th>
		<th width="40%"><b>진행내용</b></th>
		<th width="10%"><b>비고</b></th>					
   	</tr>
   	
   	<c:forEach items="${sagoList}" var="item" varStatus="status">   		   			
   		<tr>
	   		<td><input class="calendar" type="text" id="controlDateVal_${item.serialNo}" value="${item.controlDate}"></td>
	   		<td><input type="text" id="controlWhoVal_${item.serialNo}" value="${item.controlWho}"></td>
	   		<td><input type="text" id="controlContactVal_${item.serialNo}" value="${item.controlContact}"></td>
	   		<td><input type="text" id="controlMemoVal_${item.serialNo}" value="${item.controlMemo}"></td>	   		
	   		<td>
	   			<img src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" onclick="accModify(${item.serialNo})" title="수정하기"/> 
	   			<img src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" onclick="accDelete(${item.serialNo})" title="삭제하기"/>
	   		</td>
	   	</tr>	   	
   	</c:forEach>
   	<c:if test="${sagoList.size() == 0}">   			
   		<tr>
			<td colspan="5">입력된 현장 진행사항이 없습니다.</td>
		</tr>
   	</c:if>   		
</table>
</c:if>