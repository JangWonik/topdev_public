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
<div style="width:700px;height:370px;padding-top:10px;">
	<canvas id="canvas"></canvas>
</div>
<div style="font-weight:bold;padding:10 0 5 10;">
	<font color="#50B4C2">&middot; 팀 평균 초과율(소속센터) : ${center_total_over_per}%</font>
</div>
<div style="font-weight:bold;padding:5 0 5 10;">
	<font color="#FF82C2">&middot; 팀 평균 초과율(소속팀) : ${all_over_per_sum_text}%</font>	
</div>
<%-- <div style="padding-left:10px;color:#DF0101;"><b>&#8251; 전체 평균 : ${all_over_per_sum_text}%</b></div> --%>
<script>
	var color = Chart.helpers.color;
	var barChartData = {		
		labels : [${user_name_val}],
		datasets: [{
			label: '팀 평균 초과율(소속센터)',
			backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
			borderColor: window.chartColors.green,
			borderWidth: 1,
			data: [
				${center_total_over_per_val}				
			]
		},{
			label: '팀 평균 초과율(소속팀)',
			backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
			borderColor: window.chartColors.red,
			borderWidth: 1,
			data: [
				${total_over_per}
				//18
			]
		}, {
			label: '팀원 초과율',
			backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
			borderColor: window.chartColors.blue,
			borderWidth: 1,
			data: [
				${over_per_val}
			]
		}]
	
	};
		
	$(document).ready(function(){
		
		window.resizeTo(800,550);
		
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
						text: '${team_name} 현장보고서 초과율'
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