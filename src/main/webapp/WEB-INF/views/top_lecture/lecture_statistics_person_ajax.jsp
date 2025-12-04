<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${personList.size() == 0}">
			<tr>
				<td colspan="8" align="center">검색조회 결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${personList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="person_view_${items.user_no}">
					<td align="center" width="10%">${status.count}</td>
					<td align="center" width="17%">${items.center_name}</td>
					<td align="center" width="17%">${items.team_name}</td>
					<td align="center" width="16%">${items.user_name}</td>
					<td align="center" width="10%">
					<c:choose>
						<c:when test="${items.approval_cnt eq 0}">${items.approval_cnt}</c:when>
						<c:otherwise>
							<a href="javascript:goPersonDetail('${items.user_no}','AP');">
								<font color="blue">${items.approval_cnt}</font>
							</a>
						</c:otherwise>
					</c:choose>
					</td>
					<td align="center" width="10%">
					<c:choose>
						<c:when test="${items.ing_cnt eq 0}">${items.ing_cnt}</c:when>
						<c:otherwise>
							<a href="javascript:goPersonDetail('${items.user_no}','ING');">
								<font color="blue">${items.ing_cnt}</font>
							</a>
						</c:otherwise>
					</c:choose>					
					</td>
					<td align="center" width="10%">
					<c:choose>
						<c:when test="${items.end_cnt eq 0}">${items.end_cnt}</c:when>
						<c:otherwise>
							<a href="javascript:goPersonDetail('${items.user_no}','DONE');">
								<font color="blue">${items.end_cnt}</font>
							</a>
						</c:otherwise>
					</c:choose>					
					</td>
					<td align="center" width="10%" style="text-align:right;padding-right:10px;">${items.end_per} %</td>					
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>