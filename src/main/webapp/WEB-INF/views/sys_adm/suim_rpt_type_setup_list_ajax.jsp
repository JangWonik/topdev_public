<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${codeList.size() == 0}">
			<tr>
				<td colspan="8" align="center">검색결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${codeList}" varStatus="status">
				<c:set var="idx" value="${codeList.size() - status.index}"/>
				<tr id="info_view_${idx}">
					<td width="50px">${idx}</td>
					<td width="120px">${items.type_name1}</td>
					<td width="220px">${items.type_name2}</td>
					<td width="100px">${items.type_code1}</td>
					<td width="100px">${items.type_code2}</td>					
					<td width="300px">
						<input type="radio" name="div_type_${idx}" id="div_type_${idx}" value="0" <c:if test="${items.div_type == 0}">checked</c:if> > 미설정 &nbsp;
						<input type="radio" name="div_type_${idx}" id="div_type_${idx}" value="5" <c:if test="${items.div_type == 5}">checked</c:if> > 물보험 조사 &nbsp; 
						<input type="radio" name="div_type_${idx}" id="div_type_${idx}" value="10" <c:if test="${items.div_type == 10}">checked</c:if> > 물보험 심사 &nbsp;
						<input type="radio" name="div_type_${idx}" id="div_type_${idx}" value="15" <c:if test="${items.div_type == 15}">checked</c:if> > 물보험 기타						
					</td>					
					<td width="80px">						
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doTypeModify('${idx}','${items.type_code1}','${items.type_code2}');">수정</a>
					</td>					
					<c:if test="${codeList.size() < 23}">
						<td width="10px"></td>
					</c:if>
				</tr>				
			</c:forEach>			
		</c:otherwise>
	</c:choose>
</table>