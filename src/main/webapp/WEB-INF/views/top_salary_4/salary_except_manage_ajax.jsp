<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${exceptList.size() == 0}">
			<tr>
				<td colspan="6" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${exceptList}" varStatus="status">			 	
			 	<tr>
			 		<td width="5%" align="center">${exceptList.size() - status.index}</td>			 		
			 		<td width="15%" align="center">${items.center_name}</td>
			 		<td width="15%" align="center">${items.team_name}</td>
			 		<td width="10%" align="center">${items.work_level_nm}</td>
			 		<td width="15%" align="center">${items.user_name}</td>
			 		<td width="10%" align="center">${items.join_date_fmt}</td>
			 		<td width="10%" align="center">${items.reg_user_name}</td>
			 		<td width="10%" align="center">${items.reg_date_fmt}</td>
			 		<td width="10%" align="center">
			 			<a class="btn-equipment-del-s" id="btn-search" onclick="javascript:doExceptMemberDelete('${items.ekey}','${items.user_name}');" href="#noloc">삭제</a>
			 		</td>
			 	</tr>			 	
			 </c:forEach>			
		</c:otherwise>
	</c:choose>	
</table>