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
		
		if($("#write_edit_type").val() == 'edit'){
			_initCalendar();	
		}
		
	});	
	
</script>
</head>
<c:if test="${ write_edit_type eq 'view' }">
<table>
	<tr>						 			
		<td width="12%" style="font-weight:bold;text-align:left;">
			작성일자
		</td>
		<td width="20%" style="font-weight:bold;text-align:center;">
			${nowdate}
		</td>
		<td width="68%" style="text-align:left;"></td>					
	</tr>
</table>
</c:if>
<c:if test="${ write_edit_type eq 'edit' }">
<table>
	<tr>						 			
		<td width="12%" style="font-weight:bold;text-align:left;">
			작성일자
		</td>
		<td width="20%" style="font-weight:bold;text-align:center;">
			<input class="calendar" type="text" id="write_date" value="${nowdate}" style="width: 80px;"/>
		</td>
		<td width="68%" style="text-align:left;"></td>					
	</tr>
</table>
</c:if>
</html>