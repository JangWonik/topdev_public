<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

	<p style="text-align:center;">
		<c:if test="${startPgNoInt1 > 10}">
			<a href="./${pgNm1}?reqPgNo=${startPgNoInt1 - 1}&sDay=${sDay}&eDay=${eDay}&srchSuimAcceptNo=${srchSuimAcceptNo}">&lt;</a>
		</c:if>

		<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
			<c:choose>
				<c:when test="${reqPgNoInt1 != pageNo}">
					<a href="./${pgNm1}?reqPgNo=${pageNo}&sDay=${sDay}&eDay=${eDay}&srchSuimAcceptNo=${srchSuimAcceptNo}"><c:out value="${pageNo}" /></a>
					&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
					<font color="red"><c:out value="${pageNo}" /></font>
					&nbsp;&nbsp;
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
			<a href="./${pgNm1}?reqPgNo=${endPgNoInt1 + 1}&sDay=${sDay}&eDay=${eDay}&srchSuimAcceptNo=${srchSuimAcceptNo}">&gt;</a>
		</c:if>
	</p>

</body>

</html>
