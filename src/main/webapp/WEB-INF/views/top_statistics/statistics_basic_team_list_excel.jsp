<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    //String fileName = (String)pageContext.getAttribute("subject");
    response.setHeader("Content-Disposition", "attachment; filename=statistics_team_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<c:if test="${tabType eq '1' || tabType eq ''}">
	<h1>1종</h1>
	<c:import url="./statistics_basic_team_list_02.jsp"></c:import>
</c:if>
<c:if test="${tabType eq '4'}">
	<h1>4종</h1>                                                            
	<c:import url="./statistics_basic_team_list_03.jsp"></c:import>
</c:if>
<c:if test="${tabType eq '5'}">
	<h1>1종 + 4종</h1>                            
	<c:import url="./statistics_basic_team_list_01.jsp"></c:import>
</c:if>
</body>
</html>