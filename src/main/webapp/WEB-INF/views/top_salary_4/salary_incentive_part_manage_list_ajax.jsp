<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${salaryPartInfoList.size() == 0}">
			<tr>
				<td colspan="12" align="center">조회 결과 값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${salaryPartInfoList}" varStatus="status">				
				<tr>
					<td width="5%" align="center">${salaryPartInfoList.size() - status.index}</td>
					<td width="12%" style="text-align:left;padding-left:5px;">${items.insu_name}</td>
					<td width="12%" style="text-align:left;padding-left:5px;">${items.part_name}</td>
					<td width="5%" align="center">${items.loss_rate}</td>
					<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_count}" pattern="#,##0.##"/></td>
					<td width="10%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_sales}" pattern="#,##0.##"/></td>
					<td width="8%" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.unit_sales}" pattern="#,##0.##"/></td>
					<td width="10%" align="center">
						<c:choose>
							<c:when test="${items.incentive_type eq 1}"><font color="blue">종결건</font></c:when>
							<c:when test="${items.incentive_type eq 2}"><font color="green">매출액</font></c:when>
							<c:otherwise> - </c:otherwise>
						</c:choose>						
					</td>
					<td width="6%" align="center">
						<c:choose>
							<c:when test="${items.is_use eq 0}">사용함</c:when>
							<c:otherwise><font color="red">사용안함</font></c:otherwise>
						</c:choose>						
					</td>
					<td width="7%" align="center">${items.reg_user_name}</td>
					<td width="7%" align="center">${items.reg_date_fmt}</td>
					<td width="10%" align="center">
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doSalaryPartMod('${items.pkey}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:doSalaryPartDelete('${items.pkey}','${items.part_name}');">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>