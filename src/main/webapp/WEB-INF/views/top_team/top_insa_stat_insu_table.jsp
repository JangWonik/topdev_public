<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
	<c:forEach items="${ptnrToZoneList}" var = "ptnrZoneMember">
		<tr>
			<td width="151px" style="border-right:2px solid #cfcfcf;">${ptnrZoneMember.team_zone_val}</td>
			<td width="155px" style="border-right:2px solid #cfcfcf;">
				<a href="#" onclick="javascript:openModalDetail( 1, ${ptnrZoneMember.team_zone} , ${ptnrZoneMember.team_ptnr_id} , ${ptnrZoneMember.ptnr_member_cnt_1_2}, 2 );">
					${ptnrZoneMember.ptnr_member_cnt_1_2}
				</a>
			</td>				
			<td width="154px">
				<a href="#" onclick="javascript:openModalDetail( 4, ${ptnrZoneMember.team_zone} , ${ptnrZoneMember.team_ptnr_id} , ${ptnrZoneMember.ptnr_member_cnt_4_2}, 2 );">
					${ptnrZoneMember.ptnr_member_cnt_4_2}
				</a>
			</td>
			<td width="154px">
				<a href="#" onclick="javascript:openModalDetail( 4, ${ptnrZoneMember.team_zone} , ${ptnrZoneMember.team_ptnr_id} , ${ptnrZoneMember.ptnr_member_cnt_4_3}, 3 );">
					${ptnrZoneMember.ptnr_member_cnt_4_3}
				</a>
			</td>
			<td width="154px">
				<a href="#" onclick="javascript:openModalDetail( 4, ${ptnrZoneMember.team_zone} , ${ptnrZoneMember.team_ptnr_id} , ${ptnrZoneMember.ptnr_member_cnt_4_4}, 4 );">
					${ptnrZoneMember.ptnr_member_cnt_4_4}
				</a>
			</td>
			<td width="155px" style="border-right:2px solid #cfcfcf;">
				${ptnrZoneMember.ptnr_member_cnt_4_2 + ptnrZoneMember.ptnr_member_cnt_4_3 + ptnrZoneMember.ptnr_member_cnt_4_4}
			</td>
			<th width="154px">
				<font color="green">
					${ptnrZoneMember.ptnr_member_cnt_1_2 + ptnrZoneMember.ptnr_member_cnt_4_2 + ptnrZoneMember.ptnr_member_cnt_4_3 + ptnrZoneMember.ptnr_member_cnt_4_4}
				</font>
			</th>
		</tr>
		<c:set var="ptnrId" value="${ptnrZoneMember.team_ptnr_id}"></c:set>
	</c:forEach>
	<tr>
		<th style="border-bottom:0px;border-right:2px solid #cfcfcf;">소계</th>
		<th style="border-bottom:0px;border-right:2px solid #cfcfcf;">
			<a href="#" onclick="javascript:openModalDetail( 1, '' , ${ptnrId} , ${member_1_2_sum}, 2 );">
				${member_1_2_sum}
			</a>
		</th>
		<th style="border-bottom:0px;">
			<a href="#" onclick="javascript:openModalDetail( 4, '' , ${ptnrId} , ${member_4_2_sum}, 2 );">
				${member_4_2_sum}
			</a>
		</th>
		<th style="border-bottom:0px;">
			<a href="#" onclick="javascript:openModalDetail( 4, '' , ${ptnrId} , ${member_4_3_sum}, 3 );">
				${member_4_3_sum}
			</a>
		</th>
		<th style="border-bottom:0px;">
			<a href="#" onclick="javascript:openModalDetail( 4, '' , ${ptnrId} , ${member_4_4_sum}, 4 );">
				${member_4_4_sum}			
			</a>
		</th>
		<th style="border-bottom:0px;border-right:2px solid #cfcfcf;">
			${member_4_2_sum+member_4_3_sum+member_4_4_sum}
		</th>
		<th style="border-bottom:0px;">
			<font color="green">			
				${member_1_2_sum + member_4_2_sum + member_4_3_sum + member_4_4_sum}
			</font>
		</th>
	</tr>
</table>
