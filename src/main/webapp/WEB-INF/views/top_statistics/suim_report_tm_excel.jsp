<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=statistics_team_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<c:if test="${view_type eq 'Person'}">
	<c:import url="./suim_report_person_excel.jsp"></c:import>
</c:if>
<c:if test="${view_type eq 'Member'}">
	<c:import url="./suim_report_mbr_excel.jsp"></c:import>
</c:if>
<c:if test="${view_type eq 'Team'}">
	<c:import url="./suim_report_tm1_excel.jsp"></c:import>
</c:if>
<c:if test="${view_type eq 'Insu'}">
	<c:import url="./suim_report_insu_excel.jsp"></c:import>
</c:if>
<c:if test="${view_type eq 'InsuDetail'}">
	<c:import url="./suim_report_insu_detail_excel.jsp"></c:import>
</c:if>
</body>
</html>