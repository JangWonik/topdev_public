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
		if($("#report_edit_type").val() != 'view'){
			_initCalendar();	
		}
	});	
	
</script>
</head>
<c:if test="${ report_edit_type eq 'view' }">
<div style="margin-top:10px;">
	<div class="text-center" style="margin-bottom: 20px;">
    	<b><font size="3" color="BLACK">제출일 : ${fn:substring(reportDate,0,10)}</font></b>     	
	</div>
</div>
</c:if>

<c:if test="${ report_edit_type eq 'edit' }">
<div style="margin-top:10px;">
	<div class="text-center" style="margin-bottom: 20px;">
    	<b><font size="3" color="BLACK">제출일 : <input class="calendar" type="text" id="reportDate" value="${fn:substring(reportDate,0,10)}"></font></b>     	
	</div>
</div>
</c:if>