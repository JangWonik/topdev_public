<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script>
		function reqPgNoClick(pgNo,currentTab){
			boardSrcForm.reqPgNo.value = pgNo;
			boardSrcForm.currentTab.value = currentTab;
			boardSrcForm.submit();
		}
	</script>
</head>

<body>
	<c:if test="${pgNm1 != null}">
		<c:if test="${startPgNoInt1 > 10}">
			<a href="javascript:reqPgNoClick(${startPgNoInt1 - 1},'help');">&lt;</a>
		</c:if>

		<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
			<c:choose>
				<c:when test="${reqPgNoInt1 != pageNo}">
					<a href="javascript:reqPgNoClick(${pageNo},'help');"><c:out value="${pageNo}" /></a>
					&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
					<font color="red"><c:out value="${pageNo}" /></font>
					&nbsp;&nbsp;
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
			<a href="javascript:reqPgNoClick(${endPgNoInt1 + 1},'help');">&gt;</a>
		</c:if>
	</c:if>
</body>

</html>
