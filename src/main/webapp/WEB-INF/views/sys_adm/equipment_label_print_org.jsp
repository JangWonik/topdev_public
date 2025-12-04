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
	  table {
	    width: 50%;
	    border: 2px solid #444444;
	    border-collapse: collapse;
	    float:left;
	  }
	  
	  th, td {
	    border: 1px solid #444444;
	  }
</style>
<script>
	$(document).ready(function() {
		window.print();
	});
</script>   
</head>
    <div class="tableStyle2" id="area_excel">
		<!-- 내용 테이블 시작 -->									
		<c:forEach items="${label_list}" var="labelVo" varStatus="status">										
			<table style="width:300px;float:left;">
				<tr style="height:50px;">
					<td style="width:300px;text-align:center;" colspan="2">
						<span style="font-size: 25px;"><b>탑손해사정(주) 전산장비</b></span>
					</td>													
				</tr>
				<tr style="height:45px;">
					<td style="height:35px;width:100px;text-align:center;">
						<b>일련번호</b>
					</td>
					<td style="height:35px;width:200px;text-align:center;">
						${labelVo.eq_no}
					</td>
				</tr>
				<tr style="height:45px;">
					<td style="height:35px;width:100px;text-align:center;">
						<b>구분</b>
					</td>
					<td style="height:35px;width:200px;text-align:center;">
						${labelVo.eq_type_nm}
					</td>
				</tr>
				<tr style="height:45px;">
					<td style="height:35px;width:100px;text-align:center;">
						<b>관리부서</b>
					</td>
					<td style="height:35px;width:200px;text-align:center;">
						${labelVo.team_name}
					</td>
				</tr>
				<tr style="height:45px;">
					<td style="height:35px;width:100px;text-align:center;">
						<b>확인일자</b>
					</td>
					<td style="height:35px;width:200px;text-align:center;">
						${chk_date}
					</td>
				</tr>
				<tr style="height:45px;">
					<td style="height:40px;width:300px;text-align:center;" colspan="2">
						<span style="font-size: 25px;"><b>관리 내역</b></span>
					</td>													
				</tr>
				<tr>
					<td style="height:200px;width:300px;text-align:left;left-padding:5px;" colspan="2">
						<c:if test="${chk_memo eq 1}">
							<c:choose>							
								<c:when test="${fn:length(labelVo.eq_memo) > 250}">
									${fn:substring(labelVo.eq_memo,0,250)} ...<br/>
									(이하 내용 별도 확인 필요)
								</c:when>
								<c:otherwise>
									${labelVo.eq_memo}
								</c:otherwise>
							</c:choose>
						</c:if>
					</td>
				</tr>
			</table>
			<table  style="width:30px;float:left;border:0px;">
				<tr>
					<td style="border:0px;"> </td>
				</tr>
			</table>
			<c:if test="${status.count % 2 eq 0}">
				<table  style="width:500px;height:50px;border:0px;">
					<tr>
						<td style="border:0px;"> </td>
					</tr>
				</table>	
			</c:if>													
		</c:forEach>	
		</div>
</html>