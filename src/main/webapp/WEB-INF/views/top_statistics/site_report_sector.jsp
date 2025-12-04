<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table>
	<tr>
		<td>
			<div style="text-align:left;padding:0 0 5px 0;">	
				<a class="btn-graph" id="sectorGraph" href="#noloc" style="background:#D0F5A9;cursor:pointer;">부문별 기한내 제출율 그래프</a>	
			</div>
		</td>
		<td>
			<div style="text-align:right;padding:0 0 5px 0;">	
				<a href="#noloc" id="btn_excel" onclick="javascript:doDownExcel('Sector');">
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
            	<th rowspan="2">부문명</th>            	            	
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
    <form name="topSectorAllForm" id="topSectorAllForm" method="post" action="frontChartDetailModal" target="chartPop">
	    <input type="hidden" id="seViewType" name="viewType"/>
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
            <c:forEach var="se" items="${sectorSiteResult}" varStatus="status">
            <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
				<td>${se.sector_name}</td>            	            	
            	<td>${se.suim_cnt}</td>
            	<td>${se.sub_3_in_cnt}</td>
            	<td>${se.sub_3_over_cnt}</td>
            	<td>${se.not_3_in_cnt}</td>
            	<td>${se.not_3_over_cnt}</td>
            	<td><fmt:formatNumber value="${se.over_per}" pattern="##.#"/> %</td>
            	<td>${se.not_30_over_cnt}</td>
            	<td>${se.end_average_cnt}</td>
            	<c:set var="se_sum_suim_cnt" value="${se_sum_suim_cnt + se.suim_cnt}"/>
				<c:set var="se_sum_sub_3_in_cnt" value="${se_sum_sub_3_in_cnt + se.sub_3_in_cnt}"/>
				<c:set var="se_sum_sub_3_over_cnt" value="${se_sum_sub_3_over_cnt + se.sub_3_over_cnt}"/>
				<c:set var="se_sum_not_3_in_cnt" value="${se_sum_not_3_in_cnt + se.not_3_in_cnt}"/>
				<c:set var="se_sum_not_3_over_cnt" value="${se_sum_not_3_over_cnt + se.not_3_over_cnt}"/>						
				<c:set var="se_sum_not_30_over_cnt" value="${se_sum_not_30_over_cnt + se.not_30_over_cnt}"/>
				<c:set var="se_sum_end_average_cnt" value="${se_sum_end_average_cnt + se.end_average_cnt}"/>					
            </tr>
            <input type="hidden" name="all_name[]" value="['${se.sector_name}','(${se.over_per}%)']"/>
			<input type="hidden" name="all_over_per[]" value="${se.over_per}"/>
            </c:forEach>
            <tr>
				<th>합계</th>
				<th>${se_sum_suim_cnt}</th>
				<th>${se_sum_sub_3_in_cnt}</th>
				<th>${se_sum_sub_3_over_cnt}</th>
				<th>${se_sum_not_3_in_cnt}</th>
				<th>${se_sum_not_3_over_cnt}</th>
				<th>
					<c:choose>
						<c:when test="${se_sum_suim_cnt == 0}">0 %</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${(se_sum_sub_3_over_cnt + se_sum_not_3_over_cnt) / se_sum_suim_cnt * 100}" pattern="#,###"/> %
						</c:otherwise>
					</c:choose>							
				</th>
				<th>${se_sum_not_30_over_cnt}</th>
				<th>
					<fmt:formatNumber value="${se_sum_end_average_cnt / sectorSiteResult.size()}" pattern="#,###"/>
				</th>
			</tr>
            </tbody>
        </table>
    </div>
    <c:set var="sum_end_average_per" value="${se_sum_end_average_cnt / sectorSiteResult.size()}"/>		
	<input type="hidden" name="all_over_per_sum" value='<fmt:formatNumber value="${(se_sum_sub_3_over_cnt + se_sum_not_3_over_cnt) / se_sum_suim_cnt * 100}" pattern="#,###"/>'>
    </form>
</div>
