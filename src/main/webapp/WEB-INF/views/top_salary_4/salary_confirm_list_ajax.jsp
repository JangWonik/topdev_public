<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${confirmList.size() == 0}">
			<tr>
				<td colspan="13" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${confirmList}" varStatus="status">			 	
			 	<tr>			 	
			 		<td width="4%" align="center">${confirmList.size() - status.index}</td>			 		
			 		<td width="11%" align="center">${items.team_name}</td>
			 		<td width="5%" align="center">${items.work_level_nm}</td>
			 		<td width="11%" align="center">${items.user_name}</td>			 		
			 		<td width="7%" align="center">${items.join_date_fmt}</td>			 		
			 		<td width="6%" align="center">
			 			<c:choose>
			 				<c:when test='${items.pay_flag eq 0}'><font color="blue">월급제</font></c:when>
			 				<c:otherwise><font color="green">연봉제</font></c:otherwise>
			 			</c:choose>			 						 			
			 		</td>
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.career_pay}" pattern="#,##0.##"/></td>
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.work_pay}" pattern="#,##0.##"/></td>
			 		<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.manager_pay}" pattern="#,##0.##"/></td>
			 		<td width="9%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_total_pay}" pattern="#,##0.##"/></td>
			 		<td width="7%" align="center">${items.reg_date_fmt}</td>
			 		<td width="8%" align="center">${items.reg_user_name}</td>
			 		<td width="8%" align="center">
			 			<a class="btn-vacation-detail" id="btn-detail" style="background:#F6CEE3;width: 58px;" onclick="javascript:doBaseConfirmCancel(${items.bkey},'${items.user_name}','${items.sales_date_fmt}')" href="#noloc">확정취소</a>			 			
			 		</td>
			 	</tr>
			 	<c:set var="confirm_sum_career_pay" value="${confirm_sum_career_pay + items.career_pay}" />
			 	<c:set var="confirm_sum_work_pay" value="${confirm_sum_work_pay + items.work_pay}" />
			 	<c:set var="confirm_sum_manager_pay" value="${confirm_sum_manager_pay + items.manager_pay}" />
			 	<c:set var="confirm_sum_base_total_pay" value="${confirm_sum_base_total_pay + items.base_total_pay}" />
			 </c:forEach>			
		</c:otherwise>
	</c:choose>	
</table>
<div style="height:5px;"></div>
<table>	
	<tr>
		<th width="10%">기본급 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${confirm_sum_career_pay}" pattern="#,##0.##"/></td>
		<th width="10%">근속수당 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${confirm_sum_work_pay}" pattern="#,##0.##"/></td>
		<th width="10%">팀장수당 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${confirm_sum_manager_pay}" pattern="#,##0.##"/></td>
		<th width="10%">총 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><b><font color="blue"><fmt:formatNumber value="${confirm_sum_base_total_pay}" pattern="#,##0.##"/></font></b></td>
	</tr>
</table>