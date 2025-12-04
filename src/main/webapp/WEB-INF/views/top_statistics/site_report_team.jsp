<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table>
	<tr>
		<td>
			<div style="text-align:left;padding:0 0 5px 0;">	
				<!-- 기능 개발은 되어있으나 막아놓음 20210525 -->
				<a class="btn-graph" id="teamGraph" href="#noloc" style="background:#A9E2F3;cursor:pointer;">팀별 기한내 제출율 그래프</a>	
			</div>
		</td>
		<td>
			<div style="text-align:right;padding:0 0 5px 0;">	
				<a href="#noloc" id="btn_excel" onclick="javascript:doDownExcel('Team');">
					<img src="./resources/ls_img/btn_excel.gif">
				</a>	
			</div>
		</td>
	</tr>
</table>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="100">
                <col width="100">
                <col width="70">
                <col width="100">                
                <col width="100">
                <col width="100">
                <col width="100">
                <col width="80">
                <col width="160">
                <col width="50">              
            </colgroup>
            <thead>
            <tr>
            	<th rowspan="2">센터명</th>
            	<th rowspan="2">팀명</th>            	
            	<th rowspan="2">수임</th>
            	<th colspan="2">제출</th>
            	<th colspan="2">미제출</th>
            	<th rowspan="2">기한내 제출율</th>
            	<th rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>
            	<th rowspan="2">평균처리일</th>            	
            </tr>
            <tr>
            	<th>3영업일이내</th>
            	<th>3영업일초과</th>
            	<th>3영업일이내</th>
            	<th>3영업일초과</th>
            </tr>            
            </thead>
        </table>
    </div>
    <form name="topTeamAllForm" id="topTeamAllForm" method="post" action="frontChartDetailModal" target="chartPop">
    <input type="hidden" id="tmViewType" name="viewType"/>
    <div style="height:654px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="100">
                <col width="100">
                <col width="70">
                <col width="100">                
                <col width="100">
                <col width="100">
                <col width="100">
                <col width="80">
                <col width="160">
                <col width="50">
            </colgroup>

            <tbody>
            <c:forEach var="tm" items="${teamSiteResult}" varStatus="status">            
            <tr onclick="javascript:openSiteReportTeam(${tm.team_id});" style="cursor:pointer;bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
				<td>${tm.center_name}</td>
            	<td>${tm.team_name}</td>            	
            	<td>${tm.suim_cnt}</td>
            	<td>${tm.sub_3_in_cnt}</td>
            	<td>${tm.sub_3_over_cnt}</td>
            	<td>${tm.not_3_in_cnt}</td>
            	<td>${tm.not_3_over_cnt}</td>
            	<td><fmt:formatNumber value="${tm.over_per}" pattern="##.#"/> %</td>
            	<td>${tm.not_30_over_cnt}</td>
            	<td>${tm.end_average_cnt}</td>
            	<c:set var="tm_sum_suim_cnt" value="${tm_sum_suim_cnt + tm.suim_cnt}"/>
				<c:set var="tm_sum_sub_3_in_cnt" value="${tm_sum_sub_3_in_cnt + tm.sub_3_in_cnt}"/>
				<c:set var="tm_sum_sub_3_over_cnt" value="${tm_sum_sub_3_over_cnt + tm.sub_3_over_cnt}"/>
				<c:set var="tm_sum_not_3_in_cnt" value="${tm_sum_not_3_in_cnt + tm.not_3_in_cnt}"/>
				<c:set var="tm_sum_not_3_over_cnt" value="${tm_sum_not_3_over_cnt + tm.not_3_over_cnt}"/>						
				<c:set var="tm_sum_not_30_over_cnt" value="${tm_sum_not_30_over_cnt + tm.not_30_over_cnt}"/>
				<c:set var="tm_sum_end_average_cnt" value="${tm_sum_end_average_cnt + tm.end_average_cnt}"/>					
            </tr>
            	<input type="hidden" name="all_name[]" value="${tm.team_name}"/>
				<input type="hidden" name="all_over_per[]" value="${tm.over_per}"/>
            </c:forEach>
            <tr>
				<th colspan="2">합계</th>
				<th>${tm_sum_suim_cnt}</th>
				<th>${tm_sum_sub_3_in_cnt}</th>
				<th>${tm_sum_sub_3_over_cnt}</th>
				<th>${tm_sum_not_3_in_cnt}</th>
				<th>${tm_sum_not_3_over_cnt}</th>
				<th>
					<c:choose>
						<c:when test="${tm_sum_suim_cnt == 0}">0 %</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${(tm_sum_sub_3_over_cnt + tm_sum_not_3_over_cnt) / tm_sum_suim_cnt * 100}" pattern="#,###"/> %
						</c:otherwise>
					</c:choose>							
				</th>
				<th>${tm_sum_not_30_over_cnt}</th>
				<th>
					<fmt:formatNumber value="${tm_sum_end_average_cnt / teamSiteResult.size()}" pattern="#,###"/>
				</th>
			</tr>
            </tbody>
        </table>
    </div>
		<c:set var="sum_end_average_per" value="${tm_sum_end_average_cnt / teamSiteResult.size()}"/>		
		<input type="hidden" name="all_over_per_sum" value='<fmt:formatNumber value="${(tm_sum_sub_3_over_cnt + tm_sum_not_3_over_cnt) / tm_sum_suim_cnt * 100}" pattern="#,###"/>'>
    </form>
</div>
