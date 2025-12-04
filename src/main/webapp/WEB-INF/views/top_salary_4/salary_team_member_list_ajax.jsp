<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${memberList.size() == 0}">
			<tr>
				<td colspan="9" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${memberList}" varStatus="status">			 	
			 	<tr <c:if test='${items.fix_flag eq 1}'>bgcolor="#D0F5A9"</c:if> >			 	
			 		<td width="4%" align="center">${memberList.size() - status.index}</td>			 		
			 		<td width="12%" align="center">${items.team_name}</td>
			 		<td width="5%" align="center">${items.work_level_nm}</td>
			 		<td width="11%" align="center">${items.user_name}</td>			 		
			 		<td width="7%" align="center">${items.join_date_fmt}</td>
			 		<td width="7%" style="text-align:right;padding-right:10px;">${items.work_month_val}</td>
			 		<td width="7%" style="text-align:right;padding-right:10px;">${items.career_month_val}</td>
			 		<td width="7%" style="text-align:right;padding-right:10px;">${items.leave_month_val}</td>
			 		<td width="5%" align="center">
			 			<c:choose>
			 				<c:when test='${items.pay_flag eq "Annual"}'><font color="blue">${items.pay_flag_val}</font></c:when>
			 				<c:otherwise>${items.pay_flag_val}</c:otherwise>
			 			</c:choose>			 						 			
			 		</td>
			 		<td width="7%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.total_career_pay}" pattern="#,##0.##"/></td>
			 		<td width="7%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.total_work_pay}" pattern="#,##0.##"/></td>
			 		<td width="7%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.manager_pay}" pattern="#,##0.##"/></td>
			 		<td width="7%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_total_pay}" pattern="#,##0.##"/></td>
			 		<td width="8%" align="center">
			 			<a class="btn-vacation-detail" id="btn-detail" style="width: 58px;" onclick="javascript:doSalaryMemberDetail('${items.user_no}','${srchParam.base_sdate}','${srchParam.base_edate}')" href="#noloc">상세보기</a>			 			
			 		</td>
			 	</tr>
			 	<c:set var="sum_total_career_pay" value="${sum_total_career_pay + items.total_career_pay}" />
			 	<c:set var="sum_total_work_pay" value="${sum_total_work_pay + items.total_work_pay}" />
			 	<c:set var="sum_manager_pay" value="${sum_manager_pay + items.manager_pay}" />
			 	<c:set var="sum_base_total_pay" value="${sum_base_total_pay + items.base_total_pay}" />
			 </c:forEach>			
		</c:otherwise>
	</c:choose>	
</table>
<div style="height:5px;"></div>
<table>	
	<tr>
		<th width="10%">기본급 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${sum_total_career_pay}" pattern="#,##0.##"/></td>
		<th width="10%">근속수당 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${sum_total_work_pay}" pattern="#,##0.##"/></td>
		<th width="10%">팀장수당 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${sum_manager_pay}" pattern="#,##0.##"/></td>
		<th width="10%">총 합계</th>
		<td width="15%" style="text-align:right;padding-right:10px;"><b><font color="blue"><fmt:formatNumber value="${sum_base_total_pay}" pattern="#,##0.##"/></font></b></td>
	</tr>
</table>