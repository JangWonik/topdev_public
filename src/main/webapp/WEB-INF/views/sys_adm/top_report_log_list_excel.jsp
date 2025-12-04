<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=top_report_log_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<table border="1">		
		<tr>
			<th width="10%">순번</th>
			<th width="20%">접수번호</th>
			<th width="20%">이름</th>
			<th width="15%">로그 아이피</th>
			<th width="20%">활동내용</th>
			<th width="15%">접근일자</th>
		</tr>		
	<c:forEach var="items" items="${reportLogList}" varStatus="status">
			<tr>
				<td width="10%">${reportLogList.size() - status.index}</td>
				<td width="20%">${items.suim_accept_no}</td>
				<td width="20%">${items.user_name}</td>
				<td width="15%">${items.log_ip}</td>
				<td width="20%">${items.action_text}</td>
				<td width="15%">${items.log_date_fmt}</td>
			</tr>
		</c:forEach>
</table>
</body>
</html>
