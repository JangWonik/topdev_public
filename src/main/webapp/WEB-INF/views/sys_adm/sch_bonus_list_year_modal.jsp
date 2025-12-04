<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	
</style>
	<form id="schActionFrm">
		<input type="hidden" id="editSkey" name="editSkey" value="${schInfoMap.skey}"/>
		<input type="hidden" id="actionFlag" name="actionFlag"/>
		<!-- 신규 파라미터 끝 -->				
		<div id="sch-detail-dialog" title="휴가 결재" style="font-size: 12px;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 700px;">
				<table class="vacation-ins-table">
					<tr>
						<th>부문명</th>
						<th>센터명</th>
						<th>팀명</th>
						<th>직급</th>
						<th>직책</th>
						<th>성명</th>						
					</tr>
					<tr>
						<td>${schInfoMap.team_sector_name}</td>
						<td>${schInfoMap.center_name}</td>
						<td>${schInfoMap.team_name}</td>
						<td>${schInfoMap.work_level_name}</td>
						<td>${schInfoMap.work_type_name}</td>
						<td>${schInfoMap.user_name}</td>
					</tr>
					<tr>
						<th>실적</th>
						<th>기준일</th>
						<th>근무일</th>
						<th>근무율</th>
						<th>목표건</th>
						<th>실적건</th>						
					</tr>
					<tr>
						<td><input type="text" style="width:90px;text-align:right;padding-right:5px;" id="editBonusPay" name="editBonusPay" value="${schInfoMap.bonus_pay}"/></td>
						<td><input type="text" style="width:90px;text-align:right;padding-right:5px;" id="editWorkdayCnt" name="editWorkdayCnt" value="${schInfoMap.workday_cnt}"/></td>
						<td><input type="text" style="width:90px;text-align:right;padding-right:5px;" id="editWorkdayInterval" name="editWorkdayInterval" value="${schInfoMap.workday_interval}"/></td>
						<td><input type="text" style="width:90px;text-align:right;padding-right:5px;" id="editWorkdayPer" name="editWorkdayPer" value="${schInfoMap.workday_per}"/></td>
						<td><input type="text" style="width:90px;text-align:right;padding-right:5px;" id="editWorkloadTarget" name="editWorkloadTarget" value="${schInfoMap.workload_target}"/></td>
						<td><input type="text" style="width:90px;text-align:right;padding-right:5px;" id="editWorkloadCnt" name="editWorkloadCnt" value="${schInfoMap.workload_cnt}"/></td>
					</tr>
					<tr>
						<th>성과율</th>
						<th>기준일자</th>
						<th colspan="4"></th>
					</tr>
					<tr>
						<td><input type="text" style="width:90px;text-align:right;padding-right:5px;" id="editWorkloadPer" name="editWorkloadPer" value="${schInfoMap.workload_per}"/></td>
						<td><input type="text" class="classCalendar" style="width:70px;text-align:right;padding-right:5px;" id="editBaseDate" name="editBaseDate" value="${schInfoMap.base_date_fmt}"/></td>
						<td colspan="4"></td>
					</tr>
				</table>
				<div style="padding-top:10px;text-align:left;">&#8251; 조회기간 중 퇴직 직원은 해당 분기 마지막 스케줄러 정보의 기준일자를 분기 마지막 날짜로 변경해야 성과급이 조회됩니다.</div>
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