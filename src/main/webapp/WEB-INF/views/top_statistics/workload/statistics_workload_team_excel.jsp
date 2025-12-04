<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    //String fileName = (String)pageContext.getAttribute("subject");
    response.setHeader("Content-Disposition", "attachment; filename=workload_team_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
    	th{  background: "#e7ecf1"; }
    </style>
</head>
<body>

	<div class="centercnt_bot2" style="margin:0 auto;">
		<div class="guest">
		<!-- 
			<div class="guestTap">
				<c:choose>
					<c:when test="${srchArg.type == '1'}">
						<h3>센터별 평가기준 달성도</h3>
					</c:when>
					<c:when test="${srchArg.type == '2'}">
						<h3>팀별 평가기준 달성도</h3>
					</c:when>
					<c:when test="${srchArg.type == '3'}">
						<h3>개인별 평가기준 달성도</h3>
					</c:when>
				</c:choose>
			</div>
		 -->
			<div class="guestcnt2" style="display:block;">
				<c:choose>
					<c:when test="${srchArg.type == '3'}">
						<c:import url="./statistics_workload_member_list_01.jsp"></c:import>
					</c:when>
					<c:otherwise>
						<c:import url="./statistics_workload_team_list_01.jsp"></c:import>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

</body>
</html>