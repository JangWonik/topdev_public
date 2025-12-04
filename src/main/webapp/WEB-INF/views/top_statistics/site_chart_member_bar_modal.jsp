<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="now" value="<%=new java.util.Date()%>" />
<div id="chart-header-table" title="현장보고서 제출현황 그래프보기" style="font-size: 12px;padding-bottom:20px;" align="center">
	<br/>
	<c:choose>
		<c:when test="${modalType eq 'M'}">		
			<div class="tableStyle2" style="width: 980px;">		
				<table class="vacation-ins-table">
					<tr>
						<th>조회일자</th>												
						<th>센터명</th>
						<th>팀명</th>
						<th>성명</th>
					</tr>
					<tr>
						<td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></td>						
						<td>${center_name}</td>
						<td>${team_name}</td>
						<td>${user_name}</td>
					</tr>
				</table>
			</div>
			<br/>
			<div class="tableStyle2" style="width: 980px;border-top:0px;">		
				<table class="vacation-ins-table">
					<tr>
						<th rowspan="2">수임</th>												
						<th colspan="2">제출</th>
						<th colspan="2">미제출</th>						
					</tr>
					<tr>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
					</tr>
					<tr>
						<td>${suim_cnt}</td>						
						<td>${sub_3_in}</td>
						<td>${sub_3_over }</td>
						<td>${not_3_in}</td>
						<td>${not_3_over}</td>
					</tr>
				</table>
			</div>
		</c:when>		
	</c:choose>
</div>
<div style="width:960px;height:300px;padding-top:10px;">
	<canvas id="canvas"></canvas>
</div>
	<script>
		var MONTHS = ['수임건','제출','미제출'];
		var color = Chart.helpers.color;
		var barChartData = {
			labels: ['수임건','제출','미제출'],
			datasets: [{
				label: '수임건',
				backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
				borderColor: window.chartColors.green,
				borderWidth: 1,
				data: [
					${suim_cnt}
					,${suim_cnt}
					,${suim_cnt}
	
				]
			},{
				label: '3영업일이내',
				backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
				borderColor: window.chartColors.blue,
				borderWidth: 1,
				data: [
					0
					,${sub_3_in}
					,${not_3_in}
				]
			},{
				label: '3영업일초과',
				backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
				borderColor: window.chartColors.red,
				borderWidth: 1,
				data: [
					0
					,${sub_3_over}
					,${not_3_over}
				]
			}]
	
		};

		/* window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
		}; */
		
		$(document).ready(function(){
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myBar = new Chart(ctx, {
				type: 'bar',
				data: barChartData,
				options: {
					responsive: true,
					legend: {
						position: 'top',
					},
					title: {
						display: true,
						text: '현장보고서 제출 현황'
					}
				}
			});
		});//ready
</script>