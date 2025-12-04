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
				<th width="15%">신청자</th>
				<td width="35%">${processInfo.user_name}</td>
			</tr>
			<tr>
				<th width="15%">신청기간</th>
				<td width="35%">${processInfo.apply_sdate_fmt} ~ ${processInfo.apply_edate_fmt}</td>
				<th width="15%">교육기간</th>
				<td width="35%">${processInfo.show_sdate_fmt} ~ ${processInfo.show_edate_fmt}</td>
			</tr>
			<tr>
				<th width="15%">신청사유</th>
				<td width="35%" style="text-align:left;padding-left:5px;">${processInfo.user_comment}</td>
				<th width="15%">결재상태</th>
				<td width="35%">${processInfo.ap_state_val}</td>				
			</tr>
		</table>
		<br/>	
		<table>
			<tr>
				<th width="4%">주제</th>
				<th width="8%">구분</th>
				<th width="17%">주제</th>
				<th width="17%">개요</th>
				<th width="10%">교육시간</th>
				<th width="8%">강사</th>
				<th width="8%">등록일</th>
				<th width="8%">등록자</th>
			</tr>
			<c:choose>
				<c:when test="${processLectureList.size() eq 0}">
					<tr>
						<td colspan="8">해당 과정에 등록되어있는 교육가 없습니다.</td>
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
								<td align="center">${items.reg_user_name}</td>
							</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>			
		</table>
		
		<form id="lectureApprovalForm" name="lectureApprovalForm" method="post" action="lectureManageApprovalAction">
		<input type="hidden" id="applyAkey" name="applyAkey" value="${processInfo.akey}"/>
		<input type="hidden" id="actionType" name="actionType"/>
		<!-- 결재 의견 -->
		<c:if test="${processInfo.ap_state eq 10 and view_type eq 'info'}">
		<br/>		
		<table>
			<tr>
				<th width="15%">결재의견</th>
				<td width="85%"><input type="text" id="ap_comment" name="ap_comment" style="width:700px;"/></td>
			</tr>
		</table>
		<br/>
			<a class="btn-vacation-aprv" id="approvalConfirm" style="background: rgb(87, 146, 194); color: rgb(255, 255, 255) !important;" href="#noloc">승인</a>
			<a class="btn-vacation-aprv" id="approvalReject" style="background: rgb(194, 87, 87); color: rgb(255, 255, 255) !important;" href="#noloc">반려</a>
		</c:if>
		<c:if test="${processInfo.ap_state eq 11 or processInfo.ap_state eq 12}">
		<br/>
		<table>
			<tr>
				<th width="15%">결재의견</th>
				<td width="85%" style="text-align:left;padding-left:5px;">[${processInfo.ap_date_fmt}] ${processInfo.ap_user_name} : ${processInfo.ap_comment}</td>
			</tr>
		</table>
		<br/>
			<c:if test="${view_type eq 'info'}">		
			<a href="#" class="btn-vacation-aprv" id="approvalCancel">결재취소</a>
			</c:if>
		</c:if>		
		</form>				
	</div>
</div>
<script>
$(document).ready(function () {
	//수강신청 결재버튼
	$("#approvalConfirm").on("click", function () {
		$("#actionType").val('confirm');
		//userApplyAction();			
		managerAprovalAction();
	});
	
	//수강신청 결재반려버튼
	$("#approvalReject").on("click", function () {
		$("#actionType").val('reject');
		managerAprovalAction();
	});
	
	//수강신청 결재취소버튼
	$("#approvalCancel").on("click", function () {
		$("#actionType").val('cancel');
		managerAprovalAction();
	});
	
});
</script>