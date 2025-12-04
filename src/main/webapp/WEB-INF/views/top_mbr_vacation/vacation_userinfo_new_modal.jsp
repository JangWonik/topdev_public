<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.vacation-ins-table tr{
			height: 50px;
		}
		.vacation-ins-kind li {
			float:left;			
			width:100px;
			padding:0 10px; 	
			text-align: left;
		}
		.ui-button-text-only {
			height:2.1em !important;
		}
		
		.vacation-btn {
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

		.vacation-btn:active {
			position:relative;
			top:4px
		}
		
	</style>	
		<div id="vacation-detail-dialog" title="휴가 사용 정보" style="font-size: 12px;" align="center">
			<br/>
			<div style="float: left; height: 25px;" >
	       		&nbsp;&nbsp;<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
	       		<b>조회 대상자 : ${user_name} &nbsp;&nbsp;( 조회기간 : ${start_date} ~ ${end_date} )&nbsp;&nbsp;
	       		(해당년도 선연차 사용분은 <font color="blue">파란배경</font>으로, 해당 전년도 선연차 사용분은 <font color="#64CD3C">녹색배경</font>으로 표시됩니다)</b>	       		
			</div>
			<br/>
			<br/>
			<div class="tableStyle2" style="width: 950px;">
				<table class="vacation-ins-table">
						<tr>
							<th width="10%">종류</th>
							<th width="20%">사유</th>
							<th width="20%">기간</th>
							<th width="15%">사용일</th>
							<th width="15%">차감일</th>
							<th width="20%">상태</th>
						</tr>
							<c:forEach items="${vacationList}" var = "item">
								<c:choose>																		
									<c:when test="${vacationList.size() != 0 }">
										<tr <c:if test="${item.next_use eq 1}"> style='background-color:#E5EBFF;' </c:if> >
											<td>
												${item.vacation_type_val}
												<c:if test="${not empty item.vacation_option_val}">
													<br/>[${item.vacation_option_val}]
												</c:if>
											</td>
											<td>${item.vacation_content}</td>
											<td>${item.sdate} ~ ${item.edate}</td>
											<td>${item.vacation_interval} 일</td>
											<c:if test="${item.approval_state eq 31}">
												<c:set var="sum_vacation_use" value="${sum_vacation_use + item.vacation_interval}"/>
											</c:if>
											<td>
												<c:choose>
													<c:when test="${item.vacation_type eq 100 or item.vacation_type eq 200 or item.vacation_type eq 210}">
														${item.vacation_interval} 일														
														<c:if test="${item.approval_state eq 31}">
															<c:set var="sum_annual_use" value="${sum_annual_use + item.vacation_interval}"/>
														</c:if>
													</c:when>
														<c:otherwise>
															0 일
													</c:otherwise>
												</c:choose>
											</td>
											<td>${item.approval_state_val}</td>
											</tr>
										</c:when>										
									<c:otherwise>
										<tr>
											<td colspan="6">해당 기간에 사용 중인 휴가가 없습니다.</td>
										</tr>
									</c:otherwise>
							</c:choose>
						</c:forEach>
						<!-- 전해년도 선연차 목록 표시 시작 -->
						<c:forEach items="${beforeVacationList}" var = "itemBefore">
							<tr style='background-color:#64CD3C;' >
								<td>
									${itemBefore.vacation_type_val}
									<c:if test="${not empty itemBefore.vacation_option_val}">
										<br/>[${itemBefore.vacation_option_val}]
									</c:if>
								</td>
								<td>${itemBefore.vacation_content}</td>
								<td>${itemBefore.sdate} ~ ${itemBefore.edate}</td>
								<td>${itemBefore.vacation_interval} 일</td>
								<td>
									<c:choose>
										<c:when test="${itemBefore.vacation_type eq 100 or itemBefore.vacation_type eq 200 or itemBefore.vacation_type eq 210}">
											${itemBefore.vacation_interval} 일
										</c:when>
											<c:otherwise>
												0 일
										</c:otherwise>
									</c:choose>
								</td>
								<td>${itemBefore.approval_state_val}</td>
							</tr>							
						</c:forEach>							
						<!-- 전해년도 선연차 목록 표시 끝 -->						
						<!-- 합계값 시작 -->
						<tr>
							<th colspan="3">전년도 선연차 및 취소 제외,  합계</th>							
							<th><fmt:formatNumber value="${sum_vacation_use}" pattern="0.00"/></th>
							<th><fmt:formatNumber value="${sum_annual_use}" pattern="0.00"/></th>
							<th> - </th>							
						</tr>																																															
				</table>
			</div>
		</div>	