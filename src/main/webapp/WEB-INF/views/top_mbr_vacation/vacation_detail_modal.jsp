<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

	<style>
/* 		.left-box{ */
/* 			height: 120px; */
/* 			width : 49%; */
/* 			float : left; */
/* /* 			border : 1px solid; */ 
/* 		} */

		.right-box{
			height: 120px;
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
<!-- 						<div class="guestcnt4" style="display:none; height: 800px !important;" id="mainCnt"> -->
							<div style="margin-bottom: 5px;">
					       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
					       		<b>${vacationVo.teamNm} ${vacationVo.userNm} ${vacationVo.workLevelNm}</b>
							</div>
							
							<div style="margin-top: 10px;">
								<div class="right-box tableStyle2" style="border-top:none !important;">
									<input type="hidden" id="detailVacationNo" value="${vacationVo.vacationNo}"/>
									 
									<table style="table-layout: fixed;height: 80%;">
										<colgroup>
											<col width="55">
											<col width="70">
											<col width="155">
											<col width="50">
											<col width="50">
										</colgroup>
										<tr height="20">
											<th>구분</th>
											<th>기간</th>
											<th>사유</th>
											<th>사용일수</th>
											<th>상태</th>
										</tr>
										<tr>
											<td class="td-overflow-none">${vacationVo.vacationKindValue}</td>
											<td class="td-overflow-none" style="letter-spacing: 0px;">${vacationVo.vacationStartDate} ~ ${vacationVo.vacationEndDate}</td>
											<td>${vacationVo.vacationComment}</td>
											<td class="td-overflow-none">
												<fmt:formatNumber value="${vacationVo.vacationUseCnt}" pattern="##.#"/> 일
											</td>
											<td>${vacationVo.vacationStateValue}</td>
										</tr>
										<c:if test="${vacationVo.vacationKind eq '30'}">
											<tr>
												<td colspan="5">
													<c:choose>
														<c:when test="${vacationVo.vacationOrgFile ne null and vacationVo.vacationOrgFile ne ''}">
															<a href="/vacationFileDown?vacationNo=${vacationVo.vacationNo}" >
																<span id="file_name">${vacationVo.vacationOrgFile}</span>
															</a>
														</c:when>
														<c:otherwise>
															파일이 존재 하지 않습니다.													
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:if>
										<c:choose>
											<c:when test="${vacationVo.vacationState == 91 || vacationVo.vacationState == 92 }">
												<tr>
													<td colspan="5">
														반려사유 : ${vacationVo.returnComment} 
													</td>
												</tr>
											</c:when>
											
											<c:when test="${vacationVo.vacationState == 2}">
												<tr>
													<td colspan="5">
														<a href="#noloc" class="btn-vacation-aprv" id="btn-cancel-detail" style="background:#c25757;color:#ffffff !important;" >취소</a>												
													</td>
												</tr>											
											</c:when>
											
											<c:when test="${vacationVo.vacationState == 90}">
											</c:when>
											
											<c:otherwise>
												<tr>
													<td colspan="5">
														<a href="#noloc" class="btn-vacation-aprv" id="btn-aprv-detail" style="background:#5792c2;color:#ffffff !important;">승인</a>
														&nbsp;&nbsp;&nbsp;
														<a href="#noloc" class="btn-vacation-aprv" id="btn-return-detail" style="background:#c25757;color:#ffffff !important;" >반려</a>												
													</td>
												</tr>
											</c:otherwise>
										</c:choose>
										
									</table>
								</div><!-- .right-box -->
								
								<br style="clear: both;"/><br/>
								<div class="tableStyle2">
									<table>
										<tr height="40">
<!-- 										background-color:#69a9e0; -->
											<td colspan="7" style="font-size: 17px; background-color:#69a9e0;">
												<font color="white"> 
													&nbsp;<b style="font-size: 20px;">${year} 년</b>&nbsp;
													&nbsp;&nbsp;&nbsp;
													&nbsp;<b style="font-size: 20px;">${month} 월</b>&nbsp;
												</font>
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
						
						<script>
							$(document).ready(function(){
								_initButton();
								_initToolTip();	
							});//ready
							
						    //버튼 이벤트
						    function _initButton() {
								$("#btn-aprv-detail").on("click",function(){
									if (confirm("휴가를 승인하시겠습니까?")){
										fnVacationDetailAction("A");
									}
								});

								$("#btn-cancel-detail").on("click",function(){
									if (confirm("최종 승인을 취소하시겠습니까?\n※신청 상태로 변경됩니다.")){
										fnVacationDetailAction("C");
									}
								});
								
								$("#btn-return-detail").on("click",function(){
									$("#return-dialog").dialog({
										height: 180,
										width: 600,
										closeOnEscape : true,
										draggable : false,
										title: "반려하기",
										buttons:{
											"반려하기" : function(){
												fnVacationDetailAction("R");
												$(this).dialog("close");
											},
											"취소" : function(){
												$(this).dialog("close");
											}
										},
										modal: true,
										overlay:{ opacity: 0., background: '#000000'}
									});	
								});								
							}
							
							
							function fnVacationDetailAction(action){
								var url = "actionVacationAprv";
								var param = {};
								param.action = action;
								param.vacationNo = $("#detailVacationNo").val();
								param.returnComment = $("#return_comment").val();
								
							    $.ajax({
							        type: "POST",
							        url: url,
							        data: param,
							        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
							        timeout: 20000,
							        dataType: "JSON", 
							        success: function(data){
						        		alert(data.msg);
						        		if (data.result == "0000" ){//
							        		location.reload();
							        	}
						        		
						        		return;
							        },
							        error: function(e){
							            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
							        }
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
						</script>
