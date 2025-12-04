<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${memberList.size() == 0}">
			<tr>
				<td colspan="11" align="center">검색결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${memberList}" varStatus="status">
				<tr onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
					<td width="40px;">${memberList.size() - status.index}</td>
					<td width="100px;" title="${items.team_sector_name}">
						<c:choose>
							<c:when test="${fn:length(items.team_sector_name) > 8}">
								${fn:substring(items.team_sector_name,0,8)}..
							</c:when>
							<c:otherwise>${items.team_sector_name}</c:otherwise>
						</c:choose>						
					</td>
					<td width="100px;">${items.center_name}</td>
					<td width="100px;">${items.team_name}</td>
					<td width="100px;">${items.user_name}</td>
					<td width="40px;">${items.work_level_name}</td>
					<td width="40px;">${items.quarter_flag}</td>
					<td width="90px;" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${items.bonus_pay}" pattern="###,###,###"/></td>
					<td width="50px;">${items.workday_interval}</td>
					<td width="50px;">${items.workday_cnt}</td>
					<td width="50px;">${fn:replace(items.workday_per,'.0','')}%</td>
					<td width="90px;">${items.workload_target}</td>
					<td width="90px;">${items.workload_cnt}</td>
					<td width="90px;">${items.workload_per}%</td>
					<td width="90px;">${items.base_date_fmt}</td>
					<c:if test="${mbrVo_Session.user_state == 9}">
						<td width="50px;">
							<input type="button" style="cursor:pointer;" class="btn-vacation-aprv" id="btn-search" onclick='javascript:fnModifyModal(${items.skey});' value="수정"/>
						</td>					
					</c:if>
					<c:if test="${memberList.size() < 23}">
						<td width="15px;"></td>
					</c:if>
				</tr>
			</c:forEach>			
		</c:otherwise>
	</c:choose>
</table>