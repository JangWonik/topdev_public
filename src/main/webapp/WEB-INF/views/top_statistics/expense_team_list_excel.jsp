<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=expense_team_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<body>
<div class="tableStyle2" id="area_excel">
    <div style="padding-right: 17px;background: #e7ecf1;">
	    <table cellpadding="0" cellspacing="0" width="1060" align="center" border="1">								        
	        <tr>
	        	<th class="border-right" width="5%">센터명</th>
	        	<th class="border-right" width="5%">팀명</th>
	        	<th class="border-right" width="5%">센터&middot;팀 장명</th>
	        	<th class="border-right" width="5%">평균인원수</th>
	        	<c:forEach var="days" items="${dates}" varStatus="status">								        		
	        		<th class="border-right" width="2%">${fn:substring(days,5,10)}</th>
	        	</c:forEach>								        									            	            
	        </tr>								        
	        <c:choose>
	        	<c:when test="${expenseTeamList.size() eq 0}">
	        		<tr>
			        		<td class="border-right" colspan="${dates.size()+4}">
			        			해당날짜의 적재된 팀 누적정보가 없습니다.
			        		</td>
			        </tr>
	        	</c:when>
	        	<c:otherwise>
	        		<c:forEach var="items" items="${expenseTeamList}" varStatus="status">
	        			<c:choose>
	        				<c:when test="${items.teamLevel eq 0}">
	        					<tr bgcolor="yellow">
					        		<td class="border-right">${items.centerName}</td>
					                <td class="border-right">${items.teamName}</td>
					                <td class="border-right">${items.teamManagerName}</td>
					                <td class="border-right"><fmt:formatNumber value="${items.totalCnt / items.divisionCnt}" pattern="0.0"/></td>
					                <c:forEach var="daysTerm" begin="0" end="${items.daysCnt-1}" varStatus="s">
					                	<c:set var="tempName">cnt${daysTerm}</c:set>
					                	<c:set var="tempDate">date${daysTerm}</c:set>												                	
					                	<td class="border-right">${items[tempName]}</td>												                		
					                </c:forEach>
								</tr>
	        				</c:when>
	        				<c:otherwise>
	        					<tr>
					        		<td class="border-right">${items.centerName}</td>
					                <td class="border-right">${items.teamName}</td>
					                <td class="border-right">${items.teamManagerName}</td>
					                <td class="border-right"><fmt:formatNumber value="${items.totalCnt / items.divisionCnt}" pattern="0.0"/></td>
					                <c:forEach var="daysTerm" begin="0" end="${items.daysCnt-1}" varStatus="s">
					                	<c:set var="tempName">cnt${daysTerm}</c:set>
					                	<c:set var="tempDate">date${daysTerm}</c:set>												                	
					                	<td class="border-right">${items[tempName]}</td>												                		
					                </c:forEach>
								</tr>
	        				</c:otherwise>
	        			</c:choose>										        	
			        </c:forEach>
	        	</c:otherwise>
	        </c:choose>								        								        								        
	    </table>
	</div>
</div>
</body>
</html>