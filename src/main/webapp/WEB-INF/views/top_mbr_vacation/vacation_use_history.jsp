<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<style>
.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}
</style>
<script>
$(document).ready(function(){	
	$("#srchTeamId").select2();
	$("#srchYear").select2();	
	$("#top_loading").hide();	
});

function viewInfo( user_no, syear, smonth ){	
	var sDate = syear+"-"+smonth;
		
	var url = "myVacationModalDetail";	
	var param = new FormData();
	param.append("user_no",user_no);
	param.append("vacation_date",sDate);
	
	$.ajax({
		type: "POST",
		url: url,
		data: param,
		timeout: 20000,
		processData: false,
		contentType: false,		        
		dataType: "html", 
		success: function(data){			
			$("#my_vacation_modal_detail").html(data);			
			showDialog();
		},
		error: function(e){
		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		}
	});	
}

function showDialog(){
	$("#vacation-detail-dialog").dialog({
		height: 500,
		width: 700,
		closeOnEscape : true,
		draggable : true,					
		title: "휴가 사용일 상세조회",
		buttons:{						
			"닫기" : function(){
				$(this).dialog("close");
			}
		},
		modal: true,
		overlay:{ opacity: 0., background: '#000000'}
	});
}

</script>	
</head>
<body>
<br/>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="yearVar"/>
<form id="historyFrm" name="historyFrm">
<input type="hidden" id="searchActionVal" name="searchActionVal"/>
<div class= "tableStyle2" style="border-top: 0px;overflow:scroll;height:800px;">										
	<div id="search-box"  align="center">
		<table style="width: 100%;" align="left">
			<c:choose>
				<c:when test="${teamList eq null}">
					<tr>
						<th>년도</th>						
						<td>
							<!-- 현재부터 2018년까지로 변경 by top3009-->									 
							<select id="srchYear" name="srchYear" style="width: 156px;">																			
								<c:forEach begin="0" end="${yearVar-2018}" var="result" step="1">
									<option value="${yearVar - result}" <c:if test="${srchYear == (yearVar-result) }">selected="selected"</c:if>>${yearVar-result} 년</option>							
								</c:forEach>
							</select>
							<!-- 현재부터 2018년까지로 변경 끝 by top3009-->											
						</td>				
						<td>							
							<a href="#noloc" class="btn-vacation-aprv" id="btn-history-search" onclick="doUselistSearch();">검색</a>
						</td>
						<td width="50%" colspan="2">
						</td>
					</tr>
				</c:when>
				<c:otherwise>				
					<tr>
						<th>부서명</th>
						<td>
							<span style="text-align: left !important;">
								<select id="srchTeamId" name="srchTeamId" style="width: 156px;">
									<option value="0">- 전체 -</option>
									<c:forEach items="${teamList}" var="teamVo">
										<c:choose>
											<c:when test="${srchParam.srchTeamId == teamVo.team_id}">
												<option value="${teamVo.team_id}" selected="selected">
											</c:when>
											<c:otherwise>
												<option value="${teamVo.team_id}">
											</c:otherwise>
										</c:choose>																
											<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
											<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
											${teamVo.team_name}																
									</c:forEach>
								</select>
							</span>
						</td>
						<th>조회년도</th>
						<td>
							<!-- 현재부터 2018년까지로 변경 by top3009-->		 
							<select id="srchYear" name="srchYear" style="width: 156px;">																			
								<c:forEach begin="0" end="${yearVar-2018}" var="result" step="1">
									<option value="${yearVar - result}" <c:if test="${srchYear == (yearVar-result) }">selected="selected"</c:if>>${yearVar-result} 년</option>							
								</c:forEach>
							</select>
							<!-- 현재부터 2018년까지로 변경 끝 by top3009-->									
						</td>
						<th>이름</th>
						<td>
							<input hidden="hidden"/>
							<input type="text" id="srchName" name="srchName" value="${srchName}" style="width: 156px;" />							
						</td>				
						<td>							
							<a href="#noloc" class="btn-vacation-aprv" id="btn-history-search" style="width:100px;" onclick="doUselistSearch();">검 색</a>
						</td>
					</tr>				
				</c:otherwise>
			</c:choose>
		</table>
		<br/>		
	</div>
	<div style="float: left; height: 25px;padding-top:10px;" >
      		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
      		<b><span id="checkpoint">
      			월별 휴가 사용량      			 	
      		</span></b>
	</div>	
		<table>			
				<tr>
					<th rowspan="2" width="7%">센터명</th>
					<th rowspan="2" width="10%">부서명</th>
					<th rowspan="2" width="7%">이름</th>
					<th rowspan="2" width="3%">직급</th>
					<th rowspan="2" width="6%">입사일</th>
					<th rowspan="2" width="6%">사용시기<br/>(부여일)</th>
					<th rowspan="2" width="6%">사용<br/>종기</th>
					<!-- <th rowspan="2" width="6%">현재<br/>사용율</th>
					<th rowspan="2" width="4%">발생<br/>일수</th>
					<th rowspan="2" width="4%">사용<br/>일수</th>
					<th rowspan="2" width="4%">잔여<br/>일수</th> -->
					<th rowspan="2" width="3%">연간<br/>합계</th>
					<th colspan="12" width="33%">${srchYear}년</th>
				</tr>
				<tr>
					<th>1</th>
					<th>2</th>
					<th>3</th>
					<th>4</th>
					<th>5</th>
					<th>6</th>
					<th>7</th>
					<th>8</th>
					<th>9</th>
					<th>10</th>
					<th>11</th>
					<th>12</th>
				</tr>
				<c:choose>
				<c:when test="${userInfoList.size() != 0}">
					<c:forEach items="${userInfoList}" var="item" varStatus="status">
						<tr>
							<td>${item.center_name}</td>
							<td>${item.team_name}</td>
							<td>${item.user_name}</td>
							<td>${item.work_level}</td>
							<td>${item.join_date}</td>
							<td>${item.now_join_date}</td>
							<td>${item.after_join_date}</td>
							<td>
							<c:set var="sumVacationUse" value="${item.col_1+item.col_2+item.col_3+item.col_4+item.col_5+item.col_6+item.col_7+item.col_8+item.col_9+item.col_10+item.col_11+item.col_12}"></c:set>							
							<font style="font-weight:bold;color:blue;"><fmt:formatNumber value="${sumVacationUse}" pattern="0.00"/></font></td>
							<%-- <td><fmt:formatNumber value="${item.nVacationProgress}" pattern="##.#"/> %</td> --%>
							<%-- <td><fmt:formatNumber value="${item.nVacationPer100}" pattern="##.#"/> %</td>							
							<td><font style="font-weight:bold;">${item.annual_set}</font></td>
							<td><font style="font-weight:bold;color:red;">${item.annual_use}</font></td>
							<td><font style="font-weight:bold;color:blue">${item.annual_set - item.annual_use}</font></td> --%>
														
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','01');return false;">
								<c:choose>									
									<c:when test="${item.col_1 eq 0.0}">
										${item.col_1}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_1}
										</font>										
									</c:otherwise>									
								</c:choose>
								</a>							
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','02');return false;">
								<c:choose>									
									<c:when test="${item.col_2 eq 0.0}">
										${item.col_2}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_2}
										</font>										
									</c:otherwise>									
								</c:choose>
								</a>
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','03');return false;">
								<c:choose>									
									<c:when test="${item.col_3 eq 0.0}">
										${item.col_3}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_3}
										</font>										
									</c:otherwise>									
								</c:choose>
								</a>								
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','04');return false;">
								<c:choose>
									<c:when test="${item.col_4 eq 0.0}">
										${item.col_4}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_4}
										</font>										
									</c:otherwise>
								</c:choose>
								</a>
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','05');return false;">
								<c:choose>
									<c:when test="${item.col_5 eq 0.0}">
										${item.col_5}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_5}
										</font>										
									</c:otherwise>
								</c:choose>
								</a>
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','06');return false;">
								<c:choose>
									<c:when test="${item.col_6 eq 0.0}">
										${item.col_6}
									</c:when>
									<c:otherwise>																				
										<font style="font-weight:bold;color:green">										
										${item.col_6}										
										</font>										
									</c:otherwise>
								</c:choose>
								</a>
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','07');return false;">
								<c:choose>
									<c:when test="${item.col_7 eq 0.0}">
										${item.col_7}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_7}
										</font>										
									</c:otherwise>
								</c:choose>
								</a>
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','08');return false;">
								<c:choose>
									<c:when test="${item.col_8 eq 0.0}">
										${item.col_8}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_8}
										</font>										
									</c:otherwise>
								</c:choose>
								</a>
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','09');return false;">
								<c:choose>
									<c:when test="${item.col_9 eq 0.0}">
										${item.col_9}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_9}
										</font>										
									</c:otherwise>
								</c:choose>
								</a>
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','10');return false;">
								<c:choose>
									<c:when test="${item.col_10 eq 0.0}">
										${item.col_10}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_10}
										</font>										
									</c:otherwise>									
								</c:choose>
								</a>
							</td>
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','11');return false;">
								<c:choose>
									<c:when test="${item.col_11 eq 0.0}">
										${item.col_11}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_11}
										</font>										
									</c:otherwise>
								</c:choose>
								</a>
							</td>							
							<td>
								<a href="#" onclick="viewInfo('${item.user_no}','${srchYear}','12');return false;">
								<c:choose>
									<c:when test="${item.col_12 eq 0.0}">
										${item.col_12}
									</c:when>
									<c:otherwise>										
										<font style="font-weight:bold;color:green">
										${item.col_12}
										</font>										
									</c:otherwise>
								</c:choose>
								</a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="20">조회 된 정보가 없습니다.</td>
					</tr>
				</c:otherwise>	
				</c:choose>				
			</tbody>
		</table>
	</div>
</form>	
<div id="my_vacation_modal_detail"></div>		
<!-- footer -->
<c:import url="../top_main/top_main_footer.jsp"></c:import>
<!-- //footer -->
</body>
</html>