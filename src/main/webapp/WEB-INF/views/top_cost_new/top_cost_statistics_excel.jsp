<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
	//String fileName = (String)pageContext.getAttribute("subject");
	response.setHeader("Content-Disposition", "attachment; filename=top_cost_statistics_"+pageContext.getAttribute("today")+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<h1>경비통계</h1>
<c:import url="./top_cost_statistics1.jsp"></c:import>
<h1>추가경비통계</h1>
<c:import url="./top_cost_statistics2.jsp"></c:import>
<h1>클레임교통비통계</h1>
<c:import url="./top_cost_statistics3.jsp"></c:import>
</body>
</html>