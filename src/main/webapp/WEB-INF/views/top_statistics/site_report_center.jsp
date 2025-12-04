<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table>
	<tr>
		<td>
			<div style="text-align:left;padding:0 0 5px 0;">	
				<a class="btn-graph" id="centerGraph" href="#noloc" style="background:#F5DA81;cursor:pointer;">센터별 기한내 제출율 그래프</a>	
			</div>
		</td>
		<td>
			<div style="text-align:right;padding:0 0 5px 0;">	
				<a href="#noloc" id="btn_excel" onclick="javascript:doDownExcel('Center');">
					<img src="./resources/ls_img/btn_excel.gif">
				</a>	
			</div>
		</td>
	</tr>
</table>
<div class="tableStyle2">
    <div style="background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="100">                
                <col width="100">
                <col width="70">                
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
    <form name="topCenterAllForm" id="topCenterAllForm" method="post" action="frontChartDetailModal" target="chartPop">
    <input type="hidden" id="ctViewType" name="viewType"/>
    <div style="height:654px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="100">
                <col width="100">
                <col width="70">                
                <col width="100">
                <col width="100">
                <col width="100">
                <col width="80">
                <col width="160">
                <col width="50">
            </colgroup>

            <tbody>
            <c:forEach var="ct" items="${centerSiteResult}" varStatus="status">
            <tr onclick="javascript:openSiteReportCenter(${ct.team_center});" style="cursor:pointer;bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
				<td>${ct.center_name}</td>            	            	
            	<td>${ct.suim_cnt}</td>
            	<td>${ct.sub_3_in_cnt}</td>
            	<td>${ct.sub_3_over_cnt}</td>
            	<td>${ct.not_3_in_cnt}</td>
            	<td>${ct.not_3_over_cnt}</td>
            	<td><fmt:formatNumber value="${ct.over_per}" pattern="##.#"/> %</td>
            	<td>${ct.not_30_over_cnt}</td>
            	<td>${ct.end_average_cnt}</td>
            	<c:set var="ct_sum_suim_cnt" value="${ct_sum_suim_cnt + ct.suim_cnt}"/>
				<c:set var="ct_sum_sub_3_in_cnt" value="${ct_sum_sub_3_in_cnt + ct.sub_3_in_cnt}"/>
				<c:set var="ct_sum_sub_3_over_cnt" value="${ct_sum_sub_3_over_cnt + ct.sub_3_over_cnt}"/>
				<c:set var="ct_sum_not_3_in_cnt" value="${ct_sum_not_3_in_cnt + ct.not_3_in_cnt}"/>
				<c:set var="ct_sum_not_3_over_cnt" value="${ct_sum_not_3_over_cnt + ct.not_3_over_cnt}"/>						
				<c:set var="ct_sum_not_30_over_cnt" value="${ct_sum_not_30_over_cnt + ct.not_30_over_cnt}"/>
				<c:set var="ct_sum_end_average_cnt" value="${ct_sum_end_average_cnt + ct.end_average_cnt}"/>					
            </tr>
	            <input type="hidden" name="all_name[]" value="['${ct.center_name}','(${ct.over_per}%)']"/>
				<input type="hidden" name="all_over_per[]" value="${ct.over_per}"/>
            </c:forEach>
            <tr>
				<th>합계</th>
				<th>${ct_sum_suim_cnt}</th>
				<th>${ct_sum_sub_3_in_cnt}</th>
				<th>${ct_sum_sub_3_over_cnt}</th>
				<th>${ct_sum_not_3_in_cnt}</th>
				<th>${ct_sum_not_3_over_cnt}</th>
				<th>
					<c:choose>
						<c:when test="${ct_sum_suim_cnt == 0}">0 %</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${(ct_sum_sub_3_over_cnt + ct_sum_not_3_over_cnt) / ct_sum_suim_cnt * 100}" pattern="#,###"/> %
						</c:otherwise>
					</c:choose>							
				</th>
				<th>${ct_sum_not_30_over_cnt}</th>
				<th>
					<fmt:formatNumber value="${ct_sum_end_average_cnt / centerSiteResult.size()}" pattern="#,###"/>
				</th>
			</tr>            
            </tbody>
        </table>
    </div>
    	<c:set var="sum_end_average_per" value="${ct_sum_end_average_cnt / centerSiteResult.size()}"/>		
		<input type="hidden" name="all_over_per_sum" value='<fmt:formatNumber value="${(ct_sum_sub_3_over_cnt + ct_sum_not_3_over_cnt) / ct_sum_suim_cnt * 100}" pattern="#,###"/>'>
    </form>
</div>
