
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1" />
<title>Freeze Header Demo Page</title>
<style>

body {
    font-family: "Lucida Grande", Helvetica, Verdana, sans-serif;
    font-size: 10pt;
    line-height: 14pt;
}

h1 {
    line-height: 30px;
}

.data-table, .data-table td, .data-table th {
    border-color: black;
    border-style: solid;
}

.data-table {
    border-width: 0 0 0px 0px;  
    border-spacing: 0;
    border-collapse: collapse; 
    margin: 0;
}

.data-table td, .data-table th {
    margin: 0px;
    padding: 6px;
    border-width: 1px;
    vertical-align: top;
}

.data-table th {
    background-color: gold; 
}


</style>


    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
    <script src="./resources/jquery/jquery.min_1_12.js"></script>

    <script src="./resources/jquery/jquery.browser.js"></script>
    <script src="./resources/jquery/jquery.freezeheader.js"></script>
    
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>



<script type="text/javascript">

$(document).ready(function(){
	$("table").freezeHeader({ top: true, left: true });
});

</script>

</head>
<body>

<h1>Freeze Header Demo Page</h1>

<p><a href="http://brentmuir.com/projects/freezeheader/">What is Freeze Header?</a></p>

<p>Scroll down and watch the table headers.</p>

<p>Shrink the window and try scrolling to the right.</p>

<!-- NEW 기본통계 - 팀별 평균 통계 - 1종 + 4종  -->
<div class="tableStyle2" id="area_excel">
        <table class="freezeTable" cellpadding="0" cellspacing="0" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
            <colgroup>
<%--                 <col style="width: 170px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 69px;"> --%>
<%--                 <col style="width: 78px;"> --%>
<%--                 <col style="width: 78px;"> --%>
<%--                 <col style="width: 111px;"> --%>
<%--                 <col style="width: 111px;"> --%>
<%--                 <col style="width: 111px;"> --%>
<%--                 <col style="width: 111px;"> --%>
<%--                 <col style="width: 111px;"> --%>
<%--                 <col style="width: 111px;"> --%>
<%--                 <col style="width: 111px;"> --%>
<%--                 <col style="width: 119px;"> --%>
            </colgroup>
            <thead style="background: #e7ecf1;">
	            <tr>
	                <th rowspan="3" class="border-right"><span style="color: black;"><b>팀</b></span></th>
	                <th colspan="2" class="border-right">수임현황</th>
	                <th colspan="2" class="border-right">종결현황</th>
	                <th rowspan="2" colspan="2" class="border-right border-left" >처리율</th>
	                <th colspan="3" class="border-right">미결현황</th>
	                <th colspan="2" class="border-right">종결현황</th>
	                <th colspan="7" class="border-right"><b>공동수행 반영</b></th>
	                <th rowspan="3" class="border-left">미수금</th>
	            </tr>
	            <tr>
	                <th colspan="2" class="border-right">절대건수</th>
	                <th colspan="2" class="border-right">절대건수</th>
	                <th colspan="3" class="border-right">절대건수</th>
	                <th colspan="2" class="border-right">평가건수</th>
	                <th colspan="7" class="border-right">인보이스 현황<span style="color: red">(당월)</span></th>
	            </tr>
	            <tr>
	                <th>당월</th>
	                <th class="border-right">년누계</th>
	                <th>당월</th>
	                <th class="border-right">년누계</th>
	                <th>당월</th>
	                <th class="border-right">년누계</th>
	                <th>전월</th>
	                <th>현재</th>
	                <th class="border-right">30,15</th>
	                <th>당월</th>
	                <th class="border-right">년누계</th>
	                <th>기본료</th>
	                <th>일비</th>
	                <th>소계(기본+일)</th>
	                <th>교통비</th>
	                <th>자문료</th>
	                <th>기타</th>
	                <th class="border-right">합계</th>
	            </tr>
            </thead>
            
            <tbody>
            <c:forEach  var="item" items="${teamList1}" varStatus="status">
                <tr>
                    <td class="left border-right">
                        <c:choose>
                            <c:when test="${srchArg.excelYN == 'Y'}">
                                ${item.teamName}
                            </c:when>
                            <c:otherwise>
                                <a href="#noloc" onclick="fnMemberList('${item.teamId}','1');">${item.teamName}</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="right"><fmt:formatNumber value="${item.receiveMonthCnt}" pattern="#,###"/></td>
                    <td class="right border-right"><fmt:formatNumber value="${item.receiveYearCnt}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.closeMonthCnt}" pattern="#,###"/></td>
                    <td class="right border-right"><fmt:formatNumber value="${item.closeYearCnt}" pattern="#,###"/></td>
                    <td class="right">
                        <fmt:formatNumber var="itemCloseMonthCnt" value="${item.closeMonthCnt}" pattern="#.###"/>
                        <fmt:formatNumber var="itemReceiveMonthCnt" value="${item.receiveMonthCnt}" pattern="#.###"/>
                        <fmt:formatNumber value="${item.receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
                    </td>
                    <td class="right border-right">
                        <fmt:formatNumber var="itemCloseYearCnt" value="${item.closeYearCnt}" pattern="#.###"/>
                        <fmt:formatNumber var="itemReceiveYearCnt" value="${item.receiveYearCnt}" pattern="#.###"/>
                        <fmt:formatNumber value="${item.receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
                    </td>
                    <!-- 건수 -->
                    <td class="right"><fmt:formatNumber value="${item.pendingMonthlyCnt}" pattern="#,###"/></td>
                    <!-- 누계 -->
                    <td class="right"><fmt:formatNumber value="${item.pendingCurrentCnt}" pattern="#,###"/></td>
                    
                    <td class="right border-right">
                        <fmt:formatNumber var="itemPendingCurrentCnt" value="${item.pendingCurrentCnt}" pattern="#.###"/>
                        <fmt:formatNumber var="itemPendingOver45Cnt" value="${item.pendingOver45Cnt}" pattern="#.###"/>
                        <fmt:formatNumber value="${item.pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
                    </td>
                    <td class="right"><fmt:formatNumber value="${item.closeMonthEa}" pattern="#,###.###"/></td>
                    <td class="right border-right"><fmt:formatNumber value="${item.closeYearEa}" pattern="#,###.###"/></td>
                    
                    <td class="right"><fmt:formatNumber value="${item.amtBasic + item.shareAmtBasic}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.amtDaily + item.shareAmtDaily}" pattern="#,###"/></td>
                    <td class="right">
                    	<c:set var="subTotal" value="${item.amtBasic + item.amtDaily + item.shareAmtBasic + item.shareAmtDaily}"/>
                    	<fmt:formatNumber value="${subTotal}" pattern="#,###"/>
                   	</td>
                   	
                    <td class="right"><fmt:formatNumber value="${item.amtTraffic + item.shareAmtTraffic}" pattern="#,###"/></td>
                    
                    <td class="right"><fmt:formatNumber value="${item.amtCounsel + item.shareAmtCounsel}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.amtEtc + item.shareAmtEtc}" pattern="#,###"/></td>
                    
                    <td class="right border-right">
                    	<c:set var="rowTotal" value="${subTotal + item.amtTraffic + item.shareAmtTraffic + item.amtCounsel + item.shareAmtCounsel + item.amtEtc + item.shareAmtEtc}" />
                    	<fmt:formatNumber value="${rowTotal}" pattern="#,###"/>
                   	</td>
                    <td class="right"><span style="color:red;"><fmt:formatNumber value="${item.outAmt}" pattern="#,###"/></span></td>
                </tr>
                <c:set var="sub1_receiveMonthCnt" value="${sub1_receiveMonthCnt + item.receiveMonthCnt}"/>
                <c:set var="sub1_receiveYearCnt" value="${sub1_receiveYearCnt + item.receiveYearCnt}"/>
                <c:set var="sub1_closeMonthCnt" value="${sub1_closeMonthCnt + item.closeMonthCnt}"/>
                <c:set var="sub1_closeYearCnt" value="${sub1_closeYearCnt + item.closeYearCnt}"/>
                <c:set var="sub1_pendingCurrentCnt" value="${sub1_pendingCurrentCnt + item.pendingCurrentCnt}"/>
                <c:set var="sub1_pendingOver45Cnt" value="${sub1_pendingOver45Cnt + item.pendingOver45Cnt}"/>
                <c:set var="sub1_pendingMonthlyCnt" value="${sub1_pendingMonthlyCnt + item.pendingMonthlyCnt}"/>
                <c:set var="sub1_closeMonthEa" value="${sub1_closeMonthEa + item.closeMonthEa}"/>
                <c:set var="sub1_closeYearEa" value="${sub1_closeYearEa + item.closeYearEa}"/>
                
                <c:set var="sub1_amtBasic" value="${sub1_amtBasic + item.amtBasic + item.shareAmtBasic}"/>
                <c:set var="sub1_amtDaily" value="${sub1_amtDaily + item.amtDaily + item.shareAmtDaily}"/>
                <c:set var="sub1_amtTraffic" value="${sub1_amtTraffic + item.amtTraffic + item.shareAmtTraffic}"/>
                <c:set var="sub1_amtCounsel" value="${sub1_amtCounsel + item.amtCounsel + item.shareAmtCounsel}"/>
                <c:set var="sub1_amtEtc" value="${sub1_amtEtc + item.amtEtc + item.shareAmtEtc}"/>
                <c:set var="sub1_subTotal" value="${sub1_subTotal + subTotal}" />
                <c:set var="sub1_rowTotal" value="${sub1_rowTotal + rowTotal}" />
                
                <c:set var="sub1_amtTotal" value="${sub1_amtTotal + item.amtTotal}"/>
                <c:set var="sub1_outAmt" value="${sub1_outAmt + item.outAmt}"/>
            </c:forEach>
            <tr>
                <th class="border-right">1종합계</th>
                <th class="right"><fmt:formatNumber value="${sub1_receiveMonthCnt}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub1_receiveYearCnt}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_closeMonthCnt}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub1_closeYearCnt}" pattern="#,###"/></th>
                <th class="right">
                    <fmt:formatNumber var="itemCloseMonthCnt" value="${sub1_closeMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveMonthCnt" value="${sub1_receiveMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${sub1_receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
                </th>
                <th class="right border-right">
                    <fmt:formatNumber var="itemCloseYearCnt" value="${sub1_closeYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveYearCnt" value="${sub1_receiveYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${sub1_receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
                </th>
                <th class="right"><fmt:formatNumber value="${sub1_pendingMonthlyCnt}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_pendingCurrentCnt}" pattern="#,###"/></th>
                
                <th class="right border-right">
                    <fmt:formatNumber var="itemPendingCurrentCnt" value="${sub1_pendingCurrentCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemPendingOver45Cnt" value="${sub1_pendingOver45Cnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${sub1_pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
                </th>
                <th class="right"><fmt:formatNumber value="${sub1_closeMonthEa}" pattern="#,###.###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub1_closeYearEa}" pattern="#,###.###"/></th>
                
                <th class="right"><fmt:formatNumber value="${sub1_amtBasic}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtDaily}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_subTotal}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtTraffic}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtCounsel}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtEtc}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub1_rowTotal}" pattern="#,###"/></th>
                <th class="right">
                    <span style="color:red;"><fmt:formatNumber value="${sub1_outAmt}" pattern="#,###"/></span>
                </th>
            </tr>
            <%-- 4종 시작 --%>
            <c:forEach  var="item" items="${teamList4}" varStatus="status">
                <tr>
                    <td class="left border-right">
                        <c:choose>
                            <c:when test="${srchArg.excelYN == 'Y'}">
                                ${item.teamName}
                            </c:when>
                            <c:otherwise>
                                <a href="#noloc" onclick="fnMemberList('${item.teamId}','4');">${item.teamName}</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="right"><fmt:formatNumber value="${item.receiveMonthCnt}" pattern="#,###"/></td>
                    <td class="right border-right"><fmt:formatNumber value="${item.receiveYearCnt}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.closeMonthCnt}" pattern="#,###"/></td>
                    <td class="right border-right"><fmt:formatNumber value="${item.closeYearCnt}" pattern="#,###"/></td>
                    <td class="right">
                        <fmt:formatNumber var="itemCloseMonthCnt" value="${item.closeMonthCnt}" pattern="#.###"/>
                        <fmt:formatNumber var="itemReceiveMonthCnt" value="${item.receiveMonthCnt}" pattern="#.###"/>
                        <fmt:formatNumber value="${item.receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
                    </td>
                    <td class="right border-right">
                        <fmt:formatNumber var="itemCloseYearCnt" value="${item.closeYearCnt}" pattern="#.###"/>
                        <fmt:formatNumber var="itemReceiveYearCnt" value="${item.receiveYearCnt}" pattern="#.###"/>
                        <fmt:formatNumber value="${item.receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
                    </td>
                    
                    <td class="right"><fmt:formatNumber value="${item.pendingMonthlyCnt}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.pendingCurrentCnt}" pattern="#,###"/></td>
                    <td class="right border-right">
                        <fmt:formatNumber var="itemPendingCurrentCnt" value="${item.pendingCurrentCnt}" pattern="#.###"/>
                        <fmt:formatNumber var="itemPendingOver45Cnt" value="${item.pendingOver45Cnt}" pattern="#.###"/>
                        <fmt:formatNumber value="${item.pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
                    </td>
                    <td class="right"><fmt:formatNumber value="${item.closeMonthEa}" pattern="#,###.###"/></td>
                    <td class="right border-right"><fmt:formatNumber value="${item.closeYearEa}" pattern="#,###.###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.amtBasic}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.amtDaily}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.amtBasic + item.amtDaily}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.amtTraffic}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.amtCounsel}" pattern="#,###"/></td>
                    <td class="right"><fmt:formatNumber value="${item.amtEtc}" pattern="#,###"/></td>
                    <td class="right border-right"><fmt:formatNumber value="${item.amtTotal}" pattern="#,###"/></td>
                    <td class="right"><span style="color:red;"><fmt:formatNumber value="${item.outAmt}" pattern="#,###"/></span></td>
                </tr>
                <c:set var="sub2_receiveMonthCnt" value="${sub2_receiveMonthCnt + item.receiveMonthCnt}"/>
                <c:set var="sub2_receiveYearCnt" value="${sub2_receiveYearCnt + item.receiveYearCnt}"/>
                <c:set var="sub2_closeMonthCnt" value="${sub2_closeMonthCnt + item.closeMonthCnt}"/>
                <c:set var="sub2_closeYearCnt" value="${sub2_closeYearCnt + item.closeYearCnt}"/>
                <c:set var="sub2_pendingCurrentCnt" value="${sub2_pendingCurrentCnt + item.pendingCurrentCnt}"/>
                <c:set var="sub2_pendingOver45Cnt" value="${sub2_pendingOver45Cnt + item.pendingOver45Cnt}"/>
                <c:set var="sub2_pendingMonthlyCnt" value="${sub2_pendingMonthlyCnt + item.pendingMonthlyCnt}"/>
                <c:set var="sub2_closeMonthEa" value="${sub2_closeMonthEa + item.closeMonthEa}"/>
                <c:set var="sub2_closeYearEa" value="${sub2_closeYearEa + item.closeYearEa}"/>
                <c:set var="sub2_amtBasic" value="${sub2_amtBasic + item.amtBasic}"/>
                <c:set var="sub2_amtDaily" value="${sub2_amtDaily + item.amtDaily}"/>
                <c:set var="sub2_amtTraffic" value="${sub2_amtTraffic + item.amtTraffic}"/>
                <c:set var="sub2_amtCounsel" value="${sub2_amtCounsel + item.amtCounsel}"/>
                <c:set var="sub2_amtEtc" value="${sub2_amtEtc + item.amtEtc}"/>
                <c:set var="sub2_amtTotal" value="${sub2_amtTotal + item.amtTotal}"/>
                <c:set var="sub2_outAmt" value="${sub2_outAmt + item.outAmt}"/>
            </c:forEach>
            <tr>
                <th class="border-right">4종합계</th>
                <th class="right"><fmt:formatNumber value="${sub2_receiveMonthCnt}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub2_receiveYearCnt}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub2_closeMonthCnt}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub2_closeYearCnt}" pattern="#,###"/></th>
                <th class="right">
                    <fmt:formatNumber var="itemCloseMonthCnt" value="${sub2_closeMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveMonthCnt" value="${sub2_receiveMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${sub2_receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
                </th>
                <th class="right border-right">
                    <fmt:formatNumber var="itemCloseYearCnt" value="${sub2_closeYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveYearCnt" value="${sub2_receiveYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${sub2_receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
                </th>
                
                <th class="right"><fmt:formatNumber value="${sub2_pendingMonthlyCnt}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub2_pendingCurrentCnt}" pattern="#,###"/></th>
                
                <th class="right border-right">
                    <fmt:formatNumber var="itemPendingCurrentCnt" value="${sub2_pendingCurrentCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemPendingOver45Cnt" value="${sub2_pendingOver45Cnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${sub2_pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
                </th>
                <th class="right"><fmt:formatNumber value="${sub2_closeMonthEa}" pattern="#,###.###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub2_closeYearEa}" pattern="#,###.###"/></th>
                <th class="right"><fmt:formatNumber value="${sub2_amtBasic}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub2_amtDaily}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub2_amtBasic + sub2_amtDaily}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub2_amtTraffic}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub2_amtCounsel}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub2_amtEtc}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub2_amtTotal}" pattern="#,###"/></th>
                <th class="right">
                    <span style="color:red;"><fmt:formatNumber value="${sub2_outAmt}" pattern="#,###"/></span>
                </th>
            </tr>
            <tr>
                <th class="border-right">합계</th>
                <th class="right"><fmt:formatNumber value="${sub1_receiveMonthCnt + sub2_receiveMonthCnt}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub1_receiveYearCnt + sub2_receiveYearCnt}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_closeMonthCnt + sub2_closeMonthCnt}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub1_closeYearCnt + sub2_closeYearCnt}" pattern="#,###"/></th>
                <th class="right">
                    <fmt:formatNumber var="itemCloseMonthCnt" value="${sub1_closeMonthCnt + sub2_closeMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveMonthCnt" value="${sub1_receiveMonthCnt + sub2_receiveMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${(sub1_receiveMonthCnt + sub2_receiveMonthCnt) == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
                </th>
                <th class="right border-right">
                    <fmt:formatNumber var="itemCloseYearCnt" value="${sub1_closeYearCnt + sub2_closeYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveYearCnt" value="${sub1_receiveYearCnt + sub2_receiveYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${(sub1_receiveYearCnt + sub2_receiveYearCnt) == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
                </th>
                
                <th class="right"><fmt:formatNumber value="${sub1_pendingMonthlyCnt + sub2_pendingMonthlyCnt}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_pendingCurrentCnt + sub2_pendingCurrentCnt}" pattern="#,###"/></th>
                
                <th class="right border-right">
                    <fmt:formatNumber var="itemPendingCurrentCnt" value="${sub1_pendingCurrentCnt + sub2_pendingCurrentCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemPendingOver45Cnt" value="${sub1_pendingOver45Cnt + sub2_pendingOver45Cnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${(sub1_pendingCurrentCnt + sub2_pendingCurrentCnt) == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
                </th>
                
                <th class="right"><fmt:formatNumber value="${sub1_closeMonthEa + sub2_closeMonthEa}" pattern="#,###.###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub1_closeYearEa + sub2_closeYearEa}" pattern="#,###.###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtBasic + sub2_amtBasic}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtDaily + sub2_amtDaily}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtBasic + sub2_amtBasic + sub1_amtDaily + sub2_amtDaily}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtTraffic + sub2_amtTraffic}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtCounsel + sub2_amtCounsel}" pattern="#,###"/></th>
                <th class="right"><fmt:formatNumber value="${sub1_amtEtc + sub2_amtEtc}" pattern="#,###"/></th>
                <th class="right border-right"><fmt:formatNumber value="${sub1_amtTotal + sub2_amtTotal}" pattern="#,###"/></th>
                <th class="right">
                    <span style="color:red;"><fmt:formatNumber value="${sub1_outAmt + sub2_outAmt}" pattern="#,###"/></span>
                </th>
            </tr>
            
        </table>

</div>

</body>
</html>
