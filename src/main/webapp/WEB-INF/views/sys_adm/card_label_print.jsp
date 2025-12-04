<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>    
    <style>        	
	  table {
	    width: 50%;
	    border: 1px solid #444444;
	    border-collapse: collapse;
	    float:left;
	  }
	  
	  th, td {
	    border: 0px solid #444444;
	  }
</style>
<script>
	$(document).ready(function() {
		window.print();
	});
</script>   
</head>
    <div>
		<!-- 내용 테이블 시작 -->									
		<c:forEach items="${label_list}" var="labelVo" varStatus="status">										
			<table style="width:130px;">				
				<tr>
					<td style="height:140px;width:120px;text-align:center;">						
						<c:choose>
							<c:when test="${labelVo.imageBase64 == 'temp' }">
								<!-- 이주윤 주임 요청사항으로 임시 문구 제거 by top3009 20240327 -->
								<!-- <span style="color:	#008000;font-weight:bold;">- 임 시 -</span> -->
								<div style="width:90px;height:120px;color:#FFFFFF"></div>
							</c:when>
							<c:when test="${labelVo.imageBase64 == 'public' }">
								<span style="color:	#0000FF;font-weight:bold;">- 공 용 -</span>
							</c:when>
							<c:when test="${labelVo.imageBase64 == 'nothing' }">
								<div style="width:90px;height:120px;color:#FFFFFF"></div>
							</c:when>
							<c:otherwise>								
								<img src="${labelVo.imageBase64}"  width="90px" height="120px" />																
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr style="height:30px;">					
					<td style="height:25px;width:200px;text-align:center;">
						<span style="color:	#325095;font-size:16px;font-weight:bold;letter-spacing:1px;">
							<c:choose>
								<c:when test="${not empty labelVo.card_uid}">${labelVo.card_uid}</c:when>
								<c:when test="${empty labelVo.user_name}">${labelVo.card_uid}</c:when>
								<c:when test="${fn:indexOf(labelVo.user_name,'(') > 0}">
									${fn:substring(labelVo.user_name,0,fn:indexOf(labelVo.user_name,'('))}
								</c:when>								
								<c:otherwise>
									${labelVo.user_name}
								</c:otherwise>
							</c:choose>							
						</span>
					</td>
				</tr>
				<tr style="height:25px;">
					<td style="height:20px;width:200px;text-align:center;">
						<span style="font-size:12px;font-weight:bold;letter-spacing:1px;">${labelVo.card_number}</span>
					</td>
				</tr>
			</table>
			<table  style="width:30px;float:left;border:0px;">
				<tr>
					<td style="border:0px;"> </td>
				</tr>
			</table>
			<c:if test="${status.count % 4 eq 0}">
				<table  style="width:600px;height:20px;border:0px;">
					<tr>
						<td style="border:0px;"> </td>
					</tr>
				</table>	
			</c:if>													
		</c:forEach>	
		</div>
</html>