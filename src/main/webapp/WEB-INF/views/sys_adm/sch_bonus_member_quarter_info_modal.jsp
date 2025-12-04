<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>	
<!-- 신규 파라미터 끝 -->				
<div id="member-detail-dialog" title="직원 성과급 상세정보조회" style="font-size: 12px;" align="center">			
	<div style="text-align:left;padding-bottom:5px;">
		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
		<b> ${memberInfoMap.base_year} 년 &nbsp;<font color="blue">(관리자 : ${memberInfoMap.manager_name})</font></b>
	</div>
	<div class="tableStyle2" style="width: 570px;">				
		<table class="vacation-ins-table">
			<tr>
				<th>분기구분</th>
				<th>부문명</th>
				<th>센터명</th>
				<th>팀명</th>
			</tr>
			<tr>
				<td>${memberInfoMap.quarter_flag}</td>
				<td>${memberInfoMap.team_sector_name}</td>
				<td>${memberInfoMap.center_name}</td>
				<td>${memberInfoMap.team_name}</td>
			<tr/>
			<tr>
				<th>직급</th>
				<th>직책</th>						
				<th>성명</th>
				<th>상태</th>	
			</tr>					
			<tr>
				<td>${memberInfoMap.work_level_name}</td>
				<td>${memberInfoMap.work_type_name}</td>
				<td>${memberInfoMap.user_name}</td>
				<td>
					<c:choose>
						<c:when test="${memberInfoMap.user_state eq 1}">
							퇴사 (${memberInfoMap.out_date_fmt})
						</c:when>
						<c:otherwise>재직중</c:otherwise>
					</c:choose>
				</td>						
			</tr>
			<tr>						
				<th>기준일</th>
				<th>근무일</th>
				<th>근무율</th>
				<th>실적</th>												
			</tr>
			<tr>
				<td>${memberInfoMap.workday_interval}</td>
				<td>${memberInfoMap.workday_cnt}</td>
				<td>${memberInfoMap.workday_per}%</td>
				<td><fmt:formatNumber value="${memberInfoMap.bonus_pay}" pattern="###,###,###"/></td>
			</tr>
			<tr>
				<th colspan="4">기준업무량</th>						
			</tr>
			<tr>
				<th>목표건</th>
				<th>실적건</th>
				<th>달성율</th>
				<th>초과율</th>
			</tr>
			<tr>
				<td>${memberInfoMap.workload_target}</td>
				<td>${memberInfoMap.workload_cnt}</td>
				<td>${memberInfoMap.workload_per}</td>
				<td>							
					<c:choose>
						<c:when test="${memberInfoMap.workload_per > 100}">
							<c:set var="workloadOverPer" value="${memberInfoMap.workload_per - 100}"></c:set>
							<fmt:formatNumber value="${workloadOverPer}" pattern=".0000"/>																	
						</c:when>
						<c:otherwise>0%</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>입사일자</th>
				<th>신입/경력</th>
				<th>시작 기준일</th>
				<th>종료 기준일</th>
			</tr>
			<tr>
				<td>							
					${memberInfoMap.join_date_fmt}
				</td>
				<td <c:if test="${memberInfoMap.work_sdate > memberInfoMap.sdate}">style="background:#F2F5A9;"</c:if>>
					<c:choose>
						<c:when test="${memberInfoMap.bonus_career_state eq 0}">신입</c:when>
						<c:when test="${memberInfoMap.bonus_career_state eq 1}">경력</c:when>
						<c:when test="${memberInfoMap.bonus_career_state eq 2}">일반</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
					(${memberInfoMap.work_sdate})							
				</td>
				<td>
					${memberInfoMap.sdate_fmt}
				</td>
				<td>
					${memberInfoMap.edate_fmt}
				</td>
			</tr>					
		</table>				
	</div>			
</div>	