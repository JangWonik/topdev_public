<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(document).ready(function(){
	setTimeout(function() {
		doProgressList();
	}, 500);
});

function doProgressList(){
	<c:forEach var="jTemp" items="${showUserList}">		
		$("#myProgress_${jTemp.pkey}").val(${jTemp.progress_per});		
	</c:forEach>	
}
</script>
<table>	
	<c:choose>		
		<c:when test="${showUserList.size() == 0}">
			<tr>
				<td colspan="8" align="center">시청이 가능한 교육과정이 없습니다. 수강신청해주세요.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${showUserList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="user_view_${items.pkey}">
					<td align="center" width="5%">${showUserList.size() - status.index}</td>
					<td align="center" width="8%">
						<c:choose>
							<c:when test="${items.show_enable eq 1}">
								<input type="button" value="교육예정" class="buttonReadyFlag" onclick="lectureRelationView(${items.pkey})"/>
							</c:when>
							<c:when test="${items.show_enable eq 2}">
								<input type="button" value="교육종료" class="buttonEndFlag" onclick="lectureRelationView(${items.pkey})"/>
							</c:when>
							<c:when test="${items.progress_per > 99.0}">
								<input type="button" value="교육완료" class="buttonDoneFlag" onclick="lectureRelationView(${items.pkey})"/>													
							</c:when>
							<c:otherwise>
								<input type="button" value="교육진행" class="buttonIngFlag" onclick="lectureRelationView(${items.pkey})"/>
							</c:otherwise>
						</c:choose>						
					</td>
					<td align="center" width="5%">
						<c:choose>
							<c:when test="${items.team_type eq 0}">공통</c:when>
							<c:when test="${items.team_type eq 1}">물보험</c:when>
							<c:when test="${items.team_type eq 4}">인보험</c:when>
						</c:choose>
					</td>
					<td width="10%" align="center">${items.category_name}</td>
					<td width="20%" style="text-align:left;padding-left:5px;" title="${items.p_content}" >${items.p_title}</td>
					<td width="18%" align="center">${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>
					<td width="10%" align="center">${items.total_time_fmt}</td>
					<td width="16%" align="center">					
						<table>
							<tr>
								<td align="center" style="border:0px;" width="60%"><progress value="0" max="100" id="myProgress_${items.pkey}" style="height:10px;width:80%;valign:middle;"></progress></td>
								<td style="border:0px;text-align:right;padding-right:10px;" width="40%"><font color="blue">${items.progress_per}%</font></td>
							</tr>
						</table>
					</td>
					<td width="8%" align="center">
						<c:choose>
							<c:when test="${items.show_enable eq 0}">
								<a href="#noloc" class="btn-equipment-mod" id="btn-search" onclick="doProcessView('${items.pkey}');">진행</a>		
							</c:when>
							<c:otherwise> - </c:otherwise>
						</c:choose>						
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>