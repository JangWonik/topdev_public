<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>		
<script>
function doDownload(){	
	
	var selDateVal = $("#selDate").val();	
	
	$("#doExcelDown").val("1");
	$("#excelSelDate").val(selDateVal);
	
    var frm = document.getElementById("downFrm");
    frm.action = "./equipment_manage_stat_team";
    frm.submit();
}
</script>
<form id="downFrm" name="downFrm">
	<input type="hidden" id="doExcelDown" name="doExcelDown">
	<input type="hidden" id="excelSelDate" name="excelSelDate">	
</form>
<form id="searchForm" name="searchForm" method="post" action="equipment_manage_stat">
	<table>
		<tr>
			<td style="text-align:left;padding-bottom:5px;width:70%;">
				<img width="12" height="12" src="./resources/ls_img/dotte.gif" border="0"><b> 기준일자 : </b> 
				<input type="text" id="selDate" name="selDate" size="10" value="${selDate}" maxlength="10" class="calendar">
				<input type="hidden" id="viewType" name="viewType" value="teamView"/>
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick="javascript:fnSearch();">조회</a>
				&nbsp; &#8251; <font color="blue">장비누적 데이터는 2022년 5월 20일부터 확인이 가능합니다. (없는 경우 '-' 로 표시됨)</font>
			</td>		
			<td align="right">
				<img alt="Exceldownload" src="/resources/ls_img/ls_invoice/btn_excel.gif" onclick="javascript:doDownload();" style="cursor:pointer;">
			</td>
		</tr>
	</table>
</form>
	<div class= "tableStyle2" style="border-top: 10px;">							
		<table>									
			<tr>
				<th width="50px;" rowspan="2">구분</th>
				<th width="100px;" rowspan="2">센터명</th>
				<th width="100px;" rowspan="2">부서명</th>
				<th width="50px;" rowspan="2">팀원수</th>
				<th width="200px;" colspan="4">데스크탑</th>
				<th width="200px;" colspan="4">모니터</th>
				<th width="100px;" colspan="2">카메라</th>
				<th width="100px;" colspan="2">레이저 자</th>
				<th width="100px;" colspan="2">기타</th>
				<th width="8px;" rowspan="2"></th>
			</tr>
			<tr>
				<!-- 데스크 탑 -->
				<th>사용중</th>
				<th>전월대비<br/>증감</th>
				<th>미회수</th>
				<th>전월대비<br/>증감</th>
				
				<!-- 모니터 -->
				<th>사용중</th>
				<th>전월대비<br/>증감</th>
				<th>미회수</th>
				<th>전월대비<br/>증감</th>
				
				<!-- 카메라 -->
				<th>사용중</th>
				<th>전월대비<br/>증감</th>
				
				<!-- 레이저 자 -->
				<th>사용중</th>
				<th>전월대비<br/>증감</th>
				
				<!-- 기타 -->
				<th>사용중</th>
				<th>전월대비<br/>증감</th>				
			</tr>
		</table>		
	</div>
	<div class= "tableStyle2" style="border-top:0px;height: 750px; overflow-y: auto;">
		<table>	
				<colgroup>
					<col style="width:50px;"><!-- 구분 -->
					<col style="width:100px;"><!-- 센터명 -->
					<col style="width:100px;"><!-- 부서명 -->
					<col style="width:50px;"><!-- 팀원수 -->
					<col style="width:50px;"><!-- 데스크탑 -->
					<col style="width:50px;"><!-- 데스크탑 -->
					<col style="width:50px;"><!-- 데스크탑 -->
					<col style="width:50px;"><!-- 데스크탑 -->
					<col style="width:50px;"><!-- 모니터 -->
					<col style="width:50px;"><!-- 모니터 -->
					<col style="width:50px;"><!-- 모니터 -->
					<col style="width:50px;"><!-- 모니터 -->
					<col style="width:50px;"><!-- 카메라 -->
					<col style="width:50px;"><!-- 카메라 -->
					<col style="width:50px;"><!-- 레이저자 -->
					<col style="width:50px;"><!-- 레이저자-->
					<col style="width:50px;"><!-- 기타 -->
					<col style="width:50px;"><!-- 기타 -->									
				</colgroup>
				<tbody>
					<c:set var="group_id" value="0"></c:set>
					<c:forEach items="${teamList_0}" var="items_0" varStatus="status">												
						<tr <c:if test='${group_id != items_0.group_id}'> style="background: #F5ECCE;" </c:if>>
							<c:if test="${status.index == 0}">
								<td style="background:#eee;" rowspan="${teamList_0.size()}">본사사업부</td>								
							</c:if>							
							<td>
								<c:if test="${group_id != items_0.group_id}">
									${items_0.group_name}
									<c:set var="group_id" value="${items_0.group_id}"></c:set>
								</c:if>																
							</td>
							<td>${items_0.team_name}</td>
							<td>${items_0.member_cnt}</td>
							<td>${items_0.eq_1_2}</td>
							<td>							
								<c:choose>
									<c:when test="${empty items_0.eq_1_2_before}"> - </c:when>
									<c:otherwise>${items_0.eq_1_2 - items_0.eq_1_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_0.eq_1_1}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_0.eq_1_1_before}"> - </c:when>
									<c:otherwise>${items_0.eq_1_1 - items_0.eq_1_1_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_0.eq_2_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_0.eq_2_2_before}"> - </c:when>
									<c:otherwise>${items_0.eq_2_2 - items_0.eq_2_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_0.eq_2_1}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_0.eq_2_1_before}"> - </c:when>
									<c:otherwise>${items_0.eq_2_1 - items_0.eq_2_1_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_0.eq_4_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_0.eq_4_2_before}"> - </c:when>
									<c:otherwise>${items_0.eq_4_2 - items_0.eq_4_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_0.eq_5_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_0.eq_5_2_before}"> - </c:when>
									<c:otherwise>${items_0.eq_5_2 - items_0.eq_5_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_0.eq_9_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_0.eq_9_2_before}"> - </c:when>
									<c:otherwise>${items_0.eq_9_2 - items_0.eq_9_2_before}</c:otherwise>
								</c:choose>
							</td>	<!-- 전월대비증감 -->
						</tr>
						<c:set var="sum_member_0_cnt" value="${sum_member_0_cnt + items_0.member_cnt}"></c:set>
						<c:set var="sum_0_eq_1_2" value="${sum_0_eq_1_2+items_0.eq_1_2}"></c:set>
						<c:set var="sum_0_eq_1_1" value="${sum_0_eq_1_1+items_0.eq_1_1}"></c:set>
						<c:set var="sum_0_eq_2_2" value="${sum_0_eq_2_2+items_0.eq_2_2}"></c:set>
						<c:set var="sum_0_eq_2_1" value="${sum_0_eq_2_1+items_0.eq_2_1}"></c:set>
						<c:set var="sum_0_eq_4_2" value="${sum_0_eq_4_2+items_0.eq_4_2}"></c:set>
						<c:set var="sum_0_eq_5_2" value="${sum_0_eq_5_2+items_0.eq_5_2}"></c:set>						
						<c:set var="sum_0_eq_9_2" value="${sum_0_eq_9_2+items_0.eq_9_2}"></c:set>
						
						<c:set var="sum_0_eq_1_2_before" value="${sum_0_eq_1_2_before+items_0.eq_1_2_before}"></c:set>
						<c:set var="sum_0_eq_1_1_before" value="${sum_0_eq_1_1_before+items_0.eq_1_1_before}"></c:set>
						<c:set var="sum_0_eq_2_2_before" value="${sum_0_eq_2_2_before+items_0.eq_2_2_before}"></c:set>
						<c:set var="sum_0_eq_2_1_before" value="${sum_0_eq_2_1_before+items_0.eq_2_1_before}"></c:set>
						<c:set var="sum_0_eq_4_2_before" value="${sum_0_eq_4_2_before+items_0.eq_4_2_before}"></c:set>
						<c:set var="sum_0_eq_5_2_before" value="${sum_0_eq_5_2_before+items_0.eq_5_2_before}"></c:set>						
						<c:set var="sum_0_eq_9_2_before" value="${sum_0_eq_9_2_before+items_0.eq_9_2_before}"></c:set>
					</c:forEach>
					<tr>
						<th colspan="3" height="30px;">본사사업부 소계</th>
						<th>${sum_member_0_cnt}</th>
						<th>${sum_0_eq_1_2}</th>
						<th>${sum_0_eq_1_2 - sum_0_eq_1_2_before}</th>
						<th>${sum_0_eq_1_1}</th>
						<th>${sum_0_eq_1_1 - sum_0_eq_1_1_before}</th>
						<th>${sum_0_eq_2_2}</th>
						<th>${sum_0_eq_2_2 - sum_0_eq_2_2_before}</th>
						<th>${sum_0_eq_2_1}</th>
						<th>${sum_0_eq_2_1 - sum_0_eq_2_1_before}</th>
						<th>${sum_0_eq_4_2}</th>
						<th>${sum_0_eq_4_2 - sum_0_eq_4_2_before}</th>
						<th>${sum_0_eq_5_2}</th>
						<th>${sum_0_eq_5_2 - sum_0_eq_5_2_before}</th>
						<th>${sum_0_eq_9_2}</th>
						<th>${sum_0_eq_9_2 - sum_0_eq_9_2_before}</th>						
					</tr>					
					
					<c:forEach items="${teamList_1}" var="items_1" varStatus="status">
						<tr <c:if test='${group_id != items_1.group_id}'> style="background: #F5ECCE;" </c:if>>
							<c:if test="${status.index == 0}">
								<td style="background: #eee;" rowspan="${teamList_1.size()}">1종 사업부</td>								
							</c:if>							
							<td>
								<c:if test="${group_id != items_1.group_id}">
									${items_1.group_name}
									<c:set var="group_id" value="${items_1.group_id}"></c:set>
								</c:if>																
							</td>
							<td>${items_1.team_name}</td>
							<td>${items_1.member_cnt}</td>
							<td>${items_1.eq_1_2}</td>
							<td>							
								<c:choose>
									<c:when test="${empty items_1.eq_1_2_before}"> - </c:when>
									<c:otherwise>${items_1.eq_1_2 - items_1.eq_1_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_1.eq_1_1}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_1.eq_1_1_before}"> - </c:when>
									<c:otherwise>${items_1.eq_1_1 - items_1.eq_1_1_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_1.eq_2_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_1.eq_2_2_before}"> - </c:when>
									<c:otherwise>${items_1.eq_2_2 - items_1.eq_2_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_1.eq_2_1}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_1.eq_2_1_before}"> - </c:when>
									<c:otherwise>${items_1.eq_2_1 - items_1.eq_2_1_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_1.eq_4_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_1.eq_4_2_before}"> - </c:when>
									<c:otherwise>${items_1.eq_4_2 - items_1.eq_4_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_1.eq_5_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_1.eq_5_2_before}"> - </c:when>
									<c:otherwise>${items_1.eq_5_2 - items_1.eq_5_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_1.eq_9_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_1.eq_9_2_before}"> - </c:when>
									<c:otherwise>${items_1.eq_9_2 - items_1.eq_9_2_before}</c:otherwise>
								</c:choose>
							</td>	<!-- 전월대비증감 -->
						</tr>
						<c:set var="sum_member_1_cnt" value="${sum_member_1_cnt + items_1.member_cnt}"></c:set>
						<c:set var="sum_1_eq_1_2" value="${sum_1_eq_1_2+items_1.eq_1_2}"></c:set>
						<c:set var="sum_1_eq_1_1" value="${sum_1_eq_1_1+items_1.eq_1_1}"></c:set>
						<c:set var="sum_1_eq_2_2" value="${sum_1_eq_2_2+items_1.eq_2_2}"></c:set>
						<c:set var="sum_1_eq_2_1" value="${sum_1_eq_2_1+items_1.eq_2_1}"></c:set>
						<c:set var="sum_1_eq_4_2" value="${sum_1_eq_4_2+items_1.eq_4_2}"></c:set>
						<c:set var="sum_1_eq_5_2" value="${sum_1_eq_5_2+items_1.eq_5_2}"></c:set>						
						<c:set var="sum_1_eq_9_2" value="${sum_1_eq_9_2+items_1.eq_9_2}"></c:set>
						
						<c:set var="sum_1_eq_1_2_before" value="${sum_1_eq_1_2_before+items_1.eq_1_2_before}"></c:set>
						<c:set var="sum_1_eq_1_1_before" value="${sum_1_eq_1_1_before+items_1.eq_1_1_before}"></c:set>
						<c:set var="sum_1_eq_2_2_before" value="${sum_1_eq_2_2_before+items_1.eq_2_2_before}"></c:set>
						<c:set var="sum_1_eq_2_1_before" value="${sum_1_eq_2_1_before+items_1.eq_2_1_before}"></c:set>
						<c:set var="sum_1_eq_4_2_before" value="${sum_1_eq_4_2_before+items_1.eq_4_2_before}"></c:set>
						<c:set var="sum_1_eq_5_2_before" value="${sum_1_eq_5_2_before+items_1.eq_5_2_before}"></c:set>						
						<c:set var="sum_1_eq_9_2_before" value="${sum_1_eq_9_2_before+items_1.eq_9_2_before}"></c:set>
					</c:forEach>
					<tr>
						<th colspan="3" height="30px;">1종 사업부 소계</th>
						<th>${sum_member_1_cnt}</th>
						<th>${sum_1_eq_1_2}</th>
						<th>${sum_1_eq_1_2 - sum_1_eq_1_2_before}</th>
						<th>${sum_1_eq_1_1}</th>
						<th>${sum_1_eq_1_1 - sum_1_eq_1_1_before}</th>
						<th>${sum_1_eq_2_2}</th>
						<th>${sum_1_eq_2_2 - sum_1_eq_2_2_before}</th>
						<th>${sum_1_eq_2_1}</th>
						<th>${sum_1_eq_2_1 - sum_1_eq_2_1_before}</th>
						<th>${sum_1_eq_4_2}</th>
						<th>${sum_1_eq_4_2 - sum_1_eq_4_2_before}</th>
						<th>${sum_1_eq_5_2}</th>
						<th>${sum_1_eq_5_2 - sum_1_eq_5_2_before}</th>
						<th>${sum_1_eq_9_2}</th>
						<th>${sum_1_eq_9_2 - sum_1_eq_9_2_before}</th>						
					</tr>
					
					<c:forEach items="${teamList_4}" var="items_4" varStatus="status">
						<tr <c:if test='${group_id != items_4.group_id}'> style="background: #F5ECCE;" </c:if>>
							<c:if test="${status.index == 0}">
								<td style="background: #eee;" rowspan="${teamList_4.size()}">4종 사업부</td>								
							</c:if>							
							<td>
								<c:if test="${group_id != items_4.group_id}">
									${items_4.group_name}
									<c:set var="group_id" value="${items_4.group_id}"></c:set>
								</c:if>																
							</td>
							<td>${items_4.team_name}</td>
							<td>${items_4.member_cnt}</td>
							<td>${items_4.eq_1_2}</td>
							<td>							
								<c:choose>
									<c:when test="${empty items_4.eq_1_2_before}"> - </c:when>
									<c:otherwise>${items_4.eq_1_2 - items_4.eq_1_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_4.eq_1_1}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_4.eq_1_1_before}"> - </c:when>
									<c:otherwise>${items_4.eq_1_1 - items_4.eq_1_1_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_4.eq_2_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_4.eq_2_2_before}"> - </c:when>
									<c:otherwise>${items_4.eq_2_2 - items_4.eq_2_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_4.eq_2_1}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_4.eq_2_1_before}"> - </c:when>
									<c:otherwise>${items_4.eq_2_1 - items_4.eq_2_1_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_4.eq_4_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_4.eq_4_2_before}"> - </c:when>
									<c:otherwise>${items_4.eq_4_2 - items_4.eq_4_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_4.eq_5_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_4.eq_5_2_before}"> - </c:when>
									<c:otherwise>${items_4.eq_5_2 - items_4.eq_5_2_before}</c:otherwise>
								</c:choose>
							</td><!-- 전월대비증감 -->
							<td>${items_4.eq_9_2}</td>
							<td>
								<c:choose>
									<c:when test="${empty items_4.eq_9_2_before}"> - </c:when>
									<c:otherwise>${items_4.eq_9_2 - items_4.eq_9_2_before}</c:otherwise>
								</c:choose>
							</td>	<!-- 전월대비증감 -->
						</tr>
						<c:set var="sum_member_4_cnt" value="${sum_member_4_cnt + items_4.member_cnt}"></c:set>
						<c:set var="sum_4_eq_1_2" value="${sum_4_eq_1_2+items_4.eq_1_2}"></c:set>
						<c:set var="sum_4_eq_1_1" value="${sum_4_eq_1_1+items_4.eq_1_1}"></c:set>
						<c:set var="sum_4_eq_2_2" value="${sum_4_eq_2_2+items_4.eq_2_2}"></c:set>
						<c:set var="sum_4_eq_2_1" value="${sum_4_eq_2_1+items_4.eq_2_1}"></c:set>
						<c:set var="sum_4_eq_4_2" value="${sum_4_eq_4_2+items_4.eq_4_2}"></c:set>
						<c:set var="sum_4_eq_5_2" value="${sum_4_eq_5_2+items_4.eq_5_2}"></c:set>						
						<c:set var="sum_4_eq_9_2" value="${sum_4_eq_9_2+items_4.eq_9_2}"></c:set>
						
						<c:set var="sum_4_eq_1_2_before" value="${sum_4_eq_1_2_before+items_4.eq_1_2_before}"></c:set>
						<c:set var="sum_4_eq_1_1_before" value="${sum_4_eq_1_1_before+items_4.eq_1_1_before}"></c:set>
						<c:set var="sum_4_eq_2_2_before" value="${sum_4_eq_2_2_before+items_4.eq_2_2_before}"></c:set>
						<c:set var="sum_4_eq_2_1_before" value="${sum_4_eq_2_1_before+items_4.eq_2_1_before}"></c:set>
						<c:set var="sum_4_eq_4_2_before" value="${sum_4_eq_4_2_before+items_4.eq_4_2_before}"></c:set>
						<c:set var="sum_4_eq_5_2_before" value="${sum_4_eq_5_2_before+items_4.eq_5_2_before}"></c:set>						
						<c:set var="sum_4_eq_9_2_before" value="${sum_4_eq_9_2_before+items_4.eq_9_2_before}"></c:set>
					</c:forEach>
					<tr>
						<th colspan="3" height="30px;">4종 사업부 소계</th>
						<th>${sum_member_4_cnt}</th>
						<th>${sum_4_eq_1_2}</th>
						<th>${sum_4_eq_1_2 - sum_4_eq_1_2_before}</th>
						<th>${sum_4_eq_1_1}</th>
						<th>${sum_4_eq_1_1 - sum_4_eq_1_1_before}</th>
						<th>${sum_4_eq_2_2}</th>
						<th>${sum_4_eq_2_2 - sum_4_eq_2_2_before}</th>
						<th>${sum_4_eq_2_1}</th>
						<th>${sum_4_eq_2_1 - sum_4_eq_2_1_before}</th>
						<th>${sum_4_eq_4_2}</th>
						<th>${sum_4_eq_4_2 - sum_4_eq_4_2_before}</th>
						<th>${sum_4_eq_5_2}</th>
						<th>${sum_4_eq_5_2 - sum_4_eq_5_2_before}</th>
						<th>${sum_4_eq_9_2}</th>
						<th>${sum_4_eq_9_2 - sum_4_eq_9_2_before}</th>						
					</tr>
					<tr>
						<th colspan="3" height="30px;"><font color="blue">전체 소계</font></th>
						<th><font color="blue">${sum_member_0_cnt + sum_member_1_cnt + sum_member_4_cnt}</font></th>
						<th><font color="blue">${sum_0_eq_1_2 + sum_1_eq_1_2 + sum_4_eq_1_2}</font></th>
						<th><font color="blue">${sum_0_eq_1_2 + sum_1_eq_1_2 + sum_4_eq_1_2 - sum_0_eq_1_2_before - sum_1_eq_1_2_before - sum_4_eq_1_2_before}</font></th>
						<th><font color="blue">${sum_0_eq_1_1 + sum_1_eq_1_1 + sum_4_eq_1_1}</font></th>
						<th><font color="blue">${sum_0_eq_1_1 + sum_1_eq_1_1 + sum_4_eq_1_1 - sum_0_eq_1_1_before - sum_1_eq_1_1_before - sum_4_eq_1_1_before}</font></th>
						<th><font color="blue">${sum_0_eq_2_2 + sum_1_eq_2_2 + sum_4_eq_2_2}</font></th>
						<th><font color="blue">${sum_0_eq_2_2 + sum_1_eq_2_2 + sum_4_eq_2_2 - sum_0_eq_2_2_before - sum_1_eq_2_2_before - sum_4_eq_2_2_before}</font></th>
						<th><font color="blue">${sum_0_eq_2_1 + sum_1_eq_2_1 + sum_4_eq_2_1}</font></th>
						<th><font color="blue">${sum_0_eq_2_1 + sum_1_eq_2_1 + sum_4_eq_2_1 - sum_0_eq_2_1_before - sum_1_eq_2_1_before - sum_4_eq_2_1_before}</font></th>
						<th><font color="blue">${sum_0_eq_4_2 + sum_1_eq_4_2 + sum_4_eq_4_2}</font></th>
						<th><font color="blue">${sum_0_eq_4_2 + sum_1_eq_4_2 + sum_4_eq_4_2 - sum_0_eq_4_2_before - sum_1_eq_4_2_before - sum_4_eq_4_2_before}</font></th>
						<th><font color="blue">${sum_0_eq_5_2 + sum_1_eq_5_2 + sum_4_eq_5_2}</font></th>
						<th><font color="blue">${sum_0_eq_5_2 + sum_1_eq_5_2 + sum_4_eq_5_2 - sum_0_eq_5_2_before - sum_1_eq_5_2_before - sum_4_eq_5_2_before}</font></th>
						<th><font color="blue">${sum_0_eq_9_2 + sum_1_eq_9_2 + sum_4_eq_9_2}</font></th>
						<th><font color="blue">${sum_0_eq_9_2 + sum_1_eq_9_2 + sum_4_eq_9_2 - sum_0_eq_9_2_before - sum_1_eq_9_2_before - sum_4_eq_9_2_before}</font></th>
					</tr>
					<!-- 여기부터 확인 -->
					<%-- <tr>
						<th colspan="3" height="30px;"><font color="blue">전체 소계</font></th>
						<th><font color="blue">${sum_member_0_cnt + sum_member_1_cnt + sum_member_4_cnt}</font></th>
						<th><font color="blue">${sum_0_eq_1_2 + sum_1_eq_1_2 + sum_4_eq_1_2}</font></th>
						<th><font color="blue">0</font></th>
						<th><font color="blue">${sum_0_eq_1_1 + sum_1_eq_1_1 + sum_4_eq_1_1}</font></th>
						<th><font color="blue">0</font></th>
						<th><font color="blue">${sum_0_eq_2_2 + sum_1_eq_2_2 + sum_4_eq_2_2}</font></th>
						<th><font color="blue">0</font></th>
						<th><font color="blue">${sum_0_eq_2_1 + sum_1_eq_2_1 + sum_4_eq_2_1}</font></th>
						<th><font color="blue">0</font></th>
						<th><font color="blue">${sum_0_eq_4_2 + sum_1_eq_4_2 + sum_4_eq_4_2}</font></th>
						<th><font color="blue">0</font></th>
						<th><font color="blue">${sum_0_eq_5_2 + sum_1_eq_5_2 + sum_4_eq_5_2}</font></th>
						<th><font color="blue">0</font></th>
						<th><font color="blue">${sum_0_eq_9_2 + sum_1_eq_9_2 + sum_4_eq_9_2}</font></th>
						<th><font color="blue">0</font></th>
					</tr> --%>
				</tbody>
		</table>		
	</div>	