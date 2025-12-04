<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
	<c:choose>
		<c:when test="${salesMemberList.size() == 0}">
			<tr>
				<td colspan="13" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${salesMemberList}" varStatus="status">
			 	<tr <c:if test='${items.sales_flag eq 1}'>bgcolor="#D0F5A9"</c:if> >
			 		<td width="4%" align="center">${salesMemberList.size() - status.index}</td>
			 		<td width="11%" align="center">${items.team_name}</td>
			 		<td width="5%" align="center">${items.work_level_nm}</td>
			 		<td width="11%" align="center">${items.user_name}</td>
			 		<td width="10%" align="center">${items.salary_4_insu_nm}</td>
			 		<td width="8%" align="center">${items.salary_4_part_nm}</td>
			 		<td width="6%" align="center">${items.total_work_month_txt}</td>
			 		<td width="6%" align="center">${items.loss_rate}</td>
			 		<td width="6%" align="center">${items.minwon_cnt}</td>			 		
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.part_pay}" pattern="#,##0.##"/></td>
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.sum_etc_pay}" pattern="#,##0.##"/></td>
			 		<td width="9%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.sum_sales_pay}" pattern="#,##0.##"/></td>
			 		<td width="8%" align="center">
			 			<c:choose>
			 				<c:when test="${items.sales_flag eq 0}">
			 					<a class="btn-vacation-detail" id="btn-addSave" style="width: 58px;" onclick="javascript:doSalesMemberAdd('${items.user_no}','${items.salary_4_part}')" href="#noloc">실적등록</a>	
			 				</c:when>
			 				<c:otherwise>
			 					<a class="btn-vacation-detail" id="btn-modifySave" style="width: 58px;background:#F6CEE3;" onclick="javascript:doSalesMemberModify('${items.user_no}','${items.salary_4_part}','${items.skey}')" href="#noloc">실적수정</a>	
			 				</c:otherwise>
			 			</c:choose>		
			 		</td>			 		
			 	</tr>
			 	<c:set var="total_part_pay" value="${total_part_pay + items.part_pay}" />
			 	<c:set var="total_sum_etc_pay" value="${total_sum_etc_pay + items.sum_etc_pay}" />
			 	<c:set var="total_sum_sales_pay" value="${total_sum_sales_pay + items.sum_sales_pay}" />
			 </c:forEach>
		</c:otherwise>
	</c:choose>
</table>
<div style="height:5px;"></div>
<table>	
	<tr>
		<th width="15%">총 구간 성과급 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_part_pay}" pattern="#,##0.##"/></td>
		<th width="15%">총 시상비 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_sum_etc_pay}" pattern="#,##0.##"/></td>		
		<th width="20%">총 성과급 총 합계</th>
		<td width="20%" style="text-align:right;padding-right:10px;"><b><font color="blue"><fmt:formatNumber value="${total_sum_sales_pay}" pattern="#,##0.##"/></font></b></td>
	</tr>
</table>