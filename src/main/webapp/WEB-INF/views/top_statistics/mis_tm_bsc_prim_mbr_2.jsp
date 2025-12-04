<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
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

	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_21}' == 0){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready
		
		//년도 클릭 시, 해당 년도 검색 180105
		function goThisYear(){
			var imsiyeartxt = $("#yeartxt").text();
			$("#yeartxt").text(imsiyeartxt);
			$("#viewFromDate").val(--imsiyeartxt+"-12-16");
			$("#viewToDate").val($("#yeartxt").text()+"-12-15");
			misSearchForm.submit();
		}		

		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#yearprev").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(--imsiyeartxt);
	        	$("#viewFromDate").val(--imsiyeartxt+"-12-16");
	        	$("#viewToDate").val($("#yeartxt").text()+"-12-15");
		        misSearchForm.submit();
		    });
		    $("#yearnext").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(imsiyeartxt);
	        	$("#viewFromDate").val($("#yeartxt").text()+"-12-16");
	        	$("#viewToDate").val(++imsiyeartxt+"-12-15");
		        misSearchForm.submit();
		    });
	
		    //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
		    $(".monthbtn").click(function(){
		    	var imsimonth = $(this).attr("id");
		    	var imsiMonthStart = imsimonth -1;
		    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
		    	var imsiMonthStartStr = "0"+imsiMonthStart;
		    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
		        	$("#viewFromDate").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
		        	$("#viewToDate").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "15");
		        if(imsimonth == 1){
		        	$("#viewFromDate").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
		        }
			    misSearchForm.submit();
		    });//monthbtn.click

			$("#team_id").change(function(){
				$("#team_name").val($("#team_id option:selected").text());
			});

			$("#btn_excel").click(function(){
				var data = $("#dataTable").html();
				$("#hidtab").attr('value',data);
				$("#excelform").submit();
			});

		});//$(document).ready
	</script>

</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_statistics/statistics_menu.jsp"></c:import>
	<!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns2">
			<div class="center_cnt2">

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">

							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>${inVO.team_name} 개인별 통계 (농작물,적부&통합매출)</b>
							</div>

							<div style="text-align: right;">
								<img id="yearprev" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="yeartxt" href="#" onclick="goThisYear();">${inVO.viewToDate.substring(0,4)}</a>
								<img id="yearnext" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>

							<form name="misSearchForm" id="misSearchForm" method="GET" action="./getMisTmBscPrimMbr2">
								<input type="hidden" id="user_no" name="user_no" />
								<input type="hidden" id="user_name" name="user_name" />
								<input type="hidden" name="team_type" id="team_type" value="${inVO.team_type}" />
								<input type="hidden" name="team_name" id="team_name" value="${inVO.team_name}" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input	type="text" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}" class="classCalendar"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<b><font color="#0066CC">부터</font></b>&nbsp;&nbsp;&nbsp;

								<input	type="text" id="viewToDate"  name="viewToDate" value="${inVO.viewToDate}" class="classCalendar"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<b><font color="#0066CC">까지</font></b>&nbsp;&nbsp;&nbsp;

								<input type="hidden" name="team_id" id="team_id" value="${inVO.team_id}" />
<!-- 								<select name="team_id" id="team_id"> -->
<!-- 									<option value = "0">-전체팀-</option> -->
<%-- 									<c:forEach var="vo" items="${teamList}" varStatus="status"> --%>
<%-- 											<option value = "${vo.getTeam_id()}" <c:if test="${inVO.team_id == vo.getTeam_id()}"> selected='selected'</c:if>><c:out value="${vo.getTeam_name()}"/></option>		 --%>
<%-- 									</c:forEach> --%>
<!-- 								</select>&nbsp;&nbsp;&nbsp; -->

<!-- 								<b><input type="checkbox" name="basicYN" value="Y" -->
<%-- 											<c:if test="${inVO.basicYN == 'Y'}">checked</c:if> /> 기본수임&nbsp;&nbsp; --%>
<!-- 								<input type="checkbox" name="primYN" value="Y" -->
<%-- 											<c:if test="${inVO.primYN == 'Y'}">checked</c:if> /> 농작물&nbsp;&nbsp; --%>
<!-- 								<input type="checkbox" name="primContractYN" value="Y" -->
<%-- 											<c:if test="${inVO.primContractYN == 'Y'}">checked</c:if> /> 적부</b>&nbsp;&nbsp; --%>

								<input type=image src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0" class="btn">
							</form>

<!-- 							<p style="display: inline; float: right;"> -->
<!-- 								<input type=image src="./resources/ls_img/btn_excel.gif" width="70" height="17" border="0" id="btn_excel"> -->
<!-- 							</p> -->

<!-- 							<br/> -->

<!-- 							<form action="./log_member_excel" method="POST" id="excelform"> -->
<!-- 								<input type="hidden" name="hidtab" id="hidtab" /> -->
<!-- 							</form> -->

						</div>
					</div>
				</div><!-- //centercnt_top -->

				<div class="centercnt_bot2" style="margin:0 auto;">
					<div class="guest">

						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">${inVO.team_name} 개인별 통계 Mbr</a></li>
							</ul>
						</div>
						<div class="guestcnt2" style="display:block;">
							<c:import url="./mis_tm_bsc_prim_mbr_21.jsp"></c:import>
						</div>

					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>