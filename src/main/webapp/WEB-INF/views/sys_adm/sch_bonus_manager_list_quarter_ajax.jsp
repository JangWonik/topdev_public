<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${managerList.size() == 0}">
			<tr>
				<td colspan="14" align="center">검색결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${managerList}" varStatus="status">
				<tr onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
					<td width="40px;">${managerList.size() - status.index}</td>
					<td width="60px;">${items.base_year}</td>
					<td width="40px;">${items.quarter_flag}</td>
					<td width="90px;" title="${items.center_name}">
						<c:choose>
							<c:when test="${fn:length(items.center_name) > 8}">
								${fn:substring(items.center_name,0,8)}..
							</c:when>
							<c:otherwise>${items.center_name}</c:otherwise>
						</c:choose>						
					</td>
					<td width="90px;">${items.team_name}</td>
					<td width="90px;"><c:if test="${items.update_flag eq 1}"><font color="red">*</font></c:if> ${items.manager_name}</td>
					<td width="50px;">${items.work_level_name}</td>					
					<td width="90px;" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${items.bonus_pay}" pattern="###,###,###"/></td>					
					<td width="90px;">${items.workload_target}</td>
					<td width="90px;">${items.workload_cnt}</td>
					<td width="90px;">${items.workload_per}%</td>
					<td width="70px;">${items.sdate_fmt}</td>
					<td width="70px;">${items.edate_fmt}</td>
					<c:choose>
						<c:when test="${items.work_sdate > items.sdate}">							
							<td width="70px;" style="background:#F2F5A9;">${items.join_date_fmt}</td>
						</c:when>
						<c:otherwise>
							<td width="70px;">${items.join_date_fmt}</td>		
						</c:otherwise>
					</c:choose>					
					<td width="100px;">
						<input type="button" style="cursor:pointer;width:50px;" class="btn-vacation-aprv" id="btn-search" onclick="javascript:fnTeamModifyModal('${items.mkey}','${items.manager_name}');" value="수정"/>						
						<input type="button" style="cursor:pointer;width:50px;background:#F6CEEC;" class="btn-vacation-aprv" id="btn-search" onclick="javascript:fnTeamDel('${items.mkey}','${items.manager_name}');" value="삭제"/>
					</td>
					<c:if test="${managerList.size() < 23}">
						<td width="15px;"></td>
					</c:if>
				</tr>
			</c:forEach>			
		</c:otherwise>
	</c:choose>
</table>