<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />

<%
    response.setHeader("Content-Disposition", "attachment; filename=site_report_"+request.getParameter("exelType")+"_"+pageContext.getAttribute("today")+".xls");
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
		<h1>개인별 현장보고서 제출현황</h1>
		<table border="1">		
	        <tr>
	        	<th rowspan="2">센터명</th>
	        	<th rowspan="2">팀명</th>
	        	<th rowspan="2">이름</th>
	        	<th rowspan="2">수임</th>
	        	<th colspan="2">제출</th>
	        	<th colspan="2">미제출</th>
	        	<th rowspan="2">초과율</th>
	        	<th rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>
				<th rowspan="2">평균처리일</th>
	        </tr>
	        <tr>
	        	<th>3영업일이내</th>
	        	<th>3영업일초과</th>
	        	<th>3영업일이내</th>
	        	<th>3영업일초과</th>
	        </tr>
			<c:forEach var="vo" items="${memberSiteResult}" varStatus="status">
			<tr>
				<td>${vo.center_name}</td>
				<td>${vo.team_name}</td>
				<td>${vo.user_name}</td>
				<td>${vo.suim_cnt}</td>
				<td>${vo.sub_3_in_cnt}</td>
				<td>${vo.sub_3_over_cnt}</td>
				<td>${vo.not_3_in_cnt}</td>
				<td>${vo.not_3_over_cnt}</td>
				<td><fmt:formatNumber value="${vo.over_per}" pattern="##.#"/> %</td>
				<td>${vo.not_30_over_cnt}</td>
				<td>${vo.end_average_cnt}</td>
				<c:set var="sum_suim_cnt" value="${sum_suim_cnt + vo.suim_cnt}"/>
				<c:set var="sum_sub_3_in_cnt" value="${sum_sub_3_in_cnt + vo.sub_3_in_cnt}"/>
				<c:set var="sum_sub_3_over_cnt" value="${sum_sub_3_over_cnt + vo.sub_3_over_cnt}"/>
				<c:set var="sum_not_3_in_cnt" value="${sum_not_3_in_cnt + vo.not_3_in_cnt}"/>
				<c:set var="sum_not_3_over_cnt" value="${sum_not_3_over_cnt + vo.not_3_over_cnt}"/>						
				<c:set var="sum_not_30_over_cnt" value="${sum_not_30_over_cnt + vo.not_30_over_cnt}"/>
				<c:set var="sum_end_average_cnt" value="${sum_end_average_cnt + vo.end_average_cnt}"/>					
            </tr>
            </c:forEach>
          	<tr>
				<th colspan="3">합계</th>
				<th>${sum_suim_cnt}</th>
				<th>${sum_sub_3_in_cnt}</th>
				<th>${sum_sub_3_over_cnt}</th>
				<th>${sum_not_3_in_cnt}</th>
				<th>${sum_not_3_over_cnt}</th>
				<th>
					<c:choose>
						<c:when test="${sum_suim_cnt == 0}">0 %</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${(sum_sub_3_over_cnt + sum_not_3_over_cnt) / sum_suim_cnt * 100}" pattern="#,###"/> %
						</c:otherwise>
					</c:choose>							
				</th>
				<th>${sum_not_30_over_cnt}</th>
				<th>
					<fmt:formatNumber value="${sum_end_average_cnt / memberSiteResult.size()}" pattern="#,###"/>
				</th>
			</tr>            	
		</table>
	</c:when>	

	<c:when test="${exelType eq 'Team'}">
		<h1>팀별 현장보고서 제출현황</h1>
		<table border="1">		
	        <tr>
	        	<th rowspan="2">센터명</th>
	        	<th rowspan="2">팀명</th>	        	
	        	<th rowspan="2">수임</th>
	        	<th colspan="2">제출</th>
	        	<th colspan="2">미제출</th>
	        	<th rowspan="2">초과율</th>
	        	<th rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>
	        	<th rowspan="2">평균처리일</th>            	
	        </tr>
	        <tr>
	        	<th>3영업일이내</th>
	        	<th>3영업일초과</th>
	        	<th>3영업일이내</th>
	        	<th>3영업일초과</th>
	        </tr>
			<c:forEach var="tm" items="${teamSiteResult}" varStatus="status">
            <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
				<td>${tm.center_name}</td>
            	<td>${tm.team_name}</td>            	
            	<td>${tm.suim_cnt}</td>
            	<td>${tm.sub_3_in_cnt}</td>
            	<td>${tm.sub_3_over_cnt}</td>
            	<td>${tm.not_3_in_cnt}</td>
            	<td>${tm.not_3_over_cnt}</td>
            	<td><fmt:formatNumber value="${tm.over_per}" pattern="##.#"/> %</td>
            	<td>${tm.not_30_over_cnt}</td>
            	<td>${tm.end_average_cnt}</td>
            	<c:set var="tm_sum_suim_cnt" value="${tm_sum_suim_cnt + tm.suim_cnt}"/>
				<c:set var="tm_sum_sub_3_in_cnt" value="${tm_sum_sub_3_in_cnt + tm.sub_3_in_cnt}"/>
				<c:set var="tm_sum_sub_3_over_cnt" value="${tm_sum_sub_3_over_cnt + tm.sub_3_over_cnt}"/>
				<c:set var="tm_sum_not_3_in_cnt" value="${tm_sum_not_3_in_cnt + tm.not_3_in_cnt}"/>
				<c:set var="tm_sum_not_3_over_cnt" value="${tm_sum_not_3_over_cnt + tm.not_3_over_cnt}"/>						
				<c:set var="tm_sum_not_30_over_cnt" value="${tm_sum_not_30_over_cnt + tm.not_30_over_cnt}"/>
				<c:set var="tm_sum_end_average_cnt" value="${tm_sum_end_average_cnt + tm.end_average_cnt}"/>					
            </tr>
            </c:forEach>
            <tr>
				<th colspan="2">합계</th>
				<th>${tm_sum_suim_cnt}</th>
				<th>${tm_sum_sub_3_in_cnt}</th>
				<th>${tm_sum_sub_3_over_cnt}</th>
				<th>${tm_sum_not_3_in_cnt}</th>
				<th>${tm_sum_not_3_over_cnt}</th>
				<th>
					<c:choose>
						<c:when test="${tm_sum_suim_cnt == 0}">0 %</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${(tm_sum_sub_3_over_cnt + tm_sum_not_3_over_cnt) / tm_sum_suim_cnt * 100}" pattern="#,###"/> %
						</c:otherwise>
					</c:choose>							
				</th>
				<th>${tm_sum_not_30_over_cnt}</th>
				<th>
					<fmt:formatNumber value="${tm_sum_end_average_cnt / teamSiteResult.size()}" pattern="#,###"/>
				</th>
			</tr>		
		</table>	
	</c:when>
	<c:when test="${exelType eq 'Center'}">
		<h1>센터별 현장보고서 제출현황</h1>
		<table border="1">		
	        <tr>
	        	<th rowspan="2">센터명</th>
	        	<th rowspan="2">수임</th>
	        	<th colspan="2">제출</th>
	        	<th colspan="2">미제출</th>
	        	<th rowspan="2">초과율</th>
	        	<th rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>            	
	        	<th rowspan="2">평균처리일</th>
	        </tr>
	        <tr>
	        	<th>3영업일이내</th>
	        	<th>3영업일초과</th>
	        	<th>3영업일이내</th>
	        	<th>3영업일초과</th>
	        </tr>
			<c:forEach var="ct" items="${centerSiteResult}" varStatus="status">
            <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
				<td>${ct.center_name}</td>            	            	
            	<td>${ct.suim_cnt}</td>
            	<td>${ctsub_3_in_cnt}</td>
            	<td>${ct.sub_3_over_cnt}</td>
            	<td>${ct.not_3_in_cnt}</td>
            	<td>${ct.not_3_over_cnt}</td>
            	<td><fmt:formatNumber value="${ct.over_per}" pattern="##.#"/> %</td>
            	<td>${ct.not_30_over_cnt}</td>
            	<td>${ct.end_average_cnt}</td>
            	<c:set var="ct_sum_suim_cnt" value="${ct_sum_suim_cnt + ct.suim_cnt}"/>
				<c:set var="ct_sum_sub_3_in_cnt" value="${ct_sum_sub_3_in_cnt + ct.sub_3_in_cnt}"/>
				<c:set var="ct_sum_sub_3_over_cnt" value="${ct_sum_sub_3_over_cnt + ct.sub_3_over_cnt}"/>
				<c:set var="ct_sum_not_3_in_cnt" value="${ct_sum_not_3_in_cnt + ct.not_3_in_cnt}"/>
				<c:set var="ct_sum_not_3_over_cnt" value="${ct_sum_not_3_over_cnt + ct.not_3_over_cnt}"/>						
				<c:set var="ct_sum_not_30_over_cnt" value="${ct_sum_not_30_over_cnt + ct.not_30_over_cnt}"/>
				<c:set var="ct_sum_end_average_cnt" value="${ct_sum_end_average_cnt + ct.end_average_cnt}"/>									
            </tr>
            </c:forEach>
            <tr>
				<th>합계</th>
				<th>${ct_sum_suim_cnt}</th>
				<th>${ct_sum_sub_3_in_cnt}</th>
				<th>${ct_sum_sub_3_over_cnt}</th>
				<th>${ct_sum_not_3_in_cnt}</th>
				<th>${ct_sum_not_3_over_cnt}</th>
				<th>
					<c:choose>
						<c:when test="${ct_sum_suim_cnt == 0}">0 %</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${(ct_sum_sub_3_over_cnt + ct_sum_not_3_over_cnt) / ct_sum_suim_cnt * 100}" pattern="#,###"/> %
						</c:otherwise>
					</c:choose>							
				</th>
				<th>${ct_sum_not_30_over_cnt}</th>
				<th>
					<fmt:formatNumber value="${ct_sum_end_average_cnt / centerSiteResult.size()}" pattern="#,###"/>
				</th>
			</tr>		
		</table>
	</c:when>
	<c:when test="${exelType eq 'Sector'}">
		<h1>부문별 현장보고서 제출현황</h1>
		<table border="1">		
	        <tr>
	        	<th rowspan="2">센터명</th>
	        	<th rowspan="2">수임</th>
	        	<th colspan="2">제출</th>
	        	<th colspan="2">미제출</th>
	        	<th rowspan="2">초과율</th>
	        	<th rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>
	        	<th rowspan="2">평균처리일</th>            	
	        </tr>
	        <tr>
	        	<th>3영업일이내</th>
	        	<th>3영업일초과</th>
	        	<th>3영업일이내</th>
	        	<th>3영업일초과</th>
	        </tr>
			<c:forEach var="se" items="${sectorSiteResult}" varStatus="status">
            <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
				<td>${se.sector_name}</td>            	            	
            	<td>${se.suim_cnt}</td>
            	<td>${se.sub_3_in_cnt}</td>
            	<td>${se.sub_3_over_cnt}</td>
            	<td>${se.not_3_in_cnt}</td>
            	<td>${se.not_3_over_cnt}</td>
            	<td><fmt:formatNumber value="${se.over_per}" pattern="##.#"/> %</td>
            	<td>${se.not_30_over_cnt}</td>
            	<td>${se.end_average_cnt}</td>
            	<c:set var="se_sum_suim_cnt" value="${se_sum_suim_cnt + se.suim_cnt}"/>
				<c:set var="se_sum_sub_3_in_cnt" value="${se_sum_sub_3_in_cnt + se.sub_3_in_cnt}"/>
				<c:set var="se_sum_sub_3_over_cnt" value="${se_sum_sub_3_over_cnt + se.sub_3_over_cnt}"/>
				<c:set var="se_sum_not_3_in_cnt" value="${se_sum_not_3_in_cnt + se.not_3_in_cnt}"/>
				<c:set var="se_sum_not_3_over_cnt" value="${se_sum_not_3_over_cnt + se.not_3_over_cnt}"/>						
				<c:set var="se_sum_not_30_over_cnt" value="${se_sum_not_30_over_cnt + se.not_30_over_cnt}"/>
				<c:set var="se_sum_end_average_cnt" value="${se_sum_end_average_cnt + se.end_average_cnt}"/>
            </tr>
            </c:forEach>
            <tr>
				<th>합계</th>
				<th>${se_sum_suim_cnt}</th>
				<th>${se_sum_sub_3_in_cnt}</th>
				<th>${se_sum_sub_3_over_cnt}</th>
				<th>${se_sum_not_3_in_cnt}</th>
				<th>${se_sum_not_3_over_cnt}</th>
				<th>
					<c:choose>
						<c:when test="${se_sum_suim_cnt == 0}">0 %</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${(se_sum_sub_3_over_cnt + se_sum_not_3_over_cnt) / se_sum_suim_cnt * 100}" pattern="#,###"/> %
						</c:otherwise>
					</c:choose>							
				</th>
				<th>${se_sum_not_30_over_cnt}</th>
				<th>
					<fmt:formatNumber value="${se_sum_end_average_cnt / sectorSiteResult.size()}" pattern="#,###"/>
				</th>
			</tr>
		</table>
	</c:when>
</c:choose>
</body>
</html>