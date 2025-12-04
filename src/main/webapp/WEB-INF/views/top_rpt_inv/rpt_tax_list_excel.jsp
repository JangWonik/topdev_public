<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=TaxList.xls"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
</head>

<body>

	<h1>TaxList.xls</h1>
	<br /><br />	
	<!-- 검색 결과 테이블 -->
	<h2>검색 결과 테이블</h2>
			<table border="1">
				<thead>
					<tr>
						<th style="width:4%" bgcolor="#e7ecf1">보고서구분</th>
						<th bgcolor="#e7ecf1">접수번호</th>
						<th bgcolor="#e7ecf1">보험사</th>
						<th bgcolor="#e7ecf1">센터명</th>
						<th bgcolor="#e7ecf1">팀명</th>
						<th bgcolor="#e7ecf1">조사자</th>
						<th bgcolor="#e7ecf1">종결일</th>
						<th bgcolor="#e7ecf1">발행일</th>
						<th bgcolor="#e7ecf1">입금일</th>
						<th bgcolor="#e7ecf1">입금금액</th>
						<th bgcolor="#e7ecf1">계산서합계</th>
						<th bgcolor="#e7ecf1">입금합계</th>
						<th bgcolor="#e7ecf1">미수잔액</th>
						<th bgcolor="#e7ecf1">상태</th>						
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${invList}" var="invVO">
						<tr>							
							<!--보고서 구분-->
							<td>
								<c:choose>
									<c:when test="${invVO.rpt_type eq 1}">일반</c:when>
									<c:when test="${invVO.rpt_type eq 2}">농작물</c:when>
								</c:choose>							
							</td>
							<!-- 접수번호 -->							
							<td>${invVO.suim_accept_no}</td>
							<!--보험사-->
							<td>${invVO.ptnr_name}</td>
							<!-- 센터명 -->
							<td>${invVO.center_name}</td>
							<!-- 팀명 -->
							<td>${invVO.team_name}</td>
							<!--조사자-->
							<td>${invVO.user_name}</td>
							<!-- 종결일 -->
							<td>${invVO.close_date_fmt}</td>
							<!-- 발행일(세금계산서) -->
							<td>${invVO.publish_date_fmt}</td>
							<!-- 입금일 -->
							<td>${invVO.invoice_deposit_date}</td>
							<!-- 입금금액 -->
							<td><fmt:formatNumber value="${invVO.invoice_amt_total}" pattern="###,###,##0.##"/></td>
							<!--계산서 합계-->
							<td style="text-align:right;padding-right:5px;">
								<fmt:formatNumber value="${invVO.sum_tax_val}" pattern="###,###,##0.##"/>
							</td>
							<!--입금 합계-->
							<td style="text-align:right;padding-right:5px;">
								<fmt:formatNumber value="${invVO.sum_deposit_val}" pattern="###,###,##0.##"/>
							</td>
							<!--미수잔액-->
							<td style="text-align:right;padding-right:5px;">
								<c:choose>
									<c:when test="${invVO.sum_minus_val < 0}"><font color="blue"><fmt:formatNumber value="${invVO.sum_minus_val}" pattern="###,###,##0.##"/></font></c:when>
									<c:when test="${invVO.sum_minus_val > 0}"><font color="red"><fmt:formatNumber value="${invVO.sum_minus_val}" pattern="###,###,##0.##"/></font></c:when>
									<c:otherwise><fmt:formatNumber value="${invVO.sum_minus_val}" pattern="###,###,##0.##"/></c:otherwise>
								</c:choose>								
							</td>
							<!-- 구분 -->							
							<td>
								<c:choose>
									<c:when test="${invVO.tax_edit_end eq 0}"><font color="red">미완료</font></c:when>
									<c:when test="${invVO.tax_edit_end eq 1}">완료</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>					
				</tbody>
			</table>
	<!-- //검색 결과 테이블 -->
	<br /><br />
	<!-- 총계 테이블 -->
	<h2>총계 테이블</h2>
		<table border="1">
				<tr>					
					<th>세금계산서 총합</th>
					<td style="text-align:right;padding-right:5px;"><b><fmt:formatNumber value="${total_tax_amount}" pattern="###,###,##0.##"/></b></td>					
					<th>입금액 총합</th>
					<td style="text-align:right;padding-right:5px;"><b><font color="blue"><fmt:formatNumber value="${total_deposit_amount}" pattern="###,###,##0.##"/></font></b></td>
					<th>미수금액 총합</th>
					<td style="text-align:right;padding-right:5px;"><b><font color="red"><fmt:formatNumber value="${total_minus_amount}" pattern="###,###,##0.##"/></font></b></td>					
				</tr>																					
		</table>
	<!-- //총계 테이블 -->
</body>
</html>
