<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="공개 강의실 정보조회" style="font-size: 12px;" align="center">
	<br/>
	<c:if test="${openLectureMap.day_cnt < 2}">
		<div class="new-label" title="등록일 기준 2일 이내 신규강의입니다.">new</div>
	</c:if>
	<div class="tableStyle2" style="width: 660px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="12%">교육구분</th>
				<td width="20%">
					<c:choose>
						<c:when test="${openLectureMap.team_type eq 1}">물보험</c:when>
						<c:when test="${openLectureMap.team_type eq 4}">인보험</c:when>
						<c:otherwise>공통</c:otherwise>
					</c:choose>					
				</td>
				<th width="12%">교육분류</th>
				<td width="20%">${openLectureMap.category_name}</td>
				<th width="12%">조회수</th>
				<td width="24%">${openLectureMap.view_cnt}</td>				
			</tr>				
			<tr>
				<th>강의명</th>
				<td colspan="3" style="text-align:left;padding-left:5px;">${openLectureMap.subject }</td>
				<th width="12%">강사명</th>
				<td width="24%">${openLectureMap.manager_name}</td>				
			</tr>
			<tr>
				<th>강의설명</th>
				<td colspan="5" style="text-align:left;padding-left:5px;">					
					${openLectureMap.introduce}
				</td>
			</tr>			
			<c:if test="${!empty openLectureMap.file_org_name}">
			<tr>
				<th>교육자료</th>
				<td colspan="5" style="text-align:left;padding-left:5px;">
					<a href="oOpenFileDownload?okey=${openLectureMap.okey}">
						<img src="./resources/ls_img/icon_disket.gif" title="${openLectureMap.file_org_name}">
						${openLectureMap.file_org_name}
					</a>
				</td>
			</tr>			
			</c:if>
			<tr>
				<td align="center" colspan="6">
					<input class="buttonDoneFlag" style="width:120px;height:30px;font-weight:bold;" type="button" onclick="javascript:doOpenClassView('${openLectureMap.okey}');" value="강의시청">
				</td>
			</tr>			
		</table>
	</div>
</div>		