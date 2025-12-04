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
		if($("#content_edit_type").val() != 'view'){
			$("#minwon_act_comment").focus();	
		}
	});	
	
</script>
</head>
<c:if test="${ content_edit_type eq 'edit' }">
<table id=table_issue_contract_view>
   	
   	<c:forEach items="${sagoMidList}" var="item" varStatus="status">   			
   		<tr>
	   		<td style="text-align:left;padding-left:10px;padding-top:10px;padding-bottom:10px;">
	   			<textarea id="minwon_act_comment" cols="38" rows="5">${fn:replace(item.minwonActComment,'<br/>', CRLF)}</textarea>
	   		</td>
	   	</tr>
   	</c:forEach>
   	<c:if test="${sagoMidList.size() == 0}">
   		<tr>
	   		<td style="text-align:left;padding-left:10px;">
	   			<textarea id="minwon_act_comment" cols="38" rows="5"></textarea>
	   		</td>
	   	</tr>   		
   	</c:if>	
</table>
</c:if>

<c:if test="${ content_edit_type eq 'view' }">
<table id=table_issue_contract_view>
   	
   	<c:forEach items="${sagoMidList}" var="item" varStatus="status">   			
   		<tr>
	   		<td style="text-align:left;padding-left:10px;padding-top:10px;padding-bottom:10px;">	   				   			
	   			${fn:replace(item.minwonActComment , CRLF , '<br/>')}	   			
	   		</td>
	   	</tr>
   	</c:forEach>
   	<c:if test="${sagoMidList.size() == 0}">   			
   		<tr>
			<td height="100" style="text-align:left;padding-left:10px;">입력된 특이사항 및 민원예방활동 정보가 없습니다.</td>
		</tr>
   	</c:if>	
</table>
</c:if>