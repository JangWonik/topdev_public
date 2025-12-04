<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
	<c:choose>
		<c:when test="${resultMemberList.size() == 0}">
			<tr>
				<td colspan="13" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${resultMemberList}" varStatus="status">
			 	<tr <c:if test='${items.sales_flag eq 1}'>bgcolor="#D0F5A9"</c:if> >
			 		<td width="4%" align="center">${resultMemberList.size() - status.index}</td>
			 		<td width="11%" align="center">${items.team_name}</td>
			 		<td width="4%" align="center">${items.work_level_nm}</td>
			 		<td width="10%" align="center">${items.user_name}</td>
			 		<td width="4%" align="center">${items.loss_rate}</td>
			 		<td width="4%" align="center">${items.minwon_cnt}</td>
			 		<td width="5%" align="center">
			 			<c:choose>
			 				<c:when test="${items.incentive_type eq 1}"><font color="blue">종결건</font></c:when>
			 				<c:when test="${items.incentive_type eq 2}"><font color="green">매출액</font></c:when>
			 				<c:otherwise> - </c:otherwise>
			 			</c:choose>			 			
			 		</td>
			 		<td width="5%" align="center">
			 			<c:choose>
			 				<c:when test="${fn:length(items.cal_reason_text) > 3}">미달성</c:when>
			 				<c:otherwise>${items.cal_reason_text}</c:otherwise>
			 			</c:choose>			 			
			 		</td>
			 		<!-- (최소)기본 매출액 -->
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_sales_min}" pattern="#,##0.##"/></td>
			 		<!-- 직원 발생 매출액 -->
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.cal_result_sales}" pattern="#,##0.##"/></td>			 		
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.part_pay}" pattern="#,##0.##"/></td>
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.sum_etc_pay}" pattern="#,##0.##"/></td>
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.sum_sales_pay}" pattern="#,##0.##"/></td>
			 		<td width="12%" align="center">
			 			<a class="btn-vacation-detail" id="btn-detailView" style="width: 28px;background:#D0F5A9;" onclick="javascript:doSalesMemberDetail('${items.user_no}','${items.pkey}','${items.skey}')" href="#noloc">조회</a>&nbsp;			 			
			 			<a class="btn-vacation-detail" id="btn-modifySave" style="width: 56px;background:#F6CEE3;" onclick="javascript:doSalesMemberDelete('${items.user_no}','${items.user_name}','${items.skey}')" href="#noloc">실적삭제</a>
			 		</td>			 		
			 	</tr>
			 	<!-- 최소 기준 매출액 합계 -->
			 	<c:set var="total_base_sales_min" value="${total_base_sales_min + items.base_sales_min}" />
			 	<!-- 총 매출액 합계 -->
			 	<c:set var="total_cal_result_sales" value="${total_cal_result_sales + items.cal_result_sales}" />
			 	<!-- 구간성과급 합계 -->
			 	<c:set var="total_part_pay" value="${total_part_pay + items.part_pay}" />
			 	<!-- 시상비 합계 -->
			 	<c:set var="total_sum_etc_pay" value="${total_sum_etc_pay + items.sum_etc_pay}" />
			 	<!-- 성과급 합계 -->
			 	<c:set var="total_sum_sales_pay" value="${total_sum_sales_pay + items.sum_sales_pay}" />
			 </c:forEach>
		</c:otherwise>
	</c:choose>
</table>
<div style="height:5px;"></div>
<table>	
	<tr>
		<th width="10%">총 기준 매출액 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_base_sales_min}" pattern="#,##0.##"/></td>
		<th width="10%">총 직원 매출액 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><b><font color="green"><fmt:formatNumber value="${total_cal_result_sales}" pattern="#,##0.##"/></font></b></td>
		<th width="10%">총 구간 성과급 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_part_pay}" pattern="#,##0.##"/></td>
		<th width="10%">총 시상비 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_sum_etc_pay}" pattern="#,##0.##"/></td>		
		<th width="10%">총 성과급 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><b><font color="blue"><fmt:formatNumber value="${total_sum_sales_pay}" pattern="#,##0.##"/></font></b></td>
	</tr>
</table>