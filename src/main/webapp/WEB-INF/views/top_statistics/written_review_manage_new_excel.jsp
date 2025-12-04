<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%    
    response.setHeader("Content-Disposition", "attachment; filename=written_user_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<body>
<table border="1">
	<tr>
		<th width="150px;">보험사</th>
		<th width="180px;">센터명</th>
		<th width="180px;">부서명</th>
		<th width="150px;">이 름</th>
		<th width="95px;">수임건수</th>
		<th width="95px;">종결건수</th>
		<th width="95px;">취소건수</th>
		<th width="95px;">이내첩건수</th>
		<th width="100px;">미결건수</th>
		<th width="120px;">기준일</th>
		<th width="120px;">등록일</th>									
	</tr>	
	<c:choose>		
		<c:when test="${writtenList.size() == 0}">
			<tr>
				<td colspan="9" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>						
			<c:forEach var="items" items="${writtenList}" varStatus="status">
				<c:set var="sumSuimCnt" value="${sumSuimCnt + items.suimCnt}"/>
				<c:set var="sumEndCnt" value="${sumEndCnt + items.endCnt}"/>
				<c:set var="sumCancelCnt" value="${sumCancelCnt + items.cancelCnt}"/>
				<%-- <c:set var="sumTransCnt" value="${sumTransCnt + items.transCnt}"/> --%>
				<c:set var="sumTransCnt" value="${sumTransCnt + items.transCntMinus}"/>
				<c:set var="sumUnsolveCnt" value="${sumUnsolveCnt + items.unsolveCnt}"/>				
				<tr>
					<td style="width:150px;text-align:center;">${items.ptnrName}</td>			
					<td style="width:180px;text-align:center;">${items.centerName}</td>
					<td style="width:180px;text-align:center;">${items.teamName}</td>
					<td style="width:150px;text-align:center;">${items.userName}</td>
					<td style="width:95px;text-align:right;">${items.suimCnt}</td>
					<td style="width:95px;text-align:right;">${items.endCnt}</td>
					<td style="width:95px;text-align:right;">${items.cancelCnt}</td>
					<%-- <td style="width:95px;text-align:right;">${items.transCnt}</td> --%>
					<td style="width:95px;text-align:right;">${items.transCntMinus}</td>
					<td style="width:95px;text-align:right;">${items.unsolveCnt}</td>
					<td style="width:120px;text-align:center;">${items.baseDateFmt}</td>
					<td style="width:120px;text-align:center;">${items.regDateFmt}</td>					
				</tr>	
			</c:forEach>
			<tr>
				<th colspan="4">합 계</th>
				<th style="text-align:right;">${sumSuimCnt}</th>
				<th style="text-align:right;">${sumEndCnt}</th>				
				<th style="text-align:right;">${sumCancelCnt}</th>
				<th style="text-align:right;">${sumTransCnt}</th>
				<th style="text-align:right;">${sumUnsolveCnt}</th>
				<th colspan="2">-</th>
			</tr>				
		</c:otherwise>
	</c:choose>	
</table>
</body>