<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="workjob-modal-dialog" title="세부 인원 조회" style="font-size: 12px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 860px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="10%">구분</th>
				<td width="15%">${paramMap.teamType}종</td>
				<th width="10%">지역</th>
				<td width="15%">${teamZoneVal}</td>
				<th width="10%">보험사</th>
				<td width="15%">
					<c:choose>
						<c:when test="${empty teamPtnrIdVal}"> - </c:when>
						<c:otherwise>${teamPtnrIdVal}</c:otherwise>
					</c:choose>					
				</td>
				<th width="10%">인원수</th>
				<td width="15%">${paramMap.totalCnt} 명</td>
			</tr>
		</table>
		<br/>	
		<table>	
			<tr>
				<th width="12%">순번</th>
				<th width="22%">센터명</th>
				<th width="22%">부서명</th>
				<th width="22%">직무</th>
				<th width="22%">이름</th>
			</tr>
			<c:forEach items="${memberModalList}" var = "memberVo" varStatus="memberStatus">
				<tr>
					<td>${ memberModalList.size() - memberStatus.index}</td>
					<td>${memberVo.center_name}</td>
					<td>${memberVo.team_name}</td>
					<td>${memberVo.work_job_val}</td>
					<td>${memberVo.user_name}</td>
				</tr>				
			</c:forEach>
		</table>		
	</div>
</div>
