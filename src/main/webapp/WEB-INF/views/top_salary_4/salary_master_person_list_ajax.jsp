<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<table>
	<c:choose>		
		<c:when test="${masterList.size() == 0}">
			<tr>
				<td colspan="17" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${masterList}" varStatus="status">
			 	<tr>
			 		<td width="4%" align="center">${masterList.size() - status.index}</td>
			 		<td width="10%" align="center">${items.team_name}</td>
			 		<td width="7%" align="center">${items.insu_name}</td>
			 		<td width="7%" align="center">${items.part_name}</td>
			 		<td width="7%" align="center">${items.user_name}</td>
			 		<td width="6%" align="center">${items.join_date_fmt}</td>
			 		<td width="6%" align="center">${items.total_work_month_txt}</td>
			 		<td width="4%" align="center">${items.loss_rate}</td>
			 		<td width="4%" align="center">${items.minwon_cnt}</td>
			 		<td width="6%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_sales}" pattern="#,##0.##"/></td>
			 		<td width="6%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.cal_result_sales}" pattern="#,##0.##"/></td>
			 		<td width="4%" align="center">
			 			<c:choose>
			 				<c:when test="${items.pay_flag eq 1}">
			 					<font color="green">연봉제</font>
			 				</c:when>
			 				<c:otherwise>
			 					<font color="blue">월급제</font>
			 				</c:otherwise>
			 			</c:choose>			 		
			 		</td>
			 		<td width="6%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_total_pay}" pattern="#,##0.##"/></td>
			 		<td width="4%" align="center">
			 			<c:choose>
			 				<c:when test="${items.incentive_type eq 1}">
			 					<font color="blue">종결건</font>
			 				</c:when>
			 				<c:when test="${items.incentive_type eq 2}">
			 					<font color="green">매출액</font>
			 				</c:when>
			 				<c:otherwise>
			 					<font color="red">미지정</font>
			 				</c:otherwise>
			 			</c:choose>			 		
			 		</td>
			 		<td width="6%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.sum_sales_pay}" pattern="#,##0.##"/></td>
			 		<td width="7%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_total_pay+items.sum_sales_pay}" pattern="#,##0.##"/></td>
			 		<td width="6%" align="center">
			 			<a class="btn-vacation-detail" id="btn-detailView" style="width: 62px;background:#D0F5A9;" onclick="javascript:doMasterMemberDetail(${items.user_no})" href="#noloc">상세보기</a>&nbsp;
			 		</td>
			 	</tr>
			 	<!-- 최소 기준 매출액 -->
			 	<c:set var="total_base_sales" value="${total_base_sales + items.base_sales}" />
			 	<!-- 직원 매출액 합계 -->
			 	<c:set var="total_cal_result_sales" value="${total_cal_result_sales + items.cal_result_sales}" />
			 	<!-- 기본급 합계-->
			 	<c:set var="total_base_total_pay" value="${total_base_total_pay + items.base_total_pay}" />
			 	<!-- 성과급 합계 -->
			 	<c:set var="total_sum_sales_pay" value="${total_sum_sales_pay + items.sum_sales_pay}" />
			 	<!-- 급여 합계 -->
			 	<c:set var="total_salary_all" value="${total_salary_all + items.base_total_pay+items.sum_sales_pay}" />
			 </c:forEach>			
		</c:otherwise>
	</c:choose>
</table>
<div style="height:5px;"></div>
<table>	
	<tr>
		<th width="10%">총 기준 매출액 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_base_sales}" pattern="#,##0.##"/></td>
		<th width="10%">총 직원 매출액 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_cal_result_sales}" pattern="#,##0.##"/></td>
		<th width="10%">총 기본급  합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><b><font color="green"><fmt:formatNumber value="${total_base_total_pay}" pattern="#,##0.##"/></font></b></td>
		<th width="10%">총 성과급 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><b><font color="blue"><fmt:formatNumber value="${total_sum_sales_pay}" pattern="#,##0.##"/></font></b></td>				
		<th width="10%">총 급여 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><b><font color="red"><fmt:formatNumber value="${total_salary_all}" pattern="#,##0.##"/></font></b></td>
	</tr>
</table>
