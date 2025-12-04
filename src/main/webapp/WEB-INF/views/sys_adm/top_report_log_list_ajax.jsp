<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="height: 550px;overflow-x: hidden !important;overflow-y: auto;">
	<table>	
		<c:choose>		
			<c:when test="${reportLogList.size() == 0}">
				<tr>
					<td colspan="6" align="center">검색결과가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
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
			</c:otherwise>
		</c:choose>
	</table>
</div>