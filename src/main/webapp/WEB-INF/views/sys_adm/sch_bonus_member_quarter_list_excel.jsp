<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=sch_bonus_"+pageContext.getAttribute("today")+".xls");
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
		<th width="50px;">순번</th>
		<th width="100px;">부문명</th>
		<th width="100px;">센터명</th>
		<th width="100px;">팀명</th>
		<th width="100px;">성명</th>
		<th width="50px;">직급</th>
		<th width="50px;">직책</th>
		<th width="50px;">분기</th>
		<th width="110px;">실적</th>
		<th width="100px;">기준일</th>
		<th width="100px;">근무일</th>
		<th width="100px;">근무율</th>
		<th width="100px;">목표건</th>
		<th width="100px;">실적건</th>
		<th width="100px;">성과율</th>
		<th width="100px;">기준일자</th>
		<th width="100px;">등록일자</th>
		<th width="100px;">실적시작일</th>
		<th width="100px;">실적종료일</th>
		<th width="100px;">관리자명</th>
		<th width="100px;">입사일자</th>
		<th width="100px;">퇴사일자</th>		
	</tr>		
	<c:forEach var="items" items="${memberList}" varStatus="status">
		<tr>
			<td width="50px;">${memberList.size() - status.index}</td>
			<td width="100px;">${items.team_sector_name}</td>
			<td width="100px;">${items.center_name}</td>
			<td width="100px;">${items.team_name}</td>
			<td width="100px;">${items.user_name}</td>
			<td width="50px;">${items.work_level_name}</td>
			<td width="50px;">${items.work_type_name}</td>
			<td width="50px;">${items.quarter_flag}</td>
			<td width="100px;"><fmt:formatNumber value="${items.bonus_pay}" pattern="###,###,###"/></td>
			<td width="50px;">${items.workday_interval}</td>
			<td width="50px;">${items.workday_cnt}</td>
			<td width="50px;">${fn:replace(items.workday_per,'.0','')}%</td>
			<td width="100px;">${items.workload_target}</td>
			<td width="100px;">${items.workload_cnt}</td>
			<td width="100px;">${items.workload_per}%</td>			
			<td width="100px;">${items.base_date_fmt}</td>
			<td width="100px;">${items.reg_date_fmt}</td>
			<td width="100px;">${items.sdate_fmt}</td>
			<td width="100px;">${items.edate_fmt}</td>
			<td width="100px;">${items.manager_name}</td>
			<td width="100px;">${items.join_date_fmt}</td>
			<td width="100px;">${items.out_date_fmt}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>
