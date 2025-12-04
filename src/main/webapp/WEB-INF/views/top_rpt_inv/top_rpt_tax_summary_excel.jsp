<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=top_ptnr_tax_summary.xls"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
</head>
<body>
<h1>보험사별 계산서 합계</h1>
<h2>조회기간 : ${srchParam.summary_date_from} ~ ${srchParam.summary_date_to}</h2>
<table border=1>				
	<tr>
		<th style="width:50px;">순번</th>
		<th style="width:150px;">보험사명</th>
		<th style="width:150px;">계산서 합계</th>
		<th style="width:150px;">입금액 합계</th>
		<th style="width:150px;">미수금액 합계</th>						
	</tr>
	<c:forEach items="${summaryExcelList}" var="summaryVO" varStatus="status">
		<tr>
			<!--no-->
			<td style="width:50px;">${summaryExcelList.size() - status.index}</td>
			<!--보험사명-->
			<td style="width:150px;">${summaryVO.ptnr_nick}</td>
			<!--계산서 합계-->
			<td style="width:150px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${summaryVO.publish_amount}" pattern="###,###,##0.##"/> 원</td>
			<!--입금액 합계-->
			<td style="width:150px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${summaryVO.deposit_amount}" pattern="###,###,##0.##"/> 원</td>
			<!--미수금액 합계-->
			<td style="width:150px;text-align:right;padding-right:5px;color:red;"><fmt:formatNumber value="${summaryVO.publish_amount - summaryVO.deposit_amount}" pattern="###,###,##0.##"/> 원</td>
		</tr>
		<c:set var="sum_tax_amount" value="${summaryVO.publish_amount + sum_tax_amount}" />
		<c:set var="sum_deposit_amount" value="${summaryVO.deposit_amount + sum_deposit_amount}" />
		<c:set var="sum_minus_amount" value="${summaryVO.publish_amount - summaryVO.deposit_amount + sum_minus_amount}" />
	</c:forEach>
</table>		
<br/>
<table border=1>
	<tr>					
		<th>세금계산서 총합</th>
		<td style="text-align:right;padding-right:5px;"><b><fmt:formatNumber value="${sum_tax_amount}" pattern="###,###,##0.##"/> 원</b></td>					
		<th>입금액 총합</th>
		<td style="text-align:right;padding-right:5px;"><b><font color="blue"><fmt:formatNumber value="${sum_deposit_amount}" pattern="###,###,##0.##"/> 원</font></b></td>
		<th>미수금액 총합</th>
		<td style="text-align:right;padding-right:5px;"><b><font color="red"><fmt:formatNumber value="${sum_minus_amount}" pattern="###,###,##0.##"/> 원</font></b></td>					
	</tr>				
</table>
</body>
</html>