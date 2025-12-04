<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${processList.size() == 0}">
			<tr>
				<td colspan="9" align="center">검색조회 결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${processList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="process_view_${items.pkey}">
					<td align="center" width="5%">${processList.size() - status.index}</td>
					<td align="center" width="8%">
						<c:choose>
							<c:when test="${items.lecture_type eq 0}">상시교육</c:when>
							<c:otherwise>의무교육</c:otherwise>
						</c:choose>						
					</td>
					<td align="center" width="8%">
						<c:choose>
							<c:when test="${items.team_type eq 1}">물보험본부</c:when>
							<c:when test="${items.team_type eq 4}">인보험본부</c:when>
							<c:otherwise>공통교육</c:otherwise>
						</c:choose>
					</td>					
					<td align="left" width="21%" style="padding-left:5px;">${items.p_title}</td>
					<td align="center" width="15%">${items.apply_sdate_fmt} ~ ${items.apply_edate_fmt}</td>
					<td align="center" width="15%">${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>
					<td align="center" width="7%">
						<c:choose>
							<c:when test="${items.apCnt eq 0}">${items.apCnt}</c:when>
							<c:otherwise>
								<a href="javascript:goProcessDetail('${items.pkey}','AP');">
									<font color="blue">${items.apCnt}</font>
								</a>
							</c:otherwise>
						</c:choose>
					</td>
					<td align="center" width="7%">
						<c:choose>
							<c:when test="${items.ing_cnt eq 0}">${items.ing_cnt}</c:when>
							<c:otherwise>
								<a href="javascript:goProcessDetail('${items.pkey}','ING');">
									<font color="blue">${items.ing_cnt}</font>
								</a>
							</c:otherwise>
						</c:choose>					
					</td>
					<td align="center" width="7%">
						<c:choose>
							<c:when test="${items.end_cnt eq 0}">${items.end_cnt}</c:when>
							<c:otherwise>
								<a href="javascript:goProcessDetail('${items.pkey}','DONE');">
									<font color="blue">${items.end_cnt}</font>
								</a>
							</c:otherwise>
						</c:choose>					
					</td>
					<td width="7%" style="text-align:right;padding-right:20px;">${items.end_per} %</td>					
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>