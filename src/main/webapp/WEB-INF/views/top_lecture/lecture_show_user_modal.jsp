<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="교육시청하기" style="font-size: 12px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 1000px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="15%">교육과정 명</th>
				<td width="35%">${processInfo.p_title}</td>				
				<th width="15%">총 교육시간</th>
				<td width="35%">${total_time_fmt}</td>
			</tr>				
			<tr>
				<th width="15%">신청기간</th>
				<td width="35%">${processInfo.apply_sdate_fmt} ~ ${processInfo.apply_edate_fmt}</td>
				<th width="15%">시청기간</th>
				<td width="35%">${processInfo.show_sdate_fmt} ~ ${processInfo.show_edate_fmt}</td>
			</tr>
			<tr>
				<th width="15%">교육과정 설명</th>
				<td width="85%" colspan="3" style="text-align:left;padding-left:5px;">
					<c:choose>
						<c:when test="${processInfo.qna_use eq 1}">
							<div style="float:left;padding-left:5px;">${processInfo.p_content}</div>
							<div style="float:right;padding-right:5px;">
								<input type="button" value="Q&A" class="buttonShowQna" onclick="javascript:doQna('${processInfo.pkey}');"/>	
							</div>
						</c:when>
						<c:otherwise>
							${processInfo.p_content}
						</c:otherwise>
					</c:choose>					
				</td>
			</tr>			
		</table>
		<br/>	
		<table>
			<tr>
				<th width="4%">No</th>
				<th width="5%">구분</th>
				<th width="16%">주제</th>
				<th width="16%">개요</th>
				<th width="8%">교육시간</th>
				<th width="9%">강사</th>
				<th width="9%">등록일</th>				
				<th width="5%">진도율</th>
				<th width="16%">비고</th>
			</tr>
			<c:choose>
				<c:when test="${processLectureList.size() eq 0}">
					<tr>
						<td colspan="7">해당 교육과정에 등록되어있는 주제가 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="items" items="${processLectureList}" varStatus="status">
						<tr>
							<td align="center">${status.count}</td>
								<td align="center">
									<c:choose>
										<c:when test="${items.team_type eq 0}">공통</c:when>
										<c:when test="${items.team_type eq 1}">물보험</c:when>
										<c:when test="${items.team_type eq 4}">인보험</c:when>
									</c:choose>
								</td>
								<td style="text-align:left;padding-left:5px;">${items.subject}</td>
								<td style="text-align:left;padding-left:5px;">${items.introduce}</td>
								<c:set var="timeSecondFmt" value="${fn:replace(items.time_second_fmt,'00시간','')}"/>
								<td align="center">${timeSecondFmt}</td>
								<td align="center">${items.manager_name}</td>								
								<td align="center">${items.reg_date_fmt}</td>								
								<td align="center">${items.progress_per} %</td>
								<td align="center">
									<c:choose>
										<c:when test="${empty items.file_org_name}">
											<a href="#noloc" class="buttonEduView" id="btn-search" onclick="javascript:doShowEdu('${items.ekey}');">시청</a>
										</c:when>
										<c:otherwise>																				
											<a href="#noloc" class="buttonEduView" id="btn-search" onclick="javascript:doShowEdu('${items.ekey}');">시청</a>
											<a href="eInfoFileDownload?ekey=${items.ekey}" class="buttonEduDown" id="btn-search">자료</a>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>			
		</table>					
	</div>
</div>
<script>
$(document).ready(function () {
	//수강신청버튼
	$("#applyAddButton").on("click", function () {
		$("#actionType").val('apply');
		userApplyAction();			
	});
	
});
</script>