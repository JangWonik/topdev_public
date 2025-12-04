<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class= "tableStyle2" style="width: 100%;text-align: center; margin: 0 auto;" align="center">
	<table class="invoiceResultTable">		
		<c:forEach items="${summaryList}" var="summaryVO" varStatus="status">
			<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" >
				<!--no-->
				<td style="width:4%">${summaryList.size() - status.index}</td>
				<!--보험사명-->
				<td style="width:24%;">${summaryVO.ptnr_nick}</td>
				<!--계산서 합계-->
				<td style="width:24%;text-align:right;padding-right:5px;"><fmt:formatNumber value="${summaryVO.publish_amount}" pattern="###,###,##0.##"/> 원</td>
				<!--입금액 합계-->
				<td style="width:24%;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${summaryVO.deposit_amount}" pattern="###,###,##0.##"/> 원</td>
				<!--미수금액 합계-->
				<td style="width:24%;text-align:right;padding-right:5px;color:red;"><fmt:formatNumber value="${summaryVO.publish_amount - summaryVO.deposit_amount}" pattern="###,###,##0.##"/> 원</td>
			</tr>
			<c:set var="sum_tax_amount" value="${summaryVO.publish_amount + sum_tax_amount}" />
			<c:set var="sum_deposit_amount" value="${summaryVO.deposit_amount + sum_deposit_amount}" />
			<c:set var="sum_minus_amount" value="${summaryVO.publish_amount - summaryVO.deposit_amount + sum_minus_amount}" />
		</c:forEach>
	</table>
</div>
<br/>
<!-- 총계 테이블 -->
<div class= "tableStyle2">
	<table class="invoiceResultTable">
			<tr>					
				<th>세금계산서 총합</th>
				<td style="text-align:right;padding-right:5px;"><b><fmt:formatNumber value="${sum_tax_amount}" pattern="###,###,##0.##"/> 원</b></td>					
				<th>입금액 총합</th>
				<td style="text-align:right;padding-right:5px;"><b><font color="blue"><fmt:formatNumber value="${sum_deposit_amount}" pattern="###,###,##0.##"/> 원</font></b></td>
				<th>미수금액 총합</th>
				<td style="text-align:right;padding-right:5px;"><b><font color="red"><fmt:formatNumber value="${sum_minus_amount}" pattern="###,###,##0.##"/> 원</font></b></td>					
			</tr>				
	</table>
</div><!-- //tableStyle2 -->
<!-- //총계 테이블 -->