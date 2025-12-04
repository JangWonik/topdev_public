<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 이내첩 창 시작 -->
<div id="cancel-view-dialog" title="이&middot;내첩" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2">
		<table class="vacation-ins-table">					
			<tbody>	
				<tr>
					<th width="10%">처리일</th>
					<td width="20%">${base_date}</td>
					<th width="10%">부서명</th>
					<td width="30%">${team_name}</td>
					<th width="10%">이름</th>
					<td width="20%">${user_name}</td>
				</tr>
				<tr>
					<th colspan="2">수임일자</th>
					<th>건수</th>
					<th>이&middot;내첩 담당자</th>
					<th>내역</th>
					<th>처리자</th>
				</tr>
				<c:choose>
					<c:when test="${transList.size() == 0}">
						<tr>
							<td colspan="6">이내첩 처리 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${transList}" var="item" varStatus="status">
							<tr>
								<td colspan="2">${item.suimDateFmt}</td>
								<td>${item.transCntMinus} 건</td>
								<td>${item.transUserName}</td>
								<td>${item.transFlag}</td>
								<td>${item.logUserName}</td>
							</tr>							
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>																																										
		</table>		
	</div>
</div>
<!-- 수임취소 창 시작 -->