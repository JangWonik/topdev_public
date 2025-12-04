<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 수임취소 창 시작 -->
<div id="cancel-view-dialog" title="수임취소" style="font-size: 15px;display:none;" align="center">
	<br/>
	<div class="tableStyle2">
		<table class="vacation-ins-table">					
			<tbody>	
				<tr>
					<th width="10%">기준일</th>
					<td width="20%">${base_date}</td>
					<th width="10%">부서명</th>
					<td width="30%">${team_name}</td>
					<th width="10%">이름</th>
					<td width="20%">${user_name}</td>
				</tr>
				<tr>
					<th>삭제</th>
					<th>수임일자</th>
					<th colspan="2">취소건수</th>
					<th colspan="2">처리자</th>					
				</tr>
				<c:choose>
					<c:when test="${cancelList.size() == 0}">
						<tr>
							<td colspan="6">취소처리 내역이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${cancelList}" var="item" varStatus="status">
							<tr>
								<td><a href="javascript:cancelDel(${item.serialNo})"><img src="/resources/ls_img/btn_del_s.gif" style="cursor:pointer;"></a></td>
								<td>${item.suimDateFmt}</td>
								<td colspan="2">${item.cancelCnt} 건</td>
								<td colspan="2">${item.logUserName}</td>
							</tr>							
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>																																										
		</table>		
	</div>
</div>
<!-- 수임취소 창 시작 -->