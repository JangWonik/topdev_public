<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<html>
<head>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>    
	  th{
	  	font-size:28px;
	  	font-weight:bold;
	  }
</style>
<script>
	$(document).ready(function() {
		window.print();
	});
</script>   
</head>
<div class="tableStyle2" id="area_excel" style="padding-top:10px;">
	<!-- 내용 테이블 시작 -->										
	<c:forEach items="${label_list}" var="labelVo" varStatus="status">
		<table style="width:230px;height:100px;float:left;">
			<tr>
				<th>탑손해사정(주)</th>			</tr>
			<tr>
				<th>${labelVo.eq_no}</th>
			</tr>
		</table>		
		<c:if test="${status.count % 3 eq 0}">
			<table  style="width:500px;height:50px;border:1px;">
				<tr>
					<td style="border:0px;"> </td>
				</tr>
			</table>	
		</c:if>
	</c:forEach>
</div>    
</html>