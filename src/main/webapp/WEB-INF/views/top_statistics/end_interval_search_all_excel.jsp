<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />

<%
    response.setHeader("Content-Disposition", "attachment; filename=end_interval_"+request.getParameter("exelType")+"_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<c:choose>
	<c:when test="${exelType eq 'Member'}">
		<h1>개인별 평균처리일 현황</h1>		
        <table border="1">        
            <tr>
                <th>센터명</th>
            	<th>팀명</th>
            	<th>이름</th>
            	<th>평균처리일</th>
            	<th>종결건수</th>
            	<!-- <th>전체처리일</th> -->
            </tr>
            <c:forEach var="member" items="${memberList}" varStatus="status">            	
                <tr>
                	<td width="100px">${member.center_name}</td>
                	<td width="100px">${member.team_name}</td>
                	<td width="100px">${member.user_name}</td>
                	<td width="100px"><font color="blue">${member.end_average_cnt}</font></td>
                	<td width="100px">${member.all_end_total_cnt}</td>
                	<%-- <td width="100px">${member.all_total_period_date}</td> --%>
                	<c:set var="sum_end_average_cnt" value="${sum_end_average_cnt + member.end_average_cnt}"/>
                	<c:set var="sum_all_end_total_cnt" value="${sum_all_end_total_cnt + member.all_end_total_cnt}"/>
                	<c:set var="sum_all_total_period_date" value="${sum_all_total_period_date + member.all_total_period_date}"/>                	                	
                </tr>
			</c:forEach>
			<tr>
				<th colspan="3">합계</th>
				<c:choose>
					<c:when test="${member.all_end_total_cnt == 0}">
						<th>0</th>
						<th>0</th>
						<!-- <th>0</th> -->
					</c:when>
					<c:otherwise>
						<th>
							<font color="blue">
								<fmt:formatNumber value="${sum_end_average_cnt / memberList.size()}" pattern="#,###"/>
							</font>
						</th>
						<th>${sum_all_end_total_cnt }</th>
						<%-- <th>${sum_all_total_period_date}</th> --%>
					</c:otherwise>
				</c:choose>				
			</tr>
        </table>    
	</c:when>	

	<c:when test="${exelType eq 'Team'}">
		<h1>팀별 평균처리일 현황</h1>		
        <table border="1">
            <tr>
                <th>센터명</th>
            	<th>팀명</th>            	
            	<th>평균처리일</th>
            	<th>종결건수</th>
            	<!-- <th>전체처리일</th> -->
            </tr>
            <c:forEach var="team" items="${teamList}" varStatus="status">            	
                <tr>
                	<td width="100px">${team.center_name}</td>
                	<td width="100px">${team.team_name}</td>                	
                	<td width="100px"><font color="blue">${team.end_average_cnt}</font></td>
                	<td width="100px">${team.all_end_total_cnt}</td>
                	<%-- <td width="100px">${team.all_total_period_date}</td> --%>
                	<c:set var="tm_sum_end_average_cnt" value="${tm_sum_end_average_cnt + team.end_average_cnt}"/>
                	<c:set var="tm_sum_all_end_total_cnt" value="${tm_sum_all_end_total_cnt + team.all_end_total_cnt}"/>
                	<c:set var="tm_sum_all_total_period_date" value="${tm_sum_all_total_period_date + team.all_total_period_date}"/>                	                	
                </tr>
			</c:forEach>
			<tr>
				<th colspan="2">합계</th>
				<c:choose>
					<c:when test="${team.all_end_total_cnt == 0}">
						<th>0</th>
						<th>0</th>
						<th>0</th>
					</c:when>
					<c:otherwise>
						<th>
							<font color="blue">
								<fmt:formatNumber value="${tm_sum_end_average_cnt / teamList.size()}" pattern="#,###"/>
							</font>
						</th>
						<th>${tm_sum_all_end_total_cnt }</th>
						<%-- <th>${tm_sum_all_total_period_date}</th> --%>
					</c:otherwise>
				</c:choose>				
			</tr>    
        </table>    	
	</c:when>
	<c:when test="${exelType eq 'Center'}">
		<h1>센터별 평균처리일 현황</h1>		
        <table border="1">
            <tr>
                <th>센터명</th>            	            	
            	<th>평균처리일</th>
            	<th>종결건수</th>
            	<!-- <th>전체처리일</th> -->
            </tr>
            <c:forEach var="center" items="${centerList}" varStatus="status">            	
                <tr>
                	<td width="100px">${center.center_name}</td>                	                	
                	<td width="100px"><font color="blue">${center.end_average_cnt}</font></td>
                	<td width="100px">${center.all_end_total_cnt}</td>
                	<%-- <td width="100px">${center.all_total_period_date}</td> --%>
                	<c:set var="ct_sum_end_average_cnt" value="${ct_sum_end_average_cnt + center.end_average_cnt}"/>
                	<c:set var="ct_sum_all_end_total_cnt" value="${ct_sum_all_end_total_cnt + center.all_end_total_cnt}"/>
                	<c:set var="ct_sum_all_total_period_date" value="${ct_sum_all_total_period_date + center.all_total_period_date}"/>                	                	
                </tr>
			</c:forEach>
			<tr>
				<th>합계</th>
				<c:choose>
					<c:when test="${center.all_end_total_cnt == 0}">
						<th>0</th>
						<th>0</th>
						<!-- <th>0</th> -->
					</c:when>
					<c:otherwise>
						<th>
							<font color="blue">
								<fmt:formatNumber value="${ct_sum_end_average_cnt / centerList.size()}" pattern="#,###"/>
							</font>
						</th>
						<th>${ct_sum_all_end_total_cnt }</th>
						<%-- <th>${ct_sum_all_total_period_date}</th> --%>
					</c:otherwise>
				</c:choose>				
			</tr>    
        </table>    
	</c:when>
	<c:when test="${exelType eq 'Sector'}">
		<h1>부문별 평균처리일 현황</h1>		
        <table border="1">
            <tr>
                <th>부문명</th>            	            	
            	<th>평균처리일</th>
            	<th>종결건수</th>
            	<!-- <th>전체처리일</th> -->
            </tr>
            <c:forEach var="sector" items="${sectorList}" varStatus="status">            	
                <tr>
                	<td width="100px">${sector.sector_name}</td>                	                	
                	<td width="100px"><font color="blue">${sector.end_average_cnt}</font></td>
                	<td width="100px">${sector.all_end_total_cnt}</td>
                	<%-- <td width="100px">${sector.all_total_period_date}</td> --%>
                	<c:set var="se_sum_end_average_cnt" value="${se_sum_end_average_cnt + sector.end_average_cnt}"/>
                	<c:set var="se_sum_all_end_total_cnt" value="${se_sum_all_end_total_cnt + sector.all_end_total_cnt}"/>
                	<c:set var="se_sum_all_total_period_date" value="${se_sum_all_total_period_date + sector.all_total_period_date}"/>                	                	
                </tr>
			</c:forEach>
			<tr>
				<th>합계</th>
				<c:choose>
					<c:when test="${sector.all_end_total_cnt == 0}">
						<th>0</th>
						<th>0</th>
						<!-- <th>0</th> -->
					</c:when>
					<c:otherwise>
						<th>
							<font color="blue">
								<fmt:formatNumber value="${se_sum_end_average_cnt / sectorList.size()}" pattern="#,###"/>
							</font>
						</th>
						<th>${se_sum_all_end_total_cnt }</th>
						<%-- <th>${se_sum_all_total_period_date}</th> --%>
					</c:otherwise>
				</c:choose>				
			</tr>
        </table>    
	</c:when>
</c:choose>
</body>
</html>