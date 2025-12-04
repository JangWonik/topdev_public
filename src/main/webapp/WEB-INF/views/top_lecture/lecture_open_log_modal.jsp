<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="공개 강의실 조회로그" style="font-size: 12px;" align="center">
	<br/>	
	<div class="tableStyle2" style="width: 660px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="10%">No</th>
				<th width="18%">센터명</th>
				<th width="18%">팀명</th>
				<th width="18%">이름</th>
				<th width="18%">아이피</th>
				<th width="18%">조회일</th>
			</tr>
			<c:choose>
				<c:when test="${openLectureLogList.size() eq 0}">
					<tr>
						<td colspan="6">조회된 내역이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="items" items="${openLectureLogList}" varStatus="status">
						<tr>
							<td align="center">${openLectureLogList.size() - status.index}</td>
							<td>${items.center_name}</td>
							<td>${items.team_name}</td>
							<td>${items.user_name}</td>
							<td>${items.user_ip}</td>
							<td>${items.reg_date_fmt}</td>							
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>			
		</table>
	</div>
</div>		