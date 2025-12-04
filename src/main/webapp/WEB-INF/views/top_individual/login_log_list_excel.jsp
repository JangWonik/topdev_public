<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=LoginLogList.xls"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>	
<html lang="ko">
<body>
<table border="1">
	<thead>
		<tr>
			<th width="10%">순번</th>
			<th width="25%">팀명</th>
			<th width="25%">이름</th>
			<th width="20%">접근 아이피</th>
			<th width="20%">로그인 시간</th>											
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${loginLogList.size() == 0 }">
				<tr>
					<td colspan="8">조회 된 로그인 내역이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${loginLogList}" var="item" varStatus="status">
				<tr>
					<td>${loginLogList.size() - status.index}</td>
					<td>${item.team_name}</td>
					<td>${item.user_name}</td>
					<td style='mso-number-format:"\@";'>${item.ip}</td>
					<td style='mso-number-format:"\@";'>${item.login_time}</td>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
</body>
</html>
