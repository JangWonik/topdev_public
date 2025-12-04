<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=2" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/tooltipsy/tooltipsy.min.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script defer src="./resources/fontawesome_5.0/svg-with-js/js/fontawesome-all.js"></script>
	<style>
		.left-box{
			height: 120px;
			width : 49%;
			float : left;
/* 			border : 1px solid; */
		}
		.right-box{
			height: 120px;
			width : 49%;
			float : right;
/* 			border : 1px solid; */
		}
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.calendar-day{
			font-size : 14px !important;
			font-weight: bold !important;
		}
	
		.other-month-day{
			color : #b3b3b3 !important;	
		}
		
		.holiday{
			color : #ff4f4f !important;	
		}
		
		.sub-title {
/* 			border-bottom:2px solid #4679C2; */
			border-left:5px solid #4679C2;
			color:#4679C2;
			font-size:13px;
			font-weight:bold;
			margin-bottom:2px;
			padding:0 0 0 5px;
		}
		
		h2	{
			font-size: 20px;
			text-align: center;
		}
		
		.direction-icon:hover{
			color:#37434f;
			cursor:pointer;
		}
		
		.btn-vacation-main-ins {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			box-shadow:inset #fafafa 0px 5px 8px -1px;
			o-box-shadow:inset #fafafa 0px 5px 8px -1px;
			-moz-box-shadow:inset #fafafa 0px 5px 8px -1px;
			-webkit-box-shadow:inset #fafafa 0px 5px 8px -1px;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:3px;
			-webkit-border-radius:3px;
			border-radius:3px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:63px;
			height:0px;
			padding:13px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.btn-vacation-main-ins:active {
			position:relative;
			top:4px
		}
		
		
	</style>
	
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_vacation" >
					<div class="guest">
						<div class="guestTap">
							<ul>
								<c:choose>
									<c:when test="${mbrVo_Session.team_type eq '4'}">
										<li class="on" id="mainTab"><a href="#">나의 휴가</a></li>
										<li id="listTab"><a href="#">나의 휴가 신청 내역</a></li>
									</c:when>
									<c:otherwise>
										<li class="on" id="listTab"><a href="#">나의 휴가 신청 내역</a></li>
									</c:otherwise>
								</c:choose>
								
							</ul>
						</div>
						
						<c:if test="${mbrVo_Session.team_type eq '4'}">
							<div class="guestcnt8" style="display:block;" id="mainCnt">
							
								<div style="margin-bottom: 5px;">
						       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
						       		<b>${mbrVo_Session.team_name} ${mbrVo_Session.user_name}</b>
								</div>
								
								<div style="margin-top: 10px;">
									<div class="left-box tableStyle2" style="border-top:none !important;">
										<div class="sub-title">${year}년 휴가 정보</div>
										
										<c:choose>
											<c:when test="${mbrVo_Session.team_type eq '4'}">
												<table style="table-layout: fixed; height: 100%;">
													<tr height="20">
														<th>총 일수</th>
														<th>사용 일수</th>
														<th>잔여 일수</th>
													</tr>
													<tr>
														<td>${srchParam.vacationDayCnt} 일</td>
														<td>${srchParam.vacationUseCnt} 일</td>
														<td>${srchParam.vacationDayCnt - srchParam.vacationUseCnt} 일</td>
													</tr>
												</table>
											</c:when>
											<c:otherwise>
												<table style="table-layout: fixed; height: 100%;">
													<tr height="20">
														<th>당해년도 사용 일수</th>
													</tr>
													<tr>
														<td style="font-size: 15px;">
															<fmt:formatNumber value="${srchParam.vacationUseCnt}" pattern="##.#"/> 일
														</td>
													</tr>
												</table>										
											</c:otherwise>
										</c:choose>
										
										
										<br>
										<br>
									</div><!-- .left-box -->
									
									<div class="right-box tableStyle2" style="border-top:none !important;">
										<div>
											<div class="sub-title" style="float: left;">최근 휴가 내역</div>
											<div style="float: right;cursor:pointer;" id="btn_vacation_list">
												<span style="color:#4679C2;"><i class="fas fa-plus-square"></i></span> 더보기
											</div>
										</div>
										<table style="table-layout: fixed;height: 100%;">
											<colgroup>
												<col width="25">
												<col width="70">
												<col width="130">
												<col width="90">
												<col width="35">
												<col width="30">
											</colgroup>
											<tr height="20">
												<th>No.</th>
												<th>구분</th>
												<th>사유</th>
												<th>기간</th>
												<th>사용일수</th>
												<th>상태</th>
											</tr>
											
											<c:choose>
												<c:when test="${vacationList.size() != 0}">
													<c:forEach items="${vacationList}" var="item" varStatus="status">
														<c:if test="${status.count <= 3}">
															<tr>
																<td>${status.count}</td>
																<td class="td-overflow-none">${item.vacationKindValue}</td>
																<td class="td-overflow-none">${item.vacationComment}</td>
																<td class="td-overflow-none" style="letter-spacing: 0px;">${item.vacationStartDate} ~ ${item.vacationEndDate}</td>
																<td class="td-overflow-none">
																	<fmt:formatNumber value="${item.vacationUseCnt}" pattern="##.#"/> 일
																</td>
																<td>${item.vacationStateValue}</td>
															</tr>
														</c:if>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="6">
															휴가내역이 존재 하지 않습니다.
														</td>
													</tr>											
												</c:otherwise>
											</c:choose>
										</table>
									</div><!-- .right-box -->
									
									<br style="clear: both;"/> <br/><br/><br/>
									<form action="myVacationMain" id="myVacationMainFrm" name="myVacationMainFrm" method="get">
										<input type="hidden" id="year" name="year" value="${year}" />
										<input type="hidden" id="month" name="month" value="${month}" />
										<input type="hidden" id="tab" name="tab" value="${srchParam.tab}" />
									</form>
									
									<div class="tableStyle2">
										<table style="height: 100%;">
											<tr height="40">
	<!-- 										background-color:#69a9e0; -->
												<td colspan="7" style="font-size: 17px; background-color:#69a9e0;">
													<font color="white" style="padding-left: 96px;"> 
														<i class="fas fa-caret-left fa-lg direction-icon" onclick="fnNextDate('year','bef');"></i>
														&nbsp;<b style="font-size: 20px;">${year} 년</b>&nbsp;
														<i class="fas fa-caret-right fa-lg direction-icon" onclick="fnNextDate('year','aft');"></i>
														&nbsp;&nbsp;&nbsp;
														<i class="fas fa-caret-left fa-lg direction-icon" onclick="fnNextDate('month','bef');"></i>
														&nbsp;<b style="font-size: 20px;">${month} 월</b>&nbsp;
														<i class="fas fa-caret-right fa-lg direction-icon" onclick="fnNextDate('month','aft');"></i>
													</font>
													
													<span style="float: right;padding-right: 5px;">
														<a href='#noloc' class='btn-vacation-main-ins' onclick='fnVacationIns();'>휴가 신청</a>
													</span>
												</td> 
											</tr>
											<tr height="20">
												<th>일</th>
												<th>월</th>
												<th>화</th>
												<th>수</th>
												<th>목</th>
												<th>금</th>
												<th>토</th>
											</tr>
											<c:forEach items="${calendar}" var="calendar">
												<c:if test="${calendar.dayOfWeek == 1 }">
													<tr height="100">
												</c:if> 
												<c:set var="calendarDayStyle" value="" />
												<c:choose>
													<c:when test="${fn:substring(calendar.monthDay,0,2) != month}">
														<c:set var="calendarDayStyle" value="other-month-day" />		
													</c:when>
													<c:when test="${calendar.dayOfWeek == 1}">
														<c:set var="calendarDayStyle" value="holiday" />
													</c:when>
												</c:choose>
												<c:forEach items="${calendar.eventDay}"  var="eventDay">
													<c:if test="${eventDay.type == 'h' }">
														<c:set var="calendarDayStyle" value="holiday" />
													</c:if>
												</c:forEach>
													
												<td style="padding:0 0 0 0 !important;">
													<div class="calendar-day ${calendarDayStyle}" style="height: 20px; padding-left:4px; text-align: left;">
														${calendar.day}
	<%-- 													${fn:substring(calendar.monthDay,2,4)}	 --%>
													</div>
													<div style="height: 40px; padding-left:4px; text-align: left;">
														<c:forEach items="${calendar.eventDay}"  var="eventDay">
															<c:choose>
																<c:when test="${eventDay.type == 'h' }">
																	<font color="red" >${eventDay.name}</font>
																</c:when>
																<c:otherwise>
																	${eventDay.name}
																</c:otherwise>
															</c:choose>
															<br/>
														</c:forEach>
													</div>
													<!-- 
													#fcff5a 최종승인
													 -->
													
													<c:set var="vacationDayStyle"  value="" />
													<c:if test="${calendar.vacationDay eq 'Y'}">
														<c:set var="vacationDayStyle"  value="background-color: #bce0ff;" />
														
													</c:if>
													<div class="tooltip" style="height: 40px; ${vacationDayStyle}" title="${calendar.vacationTitle}">
	<%-- 													${calendar.vacationDay} --%>
													</div>
												</td>
												
												<c:if test="${calendar.dayOfWeek == 7 }">
													</tr>										
												</c:if> 
											</c:forEach>
										</table>
									</div>
								</div>
							</div><!-- //guestcnt4 -->							
						</c:if>

						
						<div class="guestcnt8" style="display:block;" id="listCnt">
							<c:import url="/myVacationList"></c:import>
						</div>

						<!-- 휴가 Action Modal  -->
						<c:import url="/vacationActionModal"></c:import>
						<!-- //휴가 Action Modal  -->	
						
						<script>
							$(document).ready(function(){
								$(".guestcnt4").hide();
								_initToolTip();
								_initButton();
								
								//페이지 초기화
								var tab = $("#tab").val();
								$("#"+tab+"Cnt").show();
								$("#"+tab+"Tab").click();
								
							});//ready
							
						    //버튼 이벤트
						    function _initButton() {
						        $("#btn_vacation_list").on("click", function () {
						        	$("#listTab").click();
						        });
						        
						        $(".vacation_kind").on("click", function () {
						        	var vacation_kind = $(this).val(); //30(예비군)이면 파일 첨부
									if (vacation_kind == 30){
										$("#tr_vacation_file").show();
									}else{
										$("#tr_vacation_file").hide();
									}      	
						        });
						        
						        $(".btn_file_del").on("click", function () {
						        	fnVacationAction('FD');
						        });
						        
						        
							}
							
							function _initToolTip(){
								$('.tooltip').tooltipsy({
								    offset: [0, 0],
								    show: function (e, $el) {
								        $el.css({
								            'left': parseInt($el[0].style.left.replace(/[a-z]/g, '')) - 50 + 'px',
								            'opacity': '0.0',
								            'display': 'block'
								        }).animate({
								            'left': parseInt($el[0].style.left.replace(/[a-z]/g, '')) + 50 + 'px',
								            'opacity': '1.0'
								        }, 300);
								    },
								    hide: function (e, $el) {
								        $el.slideUp(100);
								    },
								    css: {
								        'padding': '1px',
								        'max-width': '200px',
								        'color': '#303030',
								        'background-color': '#f5f5b5',
								        'border': '1px solid #deca7e',
								        '-moz-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
								        '-webkit-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
								        'box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
								        'text-shadow': 'none'
								    }
								});
							}
							
							function fnNextDate(gubun,direction){
								var year = $("#year").val();
								var month = $("#month").val();
								
								if (gubun == "month"){
									if (direction == "aft"){
										if (month == 12){
											month = 1;
											year++;
										}else{
											month++;
										}
									}else if(direction == "bef"){
										if (month == 1){
											month = 12;
											year--;
										}else{
											month--;
										}
									}
									
								}else if(gubun == "year"){
									if (direction == "aft"){
										year++;
									}else if(direction == "bef"){
										year--;
									}
								}
								
								$("#year").val(year);
								$("#month").val(month);			
								$("#tab").val("main");
								
								$("#myVacationMainFrm").submit();
							}		

						</script>
					</div>
				</div>	
			</div>		
		</div>
	</div>
	<!-- //contents -->
	<!-- footer -->
<%-- 	<c:import url="../top_main/top_main_footer.jsp"></c:import> --%>
	<!-- //footerssds -->	
</div>
<!-- //wrapper -->

</body>
</html>
