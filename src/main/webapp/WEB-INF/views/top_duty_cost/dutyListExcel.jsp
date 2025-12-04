<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    //String fileName = (String)pageContext.getAttribute("subject");
    response.setHeader("Content-Disposition", "attachment; filename=duty_list_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	
</head>
<body>
	<table border="1">
		<colgroup>
		<col style="width: 10%">
		<col style="width: 70%">
		<col style="width: 10%">
		<col style="width: 10%">
		</colgroup>
		<tr>
			<th>당직일자</th>
			<th>당직자</th>
		</tr>
		<c:forEach  var="item" items="${list}" varStatus="status">
		<tr>	
<%-- 			<td>${fn:substring(item.caDe,0,4)}-${fn:substring(item.caDe,4,6)}-${fn:substring(item.caDe,6,8)}</td> *JSTL 날짜 자르기--%>					
			<td>${item.caDe}</td> <!-- 날짜를 뿌린다. -->
			<td style="text-align: left; padding: 0px 5px;	">
				<c:set var="infoList" value="${fn:split(item.userInfo,',')}" /> <!-- userInfo를 , 를 기준으로 나눠 배열로 담는다 -->
				<c:forEach var="Litem" items="${infoList}" varStatus="status"> <!-- 배열을 돌면서 리스트아이템에 접근을 한다 -->
					<c:set var="Sitem" value="${fn:split(Litem,'-')}" /> <!-- -를 기준으로 나눠 배열로 담는다 -->
<%-- 					${Sitem[0]}1<br> 당직코드
					${Sitem[1]}<br> 팀코드
					${Sitem[2]}<br> 사원번호
					${Sitem[3]}<br> 보험사 아이디
					${Sitem[4]}<br> 당직구문
					${Sitem[5]}<br> 이름
					${Sitem[6]}<br> 팀이름 --%>
					<c:choose>
						<c:when test="${mbrAuthVo_Session.mbr_pms_23 == 1  && mbrVo_Session.user_no != Sitem[2]}">					
												  		
						  		<c:choose>
						  			<c:when test="${Sitem[4] == '1' || Sitem[4] == '2'}">
						  				[전화]
						  				<!-- <img alt="전화" src="/resources/ls_img/tel_img.png"> -->				  				
						  			</c:when>
						  			<c:when test="${Sitem[4] == '3' || Sitem[4] == '4' || Sitem[4] == '5'}">
						  				[출동]
						  				<!-- <img alt="출동" src="/resources/ls_img/car_img.png"> -->
						  			</c:when>
						  		</c:choose>
						  		${Sitem[6]} ${Sitem[5]}
						  
						 </c:when> 
						 <c:otherwise>
						 					  		
						   		<c:choose>
						  			<c:when test="${Sitem[4] == '1' || Sitem[4] == '2'}">
						  				[전화]
						  				<!-- <img alt="전화" src="/resources/ls_img/tel_img.png"> -->				  				
						  			</c:when>
						  			<c:when test="${Sitem[4] == '3' || Sitem[4] == '4' || Sitem[4] == '5'}">
						  				[출동]
						  				<!-- <img alt="출동" src="/resources/ls_img/car_img.png"> -->
						  			</c:when>
						  		</c:choose>
						  		${Sitem[6]} ${Sitem[5]}
						  						 	
						 </c:otherwise>						 	
					</c:choose>  					
				</c:forEach>
			</td>					
		</tr>
		</c:forEach>	
		
	</table>

</body>
</html>