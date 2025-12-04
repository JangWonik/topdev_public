<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${periodList.size() == 0}">
			<tr>
				<td colspan="8" align="center">검색결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${periodList}" varStatus="status">
				<c:set var="idx" value="${periodList.size() - status.index}"/>
				<tr id="info_view_${idx}">
					<td width="50px">${idx}</td>
					<td width="200px">${items.ptnr_name}</td>
					<td width="200px">${items.ptnr_id_sub_name}</td>
					<td width="100px">${items.ptnr_id}</td>
					<td width="100px">${items.ptnr_id_sub}</td>					
					<td width="200px">
						<input type="radio" name="div_period_${idx}" id="div_period_${idx}" value="0" <c:if test="${items.period_flag == 0}">checked</c:if> > 사용안함 &nbsp;
						<input type="radio" name="div_period_${idx}" id="div_period_${idx}" value="1" <c:if test="${items.period_flag == 1}">checked</c:if> > 사용함						
					</td>					
					<td width="80px">
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doPeriodModify('${idx}','${items.ptnr_id}','${items.ptnr_id_sub}');">수정</a>
					</td>					
					<c:if test="${periodList.size() < 23}">
						<td width="10px"></td>
					</c:if>
				</tr>				
			</c:forEach>			
		</c:otherwise>
	</c:choose>
</table>