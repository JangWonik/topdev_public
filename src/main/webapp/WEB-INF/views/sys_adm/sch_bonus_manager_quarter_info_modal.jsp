<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	
</style>
	<form id="managerActionFrm">
		<input type="hidden" id="editMkey" name="editMkey" value="${managerInfoMap.mkey}"/>		
		<input type="hidden" id="actionFlag" name="actionFlag"/>
		<!-- 신규 파라미터 끝 -->				
		<div id="manager-detail-dialog" title="관리자 분기 정보 수정" style="font-size: 12px;" align="center">			
			<div style="text-align:left;padding-bottom:5px;">
				<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
				<b> ${managerInfoMap.base_year} 년 <c:if test="${managerInfoMap.update_flag eq 1}"><font color="red">(수정완료)</font></c:if></b>
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
						<td>${managerInfoMap.quarter_flag}</td>
						<td>${managerInfoMap.team_sector_name}</td>
						<td>${managerInfoMap.center_name}</td>
						<td>${managerInfoMap.team_name}</td>
					<tr/>
					<tr>
						<th>직급</th>
						<th>직책</th>						
						<th>성명</th>
						<th>상태</th>	
					</tr>					
					<tr>
						<td>${managerInfoMap.work_level_name}</td>
						<td>${managerInfoMap.work_type_name}</td>
						<td>${managerInfoMap.manager_name}</td>
						<td>
							<c:choose>
								<c:when test="${managerInfoMap.user_state eq 1}">
									퇴사 (${managerInfoMap.out_date_fmt})
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
						<td>${managerInfoMap.workday_interval}</td>
						<td>${managerInfoMap.workday_cnt}</td>
						<td>${managerInfoMap.workday_per}%</td>
						<td><fmt:formatNumber value="${managerInfoMap.bonus_pay}" pattern="###,###,###"/></td>
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
						<td>${managerInfoMap.workload_target}</td>
						<td>${managerInfoMap.workload_cnt}</td>
						<td>${managerInfoMap.workload_per}</td>
						<td>							
							<c:choose>
								<c:when test="${managerInfoMap.workload_per > 100}">
									<c:set var="workloadOverPer" value="${managerInfoMap.workload_per - 100}"></c:set>
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
							${managerInfoMap.join_date_fmt}
						</td>
						<td <c:if test="${managerInfoMap.work_sdate > managerInfoMap.sdate}">style="background:#F2F5A9;"</c:if>>
							<c:choose>
								<c:when test="${managerInfoMap.bonus_career_state eq 0}">신입</c:when>
								<c:when test="${managerInfoMap.bonus_career_state eq 1}">경력</c:when>
								<c:when test="${managerInfoMap.bonus_career_state eq 2}">일반</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
							(${managerInfoMap.work_sdate})							
						</td>
						<td>
							<input type="text" class="classCalendar" style="width:80px;text-align:right;padding-right:5px;" id="editSDate" name="editSDate" value="${managerInfoMap.sdate_fmt}"/>
						</td>
						<td>
							<input type="text" class="classCalendar" style="width:80px;text-align:right;padding-right:5px;" id="editEDate" name="editEDate" value="${managerInfoMap.edate_fmt}"/>
						</td>
					</tr>
					<tr>
						<th>발령일자</th>
						<td rowspan="2" colspan="3">
							&#8251; 신입/경력 항목이 노란색인 경우 1회 실적 재계산을 실행해야합니다.
						</td>												
					</tr>
					<tr>
						<td>${managerInfoMap.appointDateFmt}</td>
					</tr>
				</table>				
			</div>			
		</div>
	</form>
<script>
	$(document).ready( function(){									
		_initDatePicker();
	});
	
	function _initDatePicker(){    	 
		$('.classCalendar').datepicker({
			showOn: 'button',
			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			buttonImageOnly: true,
			buttonText: "달력", 
			changeMonth: true,
			changeYear: true,	    	   
			showButtonPanel: false,
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			dateFormat: 'yy-mm-dd',
			firstDay: 0,
			isRTL: false,
			showMonthAfterYear: true
	    });  		
	}
</script>