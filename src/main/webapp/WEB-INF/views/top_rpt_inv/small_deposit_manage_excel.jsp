<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>	
	<style>p,td{font-size:10pt;}</style>
</head>
<div class= "tableStyle2">
	<!-- 검색 결과 테이블 시작-->
	<table border="1">									
		<tr>
			<th height="28px" width="50px">No</th>
			<th width="170px">보험사(거래처)</th>
			<th width="100px">입금금액</th>
			<th width="100px">계산서금액</th>
			<th width="100px">입금일자</th>			
			<th width="100px">등록일</th>				
			<th width="80px">등록자</th>
			<th width="80px">최종수정일</th>
			<th width="80px">최종수정자</th>
			<th width="300px">비고</th>			
		</tr>	
		<c:choose>
			<c:when test="${depositList.size() == 0}">
				<tr>
					<td colspan="9">검색결과가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
		<c:forEach items="${depositList}" var="item" varStatus="status">
			<c:set var="idx" value="${depositList.size() - status.index}"/>
			<tr>
				<!-- No -->
				<td width="50px">${idx}</td>
				<!-- 보험사(거래처) -->
				<td width="170px">${item.ptnr_name}</td>
				<!-- 입금금액 -->
				<td width="95px" style="text-align:right;padding-right:5px;">
					<fmt:formatNumber value="${item.income_amount}" pattern="###,###,##0.##"/>
				</td>
				<!-- 계산서금액 -->
				<td width="95px" style="text-align:right;padding-right:5px;">
					<fmt:formatNumber value="${item.tax_amount}" pattern="###,###,##0.##"/>
				</td>
				<!-- 입금일자 -->
				<td width="100px">${item.income_date_fmt}</td>
				<!-- 등록일 -->
				<td width="100px">${item.reg_date_fmt}</td>
				<!-- 등록자 -->				
				<td width="80px">${item.reg_user_name}</td>
				<!-- 최종수정일 -->
				<td width="80px">${item.modify_date_fmt}</td>
				<!-- 최종수정자 -->
				<td width="80px">${item.modify_user_name}</td>
				<!-- 비고-->
				<td width="295px" style="text-align:left;padding-left:5px;">${item.extra_memo}</td>
				<!-- 수정, 삭제 기능버튼 -->								
			</tr>			
			<c:set var="sum_income_amount" value="${sum_income_amount + item.income_amount}"></c:set>
			<c:set var="sum_tax_amount" value="${sum_tax_amount + item.tax_amount}"></c:set>
		</c:forEach>	
		<tr>
			<th colspan="2"><font color="red">목록 금액 합계</font></th>			
			<th style="text-align:right;padding-right:5px;font-color:red;">
				<font color="red"><fmt:formatNumber value="${sum_income_amount}" pattern="###,###,##0.##"/></font>
			</th>
			<th style="text-align:right;padding-right:5px;font-color:red;">
				<font color="red"><fmt:formatNumber value="${sum_tax_amount}" pattern="###,###,##0.##"/></font>
			</th>
			<th colspan="6"></th>
		</tr>									
	</table>
	<!-- 합계 테이블 끝-->
</div>