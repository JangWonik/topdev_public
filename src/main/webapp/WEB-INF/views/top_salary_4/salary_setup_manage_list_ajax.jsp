<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${salarySetupInfoList.size() == 0}">
			<tr>
				<td colspan="14" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${salarySetupInfoList}" varStatus="status">				
				<tr>
					<td width="3%" align="center">${salarySetupInfoList.size() - status.index}</td>
					<td width="12%" style="padding-left:5px;" title="${items.salary_subject}"><div style="cursor:pointer;width:140px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" alt="${items.salary_subject}" onclick="javascript:doSalarySetupInfoView('${items.skey}')">${items.salary_subject}</div></td>
					<td width="15%" align="center">${items.term_sdate_fmt} ~ ${items.term_edate_fmt}</td>
					<td width="4%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.intern_pay / 10000}" pattern="#,##0.##"/></td>					
					<td width="5%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.career_pay_1 / 10000}" pattern="#,##0.##"/></td>
					<td width="5%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.career_pay_2 / 10000}" pattern="#,##0.##"/></td>
					<td width="5%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.career_pay_3 / 10000}" pattern="#,##0.##"/></td>
					<td width="5%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.career_pay_4 / 10000}" pattern="#,##0.##"/></td>
					<td width="5%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.conti_pay_1 / 10000}" pattern="#,##0.##"/></td>
					<td width="5%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.conti_pay_2 / 10000}" pattern="#,##0.##"/></td>
					<td width="5%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.conti_pay_3 / 10000}" pattern="#,##0.##"/></td>
					<td width="5%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.conti_pay_4 / 10000}" pattern="#,##0.##"/></td>					
					<td width="4%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.manager_pay / 10000}" pattern="#,##0.##"/></td>
					<td width="6%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.max_pay / 10000}" pattern="#,##0.##"/></td>					
					<td width="4%" align="center">
						<c:choose>
							<c:when test="${items.is_use eq 0}">O</c:when>
							<c:otherwise>X</c:otherwise>
						</c:choose>
					</td>					
					<td width="12%" align="center">
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doSalarySetupMod('${items.skey}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:doSalarySetupDelete('${items.skey}','${items.salary_subject}');">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>