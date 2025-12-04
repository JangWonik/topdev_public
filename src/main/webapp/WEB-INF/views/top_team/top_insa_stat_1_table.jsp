<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
	<c:forEach items="${result1Member}" var = "ptnrMember1">
		<tr>
			<td>${ptnrMember1.team_ptnr_id_val}</td>
			<td>
				<a href="#" onclick="javascript:openModalDetail( 1, ${ptnrMember1.team_zone} , ${ptnrMember1.team_ptnr_id} , ${ptnrMember1.member_cnt}, 2 );">
					${ptnrMember1.member_cnt}
				</a>
			</td>				
		</tr>
		<c:set var="zoneId" value="${ptnrMember1.team_zone}"></c:set>
	</c:forEach>
	<tr>
		<th>소계</th>
		<th>
			<a href="#" onclick="javascript:openModalDetail( 1, ${zoneId} , '' , ${member_sum}, 2 );">
				${member_sum}
			</a>
		</th>
	</tr>
</table>