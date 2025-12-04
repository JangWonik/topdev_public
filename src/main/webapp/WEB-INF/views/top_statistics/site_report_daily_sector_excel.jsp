<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=site_sector_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<h1>일자별 현장보고서 초과율 (부문)</h1>
<h2>기준일자 : ${nowVO.dayBefore1}</h2>
<div class="tableStyle2">
    <div style="background: #e7ecf1;">
        <table border="1">
            <tr>
                <th width="160px">부문명</th>                
                <th width="30px" title="${nowVO.dayBefore30}">${nowVO.dayBefore30.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore29}">${nowVO.dayBefore29.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore28}">${nowVO.dayBefore28.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore27}">${nowVO.dayBefore27.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore26}">${nowVO.dayBefore26.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore25}">${nowVO.dayBefore25.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore24}">${nowVO.dayBefore24.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore23}">${nowVO.dayBefore23.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore22}">${nowVO.dayBefore22.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore21}">${nowVO.dayBefore21.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore20}">${nowVO.dayBefore20.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore19}">${nowVO.dayBefore19.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore18}">${nowVO.dayBefore18.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore17}">${nowVO.dayBefore17.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore16}">${nowVO.dayBefore16.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore15}">${nowVO.dayBefore15.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore14}">${nowVO.dayBefore14.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore13}">${nowVO.dayBefore13.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore12}">${nowVO.dayBefore12.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore11}">${nowVO.dayBefore11.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore10}">${nowVO.dayBefore10.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore9}">${nowVO.dayBefore9.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore8}">${nowVO.dayBefore8.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore7}">${nowVO.dayBefore7.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore6}">${nowVO.dayBefore6.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore5}">${nowVO.dayBefore5.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore4}">${nowVO.dayBefore4.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore3}">${nowVO.dayBefore3.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore2}">${nowVO.dayBefore2.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore1}">${nowVO.dayBefore1.substring(8,10)}</th>                                
            </tr>            
        </table>
    </div>
    <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
        <table border="1">            
            <c:forEach var="sector" items="${sectorList}" varStatus="status">            	
                <tr>
                	<td width="160px">${sector.sector_name}</td>                	
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_30}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_29}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_28}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_27}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_26}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_25}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_24}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_23}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_22}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_21}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_20}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_19}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_18}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_17}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_16}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_15}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_14}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_13}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_12}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_11}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_10}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_9}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_8}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_7}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_6}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_5}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_4}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_3}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_2}" type="number"/></td>
                	<td width="30px"><fmt:formatNumber value="${sector.over_per_1}" type="number"/></td>                	
                </tr>
			</c:forEach>    
        </table>
    </div>
</div>
</body>
</html>
