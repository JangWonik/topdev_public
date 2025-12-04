<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<style>
		.tableStyle2 td{letter-spacing:0px;}
	</style>
		<div class="tableStyle2" style="width: 970px;">			
				<table class="tableModal">
					<tr>
						<th style="width:50px;">순번</th>
						<th style="width:100px;">작업번호</th>
						<th style="width:90px;">접수번호</th>
						<th style="width:120px;">사고번호</th>
						<th style="width:100px;">조사자</th>
						<th style="width:200px;">계약자명</th>
						<th style="width:80px;">입금일자</th>
						<th style="width:80px;">계산서일자</th>
						<th style="width:70px;">작업자명</th>
						<th style="width:70px;">작업결과</th>						
					</tr>
					<c:choose>
						<c:when test="${logSearchList.size() == 0}">
							<td colspan="10">조회된 결과가 없습니다.</td>
						</c:when>
						<c:otherwise>
							<c:forEach items="${logSearchList}" var="item" varStatus="status">
								<tr>
									<td>${logSearchList.size() - status.index}</td>
									<td>${item.work_no}</td>
									<td>${item.suim_accept_no}</td>
									<td>${item.accident_no}</td>
									<td>${item.writer_nm}</td>
									<td title="${item.policyholder_nm}">
										<c:choose>
											<c:when test="${fn:length(item.policyholder_nm) > 15}">
												${fn:substring(item.policyholder_nm,0,15)}...
											</c:when>
											<c:otherwise>${item.policyholder_nm}</c:otherwise>
										</c:choose>
									
									</td>
									<td>${item.deposit_date_fmt}</td>
									<td>${item.tax_date_fmt}</td>
									<td>${item.work_user_nm}</td>
									<td>${item.action_flag}</td>
								</tr>
							</c:forEach>	
						</c:otherwise>
					</c:choose>
				</table>			
		</div>
				
		
	