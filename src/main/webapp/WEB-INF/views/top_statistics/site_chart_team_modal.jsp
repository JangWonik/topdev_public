<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="chart-header-table" title="현장보고서 제출현황 그래프보기" style="font-size: 12px;padding-bottom:20px;" align="center">
	<br/>
	<c:choose>
		<c:when test="${modalType eq 'T'}">		
			<div class="tableStyle2" style="width: 980px;">		
				<table class="vacation-ins-table">
					<tr>
						<th>조회일자</th>
						<th>부문명</th>						
						<th>센터명</th>
						<th>팀명</th>						
					</tr>
					<tr>
						<td>${chart_interval_days}</td>
						<td>${teamSiteMap.sector_name}</td>
						<td>${teamSiteMap.center_name}</td>
						<td>${teamSiteMap.team_name}</td>						
					</tr>
				</table>
			</div>
		</c:when>		
	</c:choose>
</div>
<div style="width:960px;height:600px;padding-top:10px;">
	<canvas id="canvas"></canvas>
</div>
	<script>
		var MONTHS = [${chart_period_val}];		
		var config = {
			type: 'line',
			data: {
				labels: [${chart_period_val}],
				datasets: [{
					label: '팀 초과율',
					fill: false,
					backgroundColor: window.chartColors.blue,
					borderColor: window.chartColors.blue,
					data: [
						${chart_team_val}
					],
				}, {
					label: '센터 초과율',
					fill: false,
					backgroundColor: window.chartColors.green,
					borderColor: window.chartColors.green,
					data: [
						${chart_center_val}
					],
				}, {
					label: '부문 초과율',
					fill: false,
					backgroundColor: window.chartColors.yellow,
					borderColor: window.chartColors.yellow,
					data: [
						${chart_sector_val}
					],
				}, {
					label: '전체 초과율',
					fill: false,
					backgroundColor: window.chartColors.purple,
					borderColor: window.chartColors.purple,
					data: [
						${chart_all_val}
					],
				}]
			},
			options: {
				responsive: true,
				title: {
					display: true,
					text: '현장보고서 초과율'
				},
				tooltips: {
					mode: 'index',
					intersect: true,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: '일자'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: '초과율'
						}
					}]
				}
			}
		};

		/* window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
		}; */
		
		$(document).ready(function(){
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
		});//ready
</script>