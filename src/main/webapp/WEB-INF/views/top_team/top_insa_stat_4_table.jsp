<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
	<c:forEach items="${result4Member}" var = "ptnrMember4">
		<tr>
			<td>${ptnrMember4.team_ptnr_id_val}</td>
			<td>
				<a href="#" onclick="javascript:openModalDetail( 4, ${ptnrMember4.team_zone} , ${ptnrMember4.team_ptnr_id} , ${ptnrMember4.member_2_cnt}, 2 );">
					${ptnrMember4.member_2_cnt}
				</a>
			</td>
			<td>
				<a href="#" onclick="javascript:openModalDetail( 4, ${ptnrMember4.team_zone} , ${ptnrMember4.team_ptnr_id} , ${ptnrMember4.member_3_cnt}, 3 );">
					${ptnrMember4.member_3_cnt}
				</a>
			</td>
			<td>
				<a href="#" onclick="javascript:openModalDetail( 4, ${ptnrMember4.team_zone} , ${ptnrMember4.team_ptnr_id} , ${ptnrMember4.member_4_cnt}, 4 );">
					${ptnrMember4.member_4_cnt}
				</a>
			</td>
			<td>
				${ptnrMember4.member_2_cnt+ptnrMember4.member_3_cnt+ptnrMember4.member_4_cnt}
			</td>			
		</tr>
		<c:set var="zoneId" value="${ptnrMember4.team_zone}"></c:set>
	</c:forEach>
	<tr>
		<th>소계</th>
		<th>
			<a href="#" onclick="javascript:openModalDetail( 4, ${zoneId} , '' , ${member_2_sum}, 2 );">
				${member_2_sum}
			</a>
		</th>
		<th>
			<a href="#" onclick="javascript:openModalDetail( 4, ${zoneId} , '' , ${member_3_sum}, 3 );">
				${member_3_sum}
			</a>
		</th>
		<th>
			<a href="#" onclick="javascript:openModalDetail( 4, ${zoneId} , '' , ${member_4_sum}, 4 );">
				${member_4_sum}
			</a>
		</th>
		<th>
			${member_2_sum+member_3_sum+member_4_sum}
		</th>
	</tr>
</table>
