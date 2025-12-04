<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${careerList.size() == 0}">
			<tr>
				<td colspan="9" align="center">검색결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${careerList}" varStatus="status">
				<tr>
					<td width="50px;">${careerList.size() - status.index}</td>
					<td width="100px;">${items.center_name}</td>
					<td width="100px;">${items.team_name}</td>
					<td width="100px;">${items.user_name}</td>
					<td width="50px;">${items.work_level_name}</td>
					<td width="100px;">${items.work_type_name}</td>
					<td width="100px;">${items.join_date_fmt}</td>
					<td width="200px;">
						<a href="javascript:doCareerStateChange('${items.user_no}',0)">
							<input type="radio" name="bonus_career_state_${items.user_no}" id="bonus_career_state_${items.user_no}_0" value="0" <c:if test="${items.bonus_career_state == 0}">checked</c:if> onclick="javascript:doCareerStateChange('${items.user_no}',0)"/> 신입직
						</a>
						&nbsp;&nbsp;
						<a href="javascript:doCareerStateChange('${items.user_no}',1)">						
							<input type="radio" name="bonus_career_state_${items.user_no}" id="bonus_career_state_${items.user_no}_1" value="1" <c:if test="${items.bonus_career_state == 1}">checked</c:if> onclick="javascript:doCareerStateChange('${items.user_no}',1)"/> 경력직
						</a>
						&nbsp;&nbsp;
						<a href="javascript:doCareerStateChange('${items.user_no}',2)">						
							<input type="radio" name="bonus_career_state_${items.user_no}" id="bonus_career_state_${items.user_no}_2" value="2" <c:if test="${items.bonus_career_state == 2}">checked</c:if> onclick="javascript:doCareerStateChange('${items.user_no}',2)"/> 일반직
						</a>						
					</td>					
					<td width="100px;">
						<c:choose>
							<c:when test="${items.bonus_career_state == 0}">
								<font style="color:blue;"><b>신입직</b></font>
							</c:when>
							<c:when test="${items.bonus_career_state == 1}">
								<font style="color:green;"><b>경력직</b></font>
							</c:when>							
							<c:when test="${items.bonus_career_state == 2}">
								<font style="color:red;"><b>일반직</b></font>
							</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>						
					</td>				
					<c:if test="${careerList.size() < 23}">
						<td width="10px;"></td>
					</c:if>
				</tr>
			</c:forEach>			
		</c:otherwise>
	</c:choose>
</table>