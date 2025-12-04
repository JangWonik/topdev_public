<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div style="text-align:right;padding:0 0 5px 0;">	
	<a href="#noloc" id="btn_excel" onclick="javascript:doDownExcel('Member');">
		<img src="./resources/ls_img/btn_excel.gif">
	</a>	
</div>
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
                <col width="100">
                <col width="80">
                <col width="160">
                <col width="50">              
            </colgroup>
            <thead>
            <tr>
            	<th rowspan="2">센터명</th>
            	<th rowspan="2">팀명</th>
            	<th rowspan="2">이름</th>
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
                <col width="100">
                <col width="80">                
                <col width="160">
                <col width="50">
            </colgroup>

            <tbody>
            <c:forEach var="vo" items="${memberSiteResult}" varStatus="status">
            <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
				<td><a href="javascript:openSiteMemberReport('${vo.user_no}','suimCnt','${vo.end_average_cnt}')">${vo.center_name}</a></td>
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','suimCnt','${vo.end_average_cnt}')">${vo.team_name}</a></td>            	
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','suimCnt','${vo.end_average_cnt}')">${vo.user_name}</a>
            		<!-- 그래프 추가 -->
               		<a href="javascript:openSiteChartBarDetail('M','${vo.center_name}','${vo.team_name}','${vo.user_name}','${vo.user_no}','${vo.suim_cnt}','${vo.sub_3_in_cnt}','${vo.sub_3_over_cnt}','${vo.not_3_in_cnt}','${vo.not_3_over_cnt}');">
           				<img src="./resources/chart/chart_icon.png"/>
           			</a>
            	</td>
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','suimCnt','${vo.end_average_cnt}')">${vo.suim_cnt}</a></td>
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','sub3In','${vo.end_average_cnt}')">${vo.sub_3_in_cnt}</a></td>
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','sub3Over','${vo.end_average_cnt}')">${vo.sub_3_over_cnt}</a></td>
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','not3In','${vo.end_average_cnt}')">${vo.not_3_in_cnt}</a></td>
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','not3Over','${vo.end_average_cnt}')">${vo.not_3_over_cnt}</a></td>
            	<td><fmt:formatNumber value="${vo.over_per}" pattern="##.#"/> %</td>
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','not30Over','${vo.end_average_cnt}')">${vo.not_30_over_cnt}</a></td>
            	<td><a href="javascript:openSiteMemberReport('${vo.user_no}','endAverage','${vo.end_average_cnt}')">${vo.end_average_cnt}</a></td>
            	<c:set var="sum_suim_cnt" value="${sum_suim_cnt + vo.suim_cnt}"/>
				<c:set var="sum_sub_3_in_cnt" value="${sum_sub_3_in_cnt + vo.sub_3_in_cnt}"/>
				<c:set var="sum_sub_3_over_cnt" value="${sum_sub_3_over_cnt + vo.sub_3_over_cnt}"/>
				<c:set var="sum_not_3_in_cnt" value="${sum_not_3_in_cnt + vo.not_3_in_cnt}"/>
				<c:set var="sum_not_3_over_cnt" value="${sum_not_3_over_cnt + vo.not_3_over_cnt}"/>						
				<c:set var="sum_not_30_over_cnt" value="${sum_not_30_over_cnt + vo.not_30_over_cnt}"/>
				<c:set var="sum_end_average_cnt" value="${sum_end_average_cnt + vo.end_average_cnt}"/>
            </tr>
            </c:forEach>
          	<tr>
				<th colspan="3">합계</th>
				<th>${sum_suim_cnt}</th>
				<th>${sum_sub_3_in_cnt}</th>
				<th>${sum_sub_3_over_cnt}</th>
				<th>${sum_not_3_in_cnt}</th>
				<th>${sum_not_3_over_cnt}</th>
				<th>
					<c:choose>
						<c:when test="${sum_suim_cnt == 0}">0 %</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${(sum_sub_3_over_cnt + sum_not_3_over_cnt) / sum_suim_cnt * 100}" pattern="#,###"/> %
						</c:otherwise>
					</c:choose>							
				</th>
				<th>${sum_not_30_over_cnt}</th>
				<th>
					<fmt:formatNumber value="${sum_end_average_cnt / memberSiteResult.size()}" pattern="#,###"/>
				</th>
			</tr>
            </tbody>
        </table>
    </div>
</div>
