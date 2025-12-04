<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=top_cost_tm_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body>

<!-- wrapper -->
 <table border="1">
 		<tr>
            <th>Type</th>
            <th>지점</th>
            <th>인원</th>
            <th>청구금액<br />(일반)</th>
            <th>청구금액<br />(추가)</th>
            <th>청구금액<br />(클레임)</th>
            <th>청구금액<br />(전체)</th>
            <th>팀장</th>
            <th>본부장</th>
            <th>자금팀 승인</th>
            <th>협조(의뢰)</th>
            <th>협조(수임)</th>
            <th>입금액</th>            
        </tr>		 	
		<c:forEach items="${costTmList0}" var="item" varStatus="status">
		<tr>
			<c:if test="${status.first}">
			<td rowspan="${costTmList0.size()}">
				총괄
			</td>
			</c:if>
			<td>${item.teamName}</td>
			<td>${item.userCnt}</td>
			<td><span class="money">${item.basicAmt}</span></td>
			<td><span class="money">${item.addAmt}</span></td>
			<td><span class="money">${item.claimAmt}</span></td>
			<td><span class="money">${item.totalAmt}</span></td>
			<td><span class="money">${item.tmAprvAmt}</span></td>
			<td><span class="money">${item.hqAprvAmt}</span></td>
			<td><span class="money">${item.financeAprvAmt}</span></td>
			<td><span class="money">${item.helpClientAmt}</span></td>
			<td><span class="money">${item.helpAcceptAmt}</span></td>
			<td><span class="money">${item.depositAmt}</span></td>			
		</tr>
		<c:set var="basicAmtSum0" value="${basicAmtSum0 + item.basicAmt}" />
		<c:set var="addAmtSum0" value="${addAmtSum0 + item.addAmt}" />
		<c:set var="claimAmtSum0" value="${claimAmtSum0 + item.claimAmt}" />
		<c:set var="totalAmtSum0" value="${totalAmtSum0 + item.totalAmt}" />
		<c:set var="tmAprvAmtSum0" value="${tmAprvAmtSum0 + item.tmAprvAmt}" />
		<c:set var="hqAprvAmtSum0" value="${hqAprvAmtSum0 + item.hqAprvAmt}" />
		<c:set var="financeAprvAmtSum0" value="${financeAprvAmtSum0 + item.financeAprvAmt}" />
		<c:set var="helpClientAmtSum0" value="${helpClientAmtSum0 + item.helpClientAmt}" />
		<c:set var="helpAcceptAmtSum0" value="${helpAcceptAmtSum0 + item.helpAcceptAmt}" />
		<c:set var="depositAmtSum0" value="${depositAmtSum0 + item.depositAmt}" />
		
		</c:forEach>
		<tr bgcolor="#E7ECF1">
            <td colspan="3">총괄 소계</td>
            <td><span class="money">${basicAmtSum0}</span></td>
	         <td><span class="money">${addAmtSum0}</span></td>
	         <td><span class="money">${claimAmtSum0}</span></td>
	         <td><span class="money">${totalAmtSum0}</span></td>
	         <td><span class="money">${tmAprvAmtSum0}</span></td>
	         <td><span class="money">${hqAprvAmtSum0}</span></td>
	         <td><span class="money">${financeAprvAmtSum0}</span></td>
	         <td><span class="money">${helpClientAmtSum0}</span></td>
	         <td><span class="money">${helpAcceptAmtSum0}</span></td>
	         <td><span class="money">${depositAmtSum0}</span></td>	         
		</tr>		
		<c:forEach items="${costTmList1}" var="item" varStatus="status">
		<tr>
			<c:if test="${status.first}">
			<td rowspan="${costTmList1.size()}">
				1종
			</td>
			</c:if>
			<td>${item.teamName}</td>
			<td>${item.userCnt}</td>
			<td><span class="money">${item.basicAmt}</span></td>
			<td><span class="money">${item.addAmt}</span></td>
			<td><span class="money">${item.claimAmt}</span></td>
			<td><span class="money">${item.totalAmt}</span></td>
			<td><span class="money">${item.tmAprvAmt}</span></td>
			<td><span class="money">${item.hqAprvAmt}</span></td>
			<td><span class="money">${item.financeAprvAmt}</span></td>
			<td><span class="money">${item.helpClientAmt}</span></td>
			<td><span class="money">${item.helpAcceptAmt}</span></td>
			<td><span class="money">${item.depositAmt}</span></td>			
		</tr>
		<c:set var="basicAmtSum1" value="${basicAmtSum1 + item.basicAmt}" />
		<c:set var="addAmtSum1" value="${addAmtSum1 + item.addAmt}" />
		<c:set var="claimAmtSum1" value="${claimAmtSum1 + item.claimAmt}" />
		<c:set var="totalAmtSum1" value="${totalAmtSum1 + item.totalAmt}" />
		<c:set var="tmAprvAmtSum1" value="${tmAprvAmtSum1 + item.tmAprvAmt}" />
		<c:set var="hqAprvAmtSum1" value="${hqAprvAmtSum1 + item.hqAprvAmt}" />
		<c:set var="financeAprvAmtSum1" value="${financeAprvAmtSum1 + item.financeAprvAmt}" />
		<c:set var="helpClientAmtSum1" value="${helpClientAmtSum1 + item.helpClientAmt}" />
		<c:set var="helpAcceptAmtSum1" value="${helpAcceptAmtSum1 + item.helpAcceptAmt}" />
		<c:set var="depositAmtSum1" value="${depositAmtSum1 + item.depositAmt}" />
		
		</c:forEach>
		<tr bgcolor="#E7ECF1">
			<td colspan="3">1종 소계</td>
			<td><span class="money">${basicAmtSum1}</span></td>
	        <td><span class="money">${addAmtSum1}</span></td>
	        <td><span class="money">${claimAmtSum1}</span></td>
	        <td><span class="money">${totalAmtSum1}</span></td>
	        <td><span class="money">${tmAprvAmtSum1}</span></td>
	        <td><span class="money">${hqAprvAmtSum1}</span></td>
	        <td><span class="money">${financeAprvAmtSum1}</span></td>
	        <td><span class="money">${helpClientAmtSum1}</span></td>
	        <td><span class="money">${helpAcceptAmtSum1}</span></td>
	        <td><span class="money">${depositAmtSum1}</span></td>	        
		</tr>		
		<c:forEach items="${costTmList4}" var="item" varStatus="status">
		<tr>
			<c:if test="${status.first}">
			<td rowspan="${costTmList4.size()}">
				4종
			</td>
			</c:if>
			<td>${item.teamName}</td>
			<td>${item.userCnt}</td>
			<td><span class="money">${item.basicAmt}</span></td>
			<td><span class="money">${item.addAmt}</span></td>
			<td><span class="money">${item.claimAmt}</span></td>
			<td><span class="money">${item.totalAmt}</span></td>
			<td><span class="money">${item.tmAprvAmt}</span></td>
			<td><span class="money">${item.hqAprvAmt}</span></td>
			<td><span class="money">${item.financeAprvAmt}</span></td>
			<td><span class="money">${item.helpClientAmt}</span></td>
			<td><span class="money">${item.helpAcceptAmt}</span></td>
			<td><span class="money">${item.depositAmt}</span></td>			
		</tr>
			<c:set var="basicAmtSum4" value="${basicAmtSum4 + item.basicAmt}" />
			<c:set var="addAmtSum4" value="${addAmtSum4 + item.addAmt}" />
			<c:set var="claimAmtSum4" value="${claimAmtSum4 + item.claimAmt}" />
			<c:set var="totalAmtSum4" value="${totalAmtSum4 + item.totalAmt}" />
			<c:set var="tmAprvAmtSum4" value="${tmAprvAmtSum4 + item.tmAprvAmt}" />
			<c:set var="hqAprvAmtSum4" value="${hqAprvAmtSum4 + item.hqAprvAmt}" />
			<c:set var="financeAprvAmtSum4" value="${financeAprvAmtSum4 + item.financeAprvAmt}" />
			<c:set var="helpClientAmtSum4" value="${helpClientAmtSum4 + item.helpClientAmt}" />
			<c:set var="helpAcceptAmtSum4" value="${helpAcceptAmtSum4 + item.helpAcceptAmt}" />
			<c:set var="depositAmtSum4" value="${depositAmtSum4 + item.depositAmt}" />		
		</c:forEach>
		<tr bgcolor="#E7ECF1">
            <td colspan="3">4종 소계</td>
            <td><span class="money">${basicAmtSum4}</span></td>
	        <td><span class="money">${addAmtSum4}</span></td>
	        <td><span class="money">${claimAmtSum4}</span></td>
	        <td><span class="money">${totalAmtSum4}</span></td>
	        <td><span class="money">${tmAprvAmtSum4}</span></td>
	        <td><span class="money">${hqAprvAmtSum4}</span></td>
	        <td><span class="money">${financeAprvAmtSum4}</span></td>
	        <td><span class="money">${helpClientAmtSum4}</span></td>
	        <td><span class="money">${helpAcceptAmtSum4}</span></td>
	        <td><span class="money">${depositAmtSum4}</span></td>	        
	    </tr>     
	     <tr bgcolor="#E7ECF1">
	         <td colspan="3">합계</td>
	         <td><span class="money">${basicAmtSum0+basicAmtSum1+basicAmtSum4}</span></td>
	         <td><span class="money">${addAmtSum0+addAmtSum1+addAmtSum4}</span></td>
	         <td><span class="money">${claimAmtSum0+claimAmtSum1+claimAmtSum4}</span></td>
	         <td><span class="money">${totalAmtSum0+totalAmtSum1+totalAmtSum4}</span></td>
	         <td><span class="money">${tmAprvAmtSum0+tmAprvAmtSum1+tmAprvAmtSum4}</span></td>
	         <td><span class="money">${hqAprvAmtSum0+hqAprvAmtSum1+hqAprvAmtSum4}</span></td>
	         <td><span class="money">${financeAprvAmtSum0+financeAprvAmtSum1+financeAprvAmtSum4}</span></td>
	         <td><span class="money">${helpClientAmtSum0+helpClientAmtSum1+helpClientAmtSum4}</span></td>
	         <td><span class="money">${helpAcceptAmtSum0+helpAcceptAmtSum1+helpAcceptAmtSum4}</span></td>
	         <td><span class="money">${depositAmtSum0+depositAmtSum1+depositAmtSum4}</span></td>
    	</tr>
	</table>
</body>

</html>
