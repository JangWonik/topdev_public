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
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
	
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_21}' == 0){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});
			$("#team_id").select2();
			$("#search_no").select2();
			
			$("#yearprev").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(--imsiyeartxt);
	        	$("#viewFromDate").val(--imsiyeartxt+"-12-16");
	        	$("#viewToDate").val($("#yeartxt").text()+"-12-15");
		        misSearchForm.submit();
		    });
		    $("#yearnext").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(++imsiyeartxt);
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
		    
		    /* 처리팀 지정 */
		    $("#team_id").change(function(){
				var team_id = $("#team_id option:selected").val();
				$.post("topMbrForSelectedTeam"
						,{ team_id : team_id }
						,function(data,status){
							if(status == "success"){
								$("#search_no").empty();
								if(data.length == 0){
									$("#search_no").append(
										"<option value='0'>"
											+"직원 없음"
										+"</option>"
									);
								}else{
									$("#search_no").append( "<option value = '0'>직원 미지정</option>");
									
				                    $.each(data, function(index, entry) {
			                    		$("#search_no").append(
		                    				"<option value = '"+entry.user_no+"' data-search-team = '"+entry.team_id+"'>"
												+entry.user_name
	                                		+ "</option>"
			   							);
									});//each
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
						,"json"
				);//post
			});//$("#topTeamId").change()			    

			$("#search_no").change(function(){
				if($("#team_id").val() == 0){
					var team_id = $("#search_no option:selected").data("search-team");
					$("#team_id").val(team_id).select2();
				}
			});
			
			_initSrchParam();
			
		});//$(document).ready
		
		function fnCostTab(m) {
	        $("#srch_flag").val(m);
	        var frm = document.getElementById("misSearchForm");
	        frm.submit();
	    }

		function _initSrchParam(){

			$("#team_id").select2();
			$("#search_no").select2();
			
			var team_id = $("#srch_team_id").val();
			var user_no = $("#srch_user_no").val();
			
			$("#team_id").val(team_id).select2();
 			$("#team_id").change();
 			
			setTimeout(function() {
				$("#search_no").val(user_no).select2();
// 				$("#search_no").change();			
			}, 200);
			
		}		
	</script>

</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
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
								&nbsp;<b>${getTeamInfo.team_name} 개인별 경비 통계</b>
							</div>

							<div style="text-align: right;">
								<img id="yearprev" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="yeartxt" href="#">${inVO.viewToDate.substring(0,4)}</a>
								<img id="yearnext" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>

							<form name="misSearchForm" id="misSearchForm" method="GET" action="./topCostStatisticsTmMbr">
								<input type="hidden" id="user_no" name="user_no" />
<!-- 								<input type="hidden" id="user_name" name="user_name" /> -->
								<input type="hidden" name="team_type" id="team_type" value="${inVO.team_type}" />
<%-- 								<input type="hidden" name="team_name" id="team_name" value="${inVO.team_name}" /> --%>
								<input type="hidden" id="srch_flag" name="srch_flag" value="${srch_flag}"/>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input	type="text" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}" class="classCalendar"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<b><font color="#0066CC">부터</font></b>&nbsp;&nbsp;&nbsp;

								<input	type="text" id="viewToDate"  name="viewToDate" value="${inVO.viewToDate}" class="classCalendar"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<b><font color="#0066CC">까지</font></b>&nbsp;&nbsp;&nbsp;
<!-- 								<input type=image src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0" class="btn"><br /> -->
<!-- 								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
								<select class="team_id" name="team_id" id="team_id" style="width:180px;" >
									<option value="0" selected>전체</option>
									<c:forEach items="${topTeamList}" var = "topTeamVo">
										<option value="${topTeamVo.team_id}">
										<c:if test="${topTeamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
										<c:if test="${topTeamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
											${topTeamVo.team_name}
										</option>
									</c:forEach>
								</select>								
								<select name="search_no" id="search_no" style="width:180px;">
									<option value="0">직원 미지정</option>
									<c:forEach items="${topMbrList}" var="item">
										<option value="${item.user_no}" data-search-team="${item.team_id}">${item.user_name}</option>
									</c:forEach>									
								</select>	
								<input type="image" onclick="fnSearchUserBtn();" src="./resources/wm_img/common/bg_btnbg01.gif" style="width:56px;height:26px;border:0px;" class="btn">
								<input type="hidden" id="srch_user_no" name="srch_user_no" value="<%=request.getParameter("search_no") %>"/>
								<input type="hidden" id="srch_team_id" name="srch_team_id"  value="<%=request.getParameter("team_id") %>"/>
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
								<li class="on">
									<a href="#" >개인별 경비 통계</a>
								</li>
								<li class="">
									<a href="#" >개인별 추가 경비 통계</a>
								</li>
								<li class="">
									<a href="#">개인별 클레임 교통비 통계</a>
								</li>
							</ul>						
							<div class="guestcnt4" style="display:block;">
								<c:import url="./top_cost_statistics_tm_mbr1.jsp"></c:import>
							</div>
							<div class="guestcnt4" style="display:none;">
								<c:import url="./top_cost_statistics_tm_mbr2.jsp"></c:import>
							</div>
							<div class="guestcnt4" style="display:none;">
								<c:import url="./top_cost_statistics_tm_mbr3.jsp"></c:import>
							</div>
						</div>
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>