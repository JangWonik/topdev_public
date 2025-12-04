<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%    
    response.setHeader("Content-Disposition", "attachment; filename=written_manage_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<body>
<table border="1">
	<tr>
		<th width="180px;">보험사</th>
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
				<tr>
					<td style="width:180px;text-align:center;">${items.ptnrName}</td>			
					<td style="width:180px;text-align:center;">${items.centerName}</td>
					<td style="width:180px;text-align:center;">${items.teamName}</td>
					<td style="width:150px;text-align:center;">${items.userName}</td>
					<td style="width:95px;text-align:right;padding-right:5px;">${items.suimCnt} 건</td>
					<td style="width:95px;text-align:right;padding-right:5px;">${items.endCnt} 건</td>
					<td style="width:95px;text-align:right;padding-right:5px;">${items.cancelCnt} 건</td>
					<td style="width:95px;text-align:right;padding-right:5px;">${items.transCntMinus} 건</td>
					<td style="width:95px;text-align:right;padding-right:5px;">${items.unsolveCnt} 건</td>
					<td style="width:120px;text-align:center;">${items.baseDateFmt}</td>
					<td style="width:120px;text-align:center;">${items.regDateFmt}</td>					
				</tr>				
			</c:forEach>				
		</c:otherwise>
	</c:choose>	
</table>
</body>