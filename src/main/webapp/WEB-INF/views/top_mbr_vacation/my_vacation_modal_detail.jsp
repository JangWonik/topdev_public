<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="setDate" value="${fn:replace(vacation_date,'-','년 ')}"/>
<!-- 휴가 세부정보 창 시작 -->
<div id="vacation-detail-dialog" title="휴가사용일 상세조회" style="font-size: 15px;display:none;" align="center">	
	<div class="tableStyle2" style="width: 650px;border-top: 0px;">
		<div style="float: left; height: 25px;" >
      		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
      		<span style="font-size:12px;color:#666;font-weight:bold;font-size:12px;font-family:굴림;">      		
      		${setDate}월
      		</span>
		</div>	
		<table class="vacation-ins-table">									
			<tbody>													
				<tr>
					<th width="10%">휴가신청자</th>
					<th width="20%">기간</th>
					<th width="10%">일수</th>
					<th width="10%">종류</th>
					<th width="20%">사유</th>
					<th width="10%">결재상태</th>
				</tr>
				<c:if test="${detailList.size() == 0}">
					<tr>
						<td colspan="6">해당 월에 휴가 사용내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${detailList}" var="item" varStatus="status">
					<tr>
						<td>${item.user_name}</td>
						<td>${item.sdate} ~ ${item.edate}</td>
						<td>
							<c:choose>
								<c:when test="${item.vacation_type eq 100 or item.vacation_type eq 200 or item.vacation_type eq 210}">
									<font color="green"><b>${item.vacation_interval} 일</b></font>
								</c:when>
								<c:otherwise>
									${item.vacation_interval} 일
								</c:otherwise>
							</c:choose>
						</td>
						<td>${item.vacation_type_val}</td>
						<td>${item.vacation_content}</td>
						<td>${item.approval_state_val}</td>
					</tr>
				</c:forEach>
			</tbody>																																																							
		</table>
	</div>
</div>
<!-- 휴가 모달 창 끝 -->