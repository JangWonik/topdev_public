<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${managerList.size() == 0}">
			<tr>
				<td colspan="9" align="center">검색결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${managerList}" varStatus="status">
				<tr>
					<td width="50px;">${managerList.size() - status.index}</td>
					<td width="100px;">${items.center_name}</td>
					<td width="100px;">${items.team_name}</td>
					<td width="100px;">${items.user_name}</td>
					<td width="50px;">${items.work_level_name}</td>
					<td width="100px;">${items.work_type_name}</td>
					<td width="100px;">${items.join_date_fmt}</td>
					<td width="200px;">
						<a href="javascript:doManagerStateChange('${items.user_no}',0)">
							<input type="radio" name="bonus_manager_state_${items.user_no}" id="bonus_manager_state_${items.user_no}_0" value="0" <c:if test="${items.bonus_manager_state == 0}">checked</c:if> onclick="javascript:doManagerStateChange('${items.user_no}',0)"/> 대상
						</a>
						&nbsp;&nbsp;
						<a href="javascript:doManagerStateChange('${items.user_no}',1)">						
							<input type="radio" name="bonus_manager_state_${items.user_no}" id="bonus_manager_state_${items.user_no}_1" value="1" <c:if test="${items.bonus_manager_state == 1}">checked</c:if> onclick="javascript:doManagerStateChange('${items.user_no}',1)"/> 비대상
						</a>
						&nbsp;&nbsp;
						<a href="javascript:doManagerStateChange('${items.user_no}',2)">
							<input type="radio" name="bonus_manager_state_${items.user_no}" id="bonus_manager_state_${items.user_no}_2" value="2" <c:if test="${items.bonus_manager_state == 2}">checked</c:if> onclick="javascript:doManagerStateChange('${items.user_no}',2)"/> 제외
						</a>
					</td>					
					<td width="100px;">
						<c:choose>
							<c:when test="${items.bonus_manager_state == 0}">
								<font style="color:blue;"><b>대상</b></font>
							</c:when>
							<c:when test="${items.bonus_manager_state == 1}">
								<font style="color:green;"><b>비대상</b></font>
							</c:when>
							<c:when test="${items.bonus_manager_state == 2}">
								<font style="color:red;"><b>제외</b></font>
							</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>						
					</td>				
					<c:if test="${managerList.size() < 23}">
						<td width="10px;"></td>
					</c:if>
				</tr>
			</c:forEach>			
		</c:otherwise>
	</c:choose>
</table>