<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    //String fileName = (String)pageContext.getAttribute("subject");
    response.setHeader("Content-Disposition", "attachment; filename=duty_dep_list_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	
</head>
<body>
	<table border="1">	
		<tr>
			<th>no</th>
			<th>접수번호</th>
			<th>당직날짜</th>
			<th>처리센터</th>
			<th>처리팀</th>
			<th>담당자</th>
			<th>보험사</th>
			<th>구  분</th>
			<th>당직금액</th>
			<th>건수(콜접수/출동)</th>
			<th>결재상태</th>
		</tr>
	<c:forEach var="item" items="${list}" varStatus="status">
		
		<tr>
		<%-- 	<td id="list">${status.count}</td> --%>
			<td>${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>
			<td>${fn:substring(item.dutyId,0,7)}-${fn:substring(item.dutyId,7,9)}</td>
			<td>${fn:substring(item.caDe,0,4)}-${fn:substring(item.caDe,4,6)}-${fn:substring(item.caDe,6,8)}</td>
			<td>${item.parentTeamName}</td>
			<td>${item.teamName}</td>
			<td>${item.userName}</td>
			<td>${item.ptnrNick}</td>
			<td>
				<c:choose>
					<c:when test="${item.dutyType == '1'}">전화당직(평일)</c:when>
					<c:when test="${item.dutyType == '2'}">전화당직(휴일)</c:when>
					<c:when test="${item.dutyType == '3'}">출동대기</c:when>
					<c:when test="${item.dutyType == '4'}">출동</c:when>
					<c:when test="${item.dutyType == '5'}">출동대기+ 출동</c:when>
				</c:choose>
			</td>
			<td><fmt:formatNumber value="${item.dutyCost}" pattern="###,###,###"/></td>
			<td>${item.processCnt}</td>											
			<td>
				<c:choose>
					<c:when test="${item.dutyStatus == '10'}">
						결재대기
					</c:when>
					<c:when test="${item.dutyStatus == '20'}">
						입금대기
					</c:when>
					<c:when test="${item.dutyStatus == '30'}">
						입금완료
					</c:when>
				</c:choose>
			</td>									
		</tr>
	</c:forEach>	
	
	</table>

</body>
</html>