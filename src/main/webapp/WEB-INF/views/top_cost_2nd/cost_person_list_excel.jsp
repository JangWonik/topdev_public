<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=top_cost_person_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>	
	<div class= "tableStyle2 costTable" style="overflow:scroll;width:100%; height:600px;">
		<table border="1">
			<tr>
				<th width="11%">팀명</th>
				<th width="11%">이름</th>
				<th width="6%">청구금액<br />(일반)</th>
				<th width="6%">청구금액<br />(추가)</th>
				<th width="6%">청구금액<br />(클레임)</th>
				<th width="6%">청구금액<br />(전체)</th>
				<th width="6%">팀장</th>
				<th width="6%">본부장</th>
				<th width="6%">자금팀 승인</th>
				<th width="6%">협조<br />(의뢰)</th>
				<th width="6%">협조<br />(수임)</th>
				<th width="6%">협조세금<br />(교통비)</th>
				<th width="6%">협조세금<br />(챠트비)</th>
				<th width="6%">입금액</th>
				<th width="6%">입금일</th>				
			</tr>							
			<c:forEach items="${personList}" var="item" varStatus="status">
				<tr>
					<td>${item.team_name}</td>
					<td>${item.user_name}</td>
					<td><span class="money">${item.cost_base_deposit_amt}</span></td>
					<td><span class="money">${item.cost_addition_deposit_amt}</span></td>
					<td><span class="money">${item.cost_claim_deposit_amt}</span></td>
					<td><span class="money">${item.cost_total_amt}</span></td>
					<td>
						<span class="money">${item.tm_aprv_amt}</span>
					</td>
					<td>
						<c:choose>
							<c:when test="${item.hq_aprv_amt ne '0'}">
								<span class="money">${item.hq_aprv_amt}</span><br/>
							</c:when>
							<c:otherwise>0</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${item.finance_aprv_amt ne '0'}">
								<span class="money">${item.finance_aprv_amt}</span><br/>
							</c:when>
							<c:otherwise>0</c:otherwise>
						</c:choose>						
					</td>
					<td><span class="money">${item.help_client_traffic_fee+item.help_client_chart_fee}</span></td>
					<td><span class="money">${item.help_accept_traffic_fee+item.help_accept_chart_fee}</span></td>
					<td><fmt:formatNumber value="${item.help_accept_traffic_fee-item.help_client_traffic_fee}" pattern="###,###,##0"/></td>
					<td><fmt:formatNumber value="${item.help_accept_chart_fee-item.help_client_chart_fee}" pattern="###,###,##0"/></td>
					<td>
						<c:choose>
							<c:when test="${item.cost_deposit_amt ne '0'}">
								<span class="money">${item.cost_deposit_amt}</span>
							</c:when>
							<c:otherwise>0</c:otherwise>
						</c:choose>						
					</td>
					<td align="center">
						<c:choose>
							<c:when test="${item.cost_deposit_date > 0}">
								${item.cost_deposit_date_fmt}
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>																		
					</td>																									
				</tr>
			</c:forEach>			
		</table>
	</div><!-- //tableStyle2 -->
</body>

</html>
