<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="교육신청" style="font-size: 12px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 860px;">
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
				<th width="15%">교육기간</th>
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
				<th width="8%">구분</th>
				<th width="20%">주제</th>
				<th width="22%">개요</th>
				<th width="10%">교육시간</th>
				<th width="8%">강사</th>
				<th width="8%">미리보기</th>				
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
								<td align="center">
									<c:choose>
										<c:when test="${items.preview_flag eq 1}">
											<a class="buttonEduDown" id="btn-search" onclick="javascript:doPrevewEdu('${items.ekey}');" href="#noloc">미리보기</a>
										</c:when>
										<c:otherwise>
											없음
										</c:otherwise>
									</c:choose>									
								</td>								
							</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>			
		</table>
		
		<form id="lectureApplyForm" name="lectureApplyForm" method="post" action="lectureUserApplyAction">
		<input type="hidden" id="applyPkey" name="applyPkey" value="${processInfo.pkey}"/>
		<input type="hidden" id="actionType" name="actionType"/>
		<!-- 수강신청 -->
		<c:if test="${view_type eq 'add'}">
		<br/>		
		<table>
			<tr>
				<th width="15%">신청사유</th>
				<td width="85%"><input type="text" id="user_comment" name="user_comment" style="width:700px;"/></td>
			</tr>
		</table>
		<br/>		
			<input id="applyAddButton" class="btn-equipment-mod" type="button" value="신청하기" style="width:80px;height:40px;font-size:13px;cursor:pointer;" title="신청하기">		
		</c:if>
		<!-- 수강신청취소 -->
		<c:if test="${view_type eq 'view'}">
		<br/>		
		<table>
			<tr>
				<th width="15%">신청사유</th>				
				<td width="85%" style="text-align:left;padding-left:5px;">${processInfo.user_comment}</td>
			</tr>
			<tr>
				<th width="15%">결재상태</th>				
				<td width="85%" style="text-align:left;padding-left:5px;">
					<c:choose>
						<c:when test="${ap_state eq 10}">결재대기</c:when>						
						<c:when test="${ap_state eq 11}">결재완료</c:when>
						<c:when test="${ap_state eq 12}">반려</c:when>		
						<c:when test="${ap_state eq 99}">신청취소</c:when>				
					</c:choose>
				</td>
			</tr>
			<tr>
				<th width="15%">결재의견</th>				
				<td width="85%" style="text-align:left;padding-left:5px;">
					<c:choose>
						<c:when test="${empty processInfo.ap_approval_date_fmt}"></c:when>
						<c:otherwise>
							[${processInfo.ap_approval_date_fmt}] ${processInfo.ap_user_name} : ${processInfo.ap_comment}		
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
		<br/>
		</c:if>
		<c:if test="${view_type ne 'add' and (ap_state ne 11 and !empty ap_state)}">
		<input id="applyCancelButton" class="btn-equipment-gray" type="button" value="신청취소" style="width:80px;height:40px;font-size:13px;cursor:pointer;" title="신청취소">
		</c:if>
		</form>				
	</div>
</div>
<script>
$(document).ready(function () {
	//수강신청버튼
	$("#applyAddButton").on("click", function () {
		$("#actionType").val('apply');
		userApplyAction();			
	});
	
	//수강신청취소버튼
	$("#applyCancelButton").on("click", function () {
		$("#actionType").val('cancel');
		userApplyAction();
	});
	
});
</script>