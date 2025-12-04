<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
<script src="./resources/wm_js/common.js"></script>
<!-- chart 추가 -->	
<script src="./resources/chart/Chart.min.js"></script>	
<script src="./resources/chart/utils.js"></script>
<div style="width:${nYsize}px;height:${nXsize}px;padding-top:10px;">
	<canvas id="canvas"></canvas>
</div>
<c:choose>
	<c:when test="${viewType eq 'center_sel' or viewType eq 'team_sel' }">
		<div style="font-weight:bold;padding:10 0 5 10;">
			<font color="#50B4C2">&middot; ${title_sub3} : ${total_over_per}%</font>
		</div>
		<div style="font-weight:bold;padding:5 0 5 10;">
			<font color="#FF82C2">&middot; ${title_sub1} : ${all_over_per_sum_text}%</font>	
		</div>		
	</c:when>
	<c:otherwise>
		<div style="font-weight:bold;padding:10 0 5 10;">
			<font color="#FF82C2">&middot; ${title_sub1} : ${all_over_per_sum_text}%</font>	
		</div>		
	</c:otherwise>
</c:choose>
<script>		
	var color = Chart.helpers.color;
	
	if( '${viewType}' == 'center_sel' || '${viewType}' == 'team_sel' ){		
		var barChartData = {		
				labels : [${all_name}],				
				datasets: [{
					label: '${title_sub3}',
					backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
					borderColor: window.chartColors.green,
					borderWidth: 1,
					data: [
						${total_over_per_val}						
					]
				},{
					label: '${title_sub1}',					
					backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
					borderColor: window.chartColors.red,
					borderWidth: 1,
					data: [
						${all_over_per_sum}						
					]
				}, {
					label: '${title_sub2}',					
					backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
					borderColor: window.chartColors.blue,
					borderWidth: 1,
					data: ${all_over_per}
				}]
			
			};		
	}else{
		var barChartData = {		
				labels : [${all_name}],
				datasets: [{
					label: '${title_sub1}',
					backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
					borderColor: window.chartColors.red,
					borderWidth: 1,
					data: [
						${all_over_per_sum}
						//18
					]
				}, {
					label: '${title_sub2}',
					backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
					borderColor: window.chartColors.blue,
					borderWidth: 1,
					data: ${all_over_per}
				}]
			
			};
	}
		
	$(document).ready(function(){
		
		window.resizeTo(${nYsize+150},${nXsize+200});
		
		var ctx = document.getElementById('canvas').getContext('2d');
			window.myBar = new Chart(ctx, {
				type: 'bar',
				data: barChartData,				
				options: {
					responsive: true,
					legend: {
						position: 'bottom',						
					},
					title: {
						display: true,
						fontColor: "#2E2EFE",
						text: '${title_main}'
					},
					scales: {
						yAxes: [{
			                display: true,
			                ticks: {			                	
			                    min: 0,
			                    max: 100
			                },
			            }],
				    },
				    tooltips: {
				         enabled: false
				    }
				}
			});
	});//ready
</script>