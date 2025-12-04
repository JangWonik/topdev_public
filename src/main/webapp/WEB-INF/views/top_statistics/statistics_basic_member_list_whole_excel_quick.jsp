<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    //String fileName = (String)pageContext.getAttribute("subject");

    response.setHeader("Content-Disposition", "attachment; filename=statistics_member_whole_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<h1>팀기준 개인별 통계</h1>
<table cellpadding="0" cellspacing="0" width="1120" align="center" border="1">
    <colgroup>
        <col width="60">
        <col width="60">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
    </colgroup>
    <tr>
        <th rowspan="4"><span style="color: black;"><b>팀구분</b></span></th>
        <th rowspan="4"><span style="color: black;"><b>이름</b></span></th>
        <th colspan="2">수임현황</th>
        <th colspan="2">종결현황</th>
        <th colspan="2" rowspan="2">처리율(%)</th>
        <th colspan="3">미결현황</th>        
        <th colspan="15"><b>공동수행 반영</b></th>
    </tr>
    <tr>
        <th colspan="2">절대건수</th>
        <th colspan="2">절대건수</th>
        <th colspan="3">절대건수</th>        
        <th colspan="15">인보이스 현황<span style="color: red">(당월)</span></th>
    </tr>
    <tr>
        <th rowspan="2">당월</th>
        <th rowspan="2">년누계</th>
        <th rowspan="2">당월</th>
        <th rowspan="2">년누계</th>
        <th rowspan="2">당월</th>
        <th rowspan="2">년누계</th>
        
        <th rowspan="2">전월</th>
        <th rowspan="2">현재</th>
        <th rowspan="2">30,15</th>        
		<th colspan="3">공동수행 반영 전</th>
		<th colspan="3">공동수행</th>
		<th colspan="5">공동수행 반영 후</th>		
		<th rowspan="2">자문료</th>
        <th rowspan="2">기타</th>
        <th rowspan="2">합계</th>
		<th rowspan="2">미수금</th>
	</tr>
	<tr>
        <th>기본료</th>
        <th>일비</th>
        <th>교통비</th>
        
        <th>기본료</th>
        <th>일비</th>
        <th>교통비</th>
        
        <th>기본료(누계)</th>
        <th>기본료</th>
        <th>일비</th>
        <th>기본료+일비</th>
        <th>교통비</th>
    </tr>
    
    <c:forEach  var="itemList" items="${teamExcelList}" varStatus="excelStatus">
        <c:set var="itemTeamList" value="${itemList.teamList}"/>
        <c:set var="teamName" value="${teamList[excelStatus.index].teamName}"/>
        
	    <c:set var="sub1_receiveMonthCnt" value="0"/>
	    <c:set var="sub1_receiveYearCnt" value="0"/>
	    <c:set var="sub1_closeMonthCnt" value="0"/>
	    <c:set var="sub1_closeYearCnt" value="0"/>
	    
	    <c:set var="sub1_pendingCurrentCnt" value="0"/>
	    <c:set var="sub1_pendingOver45Cnt" value="0"/>
	    <c:set var="sub1_pendingMonthlyCnt" value="0"/>
	    	    
	    <c:set var="sub1_amtBasic" value="0"/>
	    <c:set var="sub1_amtDaily" value="0"/>
	    <c:set var="sub1_amtTraffic" value="0"/>
	    
	    <c:set var="sub1_shareAmtBasic" value="0"/>
	    <c:set var="sub1_shareAmtDaily" value="0"/>
	    <c:set var="sub1_shareAmtTraffic" value="0"/>
	    
	    <c:set var="sub1_shareSumYearAmtBasic" value="0"/>
	    <c:set var="sub1_shareSumAmtBasic" value="0"/>
	    <c:set var="sub1_shareSumAmtDaily" value="0"/>
	    
	    <c:set var="sub1_shareSumAmtBasicDaily" value="0"/>
	    <c:set var="sub1_shareSumAmtTraffic" value="0"/>
	    <c:set var="sub1_amtCounsel" value="0"/>
	    <c:set var="sub1_amtEtc" value="0"/>
	    
	    <c:set var="sub1_shareSumAmtTotal" value="0"/>
	    <c:set var="sub1_outAmt" value="0"/>
	    <c:set var="sub1_rowTotal" value="0"/>


        <c:set var="listCnt" value="${itemTeamList.size()}"/>
        <c:forEach  var="item" items="${itemTeamList}" varStatus="status">
            <tr>
                <c:if test="${status.index == 0}">
                <td rowspan="${listCnt + 1}">${teamName}</td>
                </c:if>
                <td>${item.userName}</td>
                <td class="right"><fmt:formatNumber value="${item.receiveMonthCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.receiveYearCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.closeMonthCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.closeYearCnt}" pattern="#,###"/></td>
                <td class="right">
                    <fmt:formatNumber var="itemCloseMonthCnt" value="${item.closeMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveMonthCnt" value="${item.receiveMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${item.receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
                </td>
                <td class="right">
                    <fmt:formatNumber var="itemCloseYearCnt" value="${item.closeYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveYearCnt" value="${item.receiveYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${item.receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
                </td>
                <td class="right"><fmt:formatNumber value="${item.pendingMonthlyCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.pendingCurrentCnt}" pattern="#,###"/></td>
                <td class="right">
                    <fmt:formatNumber var="itemPendingCurrentCnt" value="${item.pendingCurrentCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemPendingOver45Cnt" value="${item.pendingOver45Cnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${item.pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
                </td>                
                
                <td class="right"><fmt:formatNumber value="${item.amtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtTraffic}" pattern="#,###"/></td>
                
                <td class="right"><fmt:formatNumber value="${item.shareAmtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.shareAmtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.shareAmtTraffic}" pattern="#,###"/></td>

				<td class="right"><fmt:formatNumber value="${item.yearAmtBasic + item.yearShareAmtBasic}" pattern="#,###"/></td><!-- 기본료 누계(공동수행 반영)  -->
				<td class="right"><fmt:formatNumber value="${item.amtBasic + item.shareAmtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtDaily + item.shareAmtDaily}" pattern="#,###"/></td>
                <td class="right">
                    <c:set var="subTotal" value="${item.amtBasic + item.amtDaily + item.shareAmtBasic + item.shareAmtDaily}"/>
                    <fmt:formatNumber value="${subTotal}" pattern="#,###"/>
                </td>
                <td class="right"><fmt:formatNumber value="${item.amtTraffic + item.shareAmtTraffic}" pattern="#,###"/></td>

                <td class="right"><fmt:formatNumber value="${item.amtCounsel + item.shareAmtCounsel}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtEtc + item.shareAmtEtc}" pattern="#,###"/></td>
                <td class="right">
                    <c:set var="rowTotal" value="${subTotal + item.amtTraffic + item.shareAmtTraffic + item.amtCounsel + item.shareAmtCounsel + item.amtEtc + item.shareAmtEtc}"/>
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
	
	        <c:set var="sub1_amtBasic" value="${sub1_amtBasic + item.amtBasic}"/>
	        <c:set var="sub1_amtDaily" value="${sub1_amtDaily + item.amtDaily}"/>
	        <c:set var="sub1_amtTraffic" value="${sub1_amtTraffic + item.amtTraffic}"/>
	        
	        <c:set var="sub1_shareAmtBasic" value="${sub1_shareAmtBasic + item.shareAmtBasic}"/>
	        <c:set var="sub1_shareAmtDaily" value="${sub1_shareAmtDaily + item.shareAmtDaily}"/>
			<c:set var="sub1_shareAmtTraffic" value="${sub1_shareAmtTraffic + item.shareAmtTraffic}"/>
	
			<c:set var="sub1_shareSumYearAmtBasic" value="${sub1_shareSumYearAmtBasic + item.yearAmtBasic + item.yearShareAmtBasic}"/>
			<c:set var="sub1_shareSumAmtBasic" value="${sub1_shareSumAmtBasic + item.amtBasic + item.shareAmtBasic}"/>
			<c:set var="sub1_shareSumAmtDaily" value="${sub1_shareSumAmtDaily + item.amtDaily + item.shareAmtDaily}"/>
			
			<c:set var="sub1_shareSumAmtBasicDaily" value="${sub1_shareSumAmtBasicDaily + subTotal}"/>
			<c:set var="sub1_shareSumAmtTraffic" value="${sub1_shareSumAmtTraffic + item.amtTraffic + item.shareAmtTraffic}"/>
	
	        <c:set var="sub1_amtCounsel" value="${sub1_amtCounsel + item.amtCounsel + item.shareAmtCounsel}"/>
	        <c:set var="sub1_amtEtc" value="${sub1_amtEtc + item.amtEtc + item.shareAmtEtc}"/>
	        <c:set var="sub1_shareSumAmtTotal" value="${sub1_shareSumAmtTotal + shareSumAmtTotal}"/>
	        
	        <c:set var="sub1_outAmt" value="${sub1_outAmt + item.outAmt}"/>
	
	        <c:set var="sub1_subTotal" value="${sub1_subTotal + subTotal}"/>
	        <c:set var="sub1_rowTotal" value="${sub1_rowTotal + rowTotal}"/>
	        
        </c:forEach>
        <tr>
            <c:if test="${listCnt == 0}">
            <td>${teamName}</td>
            </c:if>
            <th>소계</th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_receiveMonthCnt}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_receiveYearCnt}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_closeMonthCnt}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_closeYearCnt}" pattern="#,###"/></th>
            <th style="text-align: right">
                <fmt:formatNumber var="itemCloseMonthCnt" value="${sub1_closeMonthCnt}" pattern="#.###"/>
                <fmt:formatNumber var="itemReceiveMonthCnt" value="${sub1_receiveMonthCnt}" pattern="#.###"/>
                <fmt:formatNumber value="${sub1_receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
            </th>
            <th style="text-align: right">
                <fmt:formatNumber var="itemCloseYearCnt" value="${sub1_closeYearCnt}" pattern="#.###"/>
                <fmt:formatNumber var="itemReceiveYearCnt" value="${sub1_receiveYearCnt}" pattern="#.###"/>
                <fmt:formatNumber value="${sub1_receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
            </th>
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_pendingMonthlyCnt}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_pendingCurrentCnt}" pattern="#,###"/></th>
            <th style="text-align: right">
                <fmt:formatNumber var="itemPendingCurrentCnt" value="${sub1_pendingCurrentCnt}" pattern="#.###"/>
                <fmt:formatNumber var="itemPendingOver45Cnt" value="${sub1_pendingOver45Cnt}" pattern="#.###"/>
                <fmt:formatNumber value="${sub1_pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
            </th>            
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtBasic}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtDaily}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtTraffic}" pattern="#,###"/></th>
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareAmtBasic}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareAmtDaily}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareAmtTraffic}" pattern="#,###"/></th>

            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumYearAmtBasic}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumAmtBasic}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumAmtDaily}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumAmtBasicDaily}" pattern="#,###"/></th>
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumAmtTraffic}" pattern="#,###"/></th>
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtCounsel}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtEtc}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_rowTotal}" pattern="#,###"/></th>
            <th style="text-align: right">
                <span style="color:red;"><fmt:formatNumber value="${sub1_outAmt}" pattern="#,###"/></span>
            </th>
        </tr>
        
        <c:set var="g_receiveMonthCnt" value="${g_receiveMonthCnt + sub1_receiveMonthCnt}"/>
        <c:set var="g_receiveYearCnt" value="${g_receiveYearCnt + sub1_receiveYearCnt}"/>
        <c:set var="g_closeMonthCnt" value="${g_closeMonthCnt + sub1_closeMonthCnt}"/>
        <c:set var="g_closeYearCnt" value="${g_closeYearCnt + sub1_closeYearCnt}"/>
        <c:set var="g_pendingCurrentCnt" value="${g_pendingCurrentCnt + sub1_pendingCurrentCnt}"/>
        <c:set var="g_pendingOver45Cnt" value="${g_pendingOver45Cnt + sub1_pendingOver45Cnt}"/>
        <c:set var="g_pendingMonthlyCnt" value="${g_pendingMonthlyCnt + sub1_pendingMonthlyCnt}"/>        

        <c:set var="g_amtBasic" value="${g_amtBasic + sub1_amtBasic}"/>
        <c:set var="g_amtDaily" value="${g_amtDaily + sub1_amtDaily}"/>
        <c:set var="g_amtTraffic" value="${g_amtTraffic + sub1_amtTraffic}"/>
        <c:set var="g_shareAmtBasic" value="${g_shareAmtBasic + sub1_shareAmtBasic}"/>
        <c:set var="g_shareAmtDaily" value="${g_shareAmtDaily + sub1_shareAmtDaily}"/>
        <c:set var="g_shareAmtTraffic" value="${g_shareAmtTraffic + sub1_shareAmtTraffic}"/>
        
        <c:set var="g_shareSumYearAmtBasic" value="${g_shareSumYearAmtBasic + sub1_shareSumYearAmtBasic}"/>
        <c:set var="g_shareSumAmtBasic" value="${g_shareSumAmtBasic + sub1_shareSumAmtBasic}"/>
        <c:set var="g_shareSumAmtDaily" value="${g_shareSumAmtDaily + sub1_shareSumAmtDaily}"/>
        <c:set var="g_shareSumAmtTraffic" value="${g_shareSumAmtTraffic + sub1_shareSumAmtTraffic}"/>
        <c:set var="g_shareSumAmtBasicDaily" value="${g_shareSumAmtBasicDaily + sub1_shareSumAmtBasicDaily}"/>

        <c:set var="g_amtCounsel" value="${g_amtCounsel + sub1_amtCounsel}"/>
        <c:set var="g_amtEtc" value="${g_amtEtc + sub1_amtEtc}"/>
        <c:set var="g_amtTotal" value="${g_amtTotal + sub1_amtTotal}"/>
        <c:set var="g_outAmt" value="${g_outAmt + sub1_outAmt}"/>

        <c:set var="g_subTotal" value="${g_subTotal + sub1_subTotal}"/>
        <c:set var="g_rowTotal" value="${g_rowTotal + sub1_rowTotal}"/>

    </c:forEach>
    <tr>
        <th colspan="2">합계</th>
        <th style="text-align: right"><fmt:formatNumber value="${g_receiveMonthCnt}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_receiveYearCnt}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_closeMonthCnt}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_closeYearCnt}" pattern="#,###"/></th>
        <th style="text-align: right">
            <fmt:formatNumber var="itemCloseMonthCnt" value="${g_closeMonthCnt}" pattern="#.###"/>
            <fmt:formatNumber var="itemReceiveMonthCnt" value="${g_receiveMonthCnt}" pattern="#.###"/>
            <fmt:formatNumber value="${g_receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
        </th>
        <th style="text-align: right">
            <fmt:formatNumber var="itemCloseYearCnt" value="${g_closeYearCnt}" pattern="#.###"/>
            <fmt:formatNumber var="itemReceiveYearCnt" value="${g_receiveYearCnt}" pattern="#.###"/>
            <fmt:formatNumber value="${g_receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
        </th>
        <th style="text-align: right"><fmt:formatNumber value="${g_pendingMonthlyCnt}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_pendingCurrentCnt}" pattern="#,###"/></th>
        <th style="text-align: right">
            <fmt:formatNumber var="itemPendingCurrentCnt" value="${g_pendingCurrentCnt}" pattern="#.###"/>
            <fmt:formatNumber var="itemPendingOver45Cnt" value="${g_pendingOver45Cnt}" pattern="#.###"/>
            <fmt:formatNumber value="${g_pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
        </th>        
        <th style="text-align: right"><fmt:formatNumber value="${g_amtBasic}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_amtDaily}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_amtTraffic}" pattern="#,###"/></th>
        
        <th style="text-align: right"><fmt:formatNumber value="${g_shareAmtBasic}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_shareAmtDaily}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_shareAmtTraffic}" pattern="#,###"/></th>

        <th style="text-align: right"><fmt:formatNumber value="${g_shareSumYearAmtBasic}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_shareSumAmtBasic}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_shareSumAmtDaily}" pattern="#,###"/></th>
		<th style="text-align: right"><fmt:formatNumber value="${g_shareSumAmtBasicDaily}" pattern="#,###"/></th>
		<th style="text-align: right"><fmt:formatNumber value="${g_shareSumAmtTraffic}" pattern="#,###"/></th>
	
        <th style="text-align: right"><fmt:formatNumber value="${g_amtCounsel}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_amtEtc}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_rowTotal}" pattern="#,###"/></th>
        <th style="text-align: right">
            <span style="color:red;"><fmt:formatNumber value="${g_outAmt}" pattern="#,###"/></span>
        </th>
    </tr>
</table>

<h1>개인기준 개인별 통계</h1>
<table cellpadding="0" cellspacing="0" width="1120" align="center" border="1">
    <colgroup>
        <col width="60">
        <col width="60">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="40">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
        <col width="60">
    </colgroup>
    <tr>
        <th rowspan="4"><span style="color: black;"><b>팀구분</b></span></th>
        <th rowspan="4"><span style="color: black;"><b>이름</b></span></th>
        <th colspan="2">수임현황</th>
        <th colspan="2">종결현황</th>
        <th colspan="2" rowspan="2">처리율(%)</th>
        <th colspan="3">미결현황</th>        
        <th colspan="15"><b>공동수행 반영</b></th>
    </tr>
    <tr>
        <th colspan="2">절대건수</th>
        <th colspan="2">절대건수</th>
        <th colspan="3">절대건수</th>        
        <th colspan="15">인보이스 현황<span style="color: red">(당월)</span></th>
    </tr>
    <tr>
        <th rowspan="2">당월</th>
        <th rowspan="2">년누계</th>
        <th rowspan="2">당월</th>
        <th rowspan="2">년누계</th>
        <th rowspan="2">당월</th>
        <th rowspan="2">년누계</th>
        
        <th rowspan="2">전월</th>
        <th rowspan="2">현재</th>
        <th rowspan="2">30,15</th>        
        
		<th colspan="3">공동수행 반영 전</th>
		<th colspan="3">공동수행</th>
		<th colspan="5">공동수행 반영 후</th>
		
		<th rowspan="2">자문료</th>
        <th rowspan="2">기타</th>
        <th rowspan="2">합계</th>
		<th rowspan="2">미수금</th>
	</tr>
	<tr>
        <th>기본료</th>
        <th>일비</th>
        <th>교통비</th>
        
        <th>기본료</th>
        <th>일비</th>
        <th>교통비</th>
        
        <th>기본료(누계)</th>
        <th>기본료</th>
        <th>일비</th>
        <th>기본료+일비</th>
        <th>교통비</th>
    </tr>
    
    <c:set var="g_receiveMonthCnt" value="0"/>
    <c:set var="g_receiveYearCnt" value="0"/>
    <c:set var="g_closeMonthCnt" value="0"/>
    <c:set var="g_closeYearCnt" value="0"/>
    <c:set var="g_pendingCurrentCnt" value="0"/>
    <c:set var="g_pendingOver45Cnt" value="0"/>
    <c:set var="g_pendingMonthlyCnt" value="0"/>
    
    <c:set var="g_amtBasic" value="0"/>
    <c:set var="g_amtDaily" value="0"/>
    <c:set var="g_amtTraffic" value="0"/>
    <c:set var="g_shareAmtBasic" value="0"/>
    <c:set var="g_shareAmtDaily" value="0"/>
    <c:set var="g_shareAmtTraffic" value="0"/>
    
    <c:set var="g_shareSumYearAmtBasic" value="0"/>
    <c:set var="g_shareSumAmtBasic" value="0"/>
    <c:set var="g_shareSumAmtDaily" value="0"/>
    <c:set var="g_shareSumAmtTraffic" value="0"/>
    <c:set var="g_shareSumAmtBasicDaily" value="0"/>

    <c:set var="g_amtCounsel" value="0"/>
    <c:set var="g_amtEtc" value="0"/>
    <c:set var="g_amtTotal" value="0"/>
    <c:set var="g_outAmt" value="0"/>

    <c:set var="g_subTotal" value="0"/>
    <c:set var="g_rowTotal" value="0"/>


    <c:forEach  var="itemList" items="${personExcelList}" varStatus="excelStatus">
        <c:set var="itemPersonList" value="${itemList.personList}"/>

        <c:set var="teamName" value="${teamList[excelStatus.index].teamName}"/>

	    <c:set var="sub1_receiveMonthCnt" value="0"/>
	    <c:set var="sub1_receiveYearCnt" value="0"/>
	    <c:set var="sub1_closeMonthCnt" value="0"/>
	    <c:set var="sub1_closeYearCnt" value="0"/>
	    
	    <c:set var="sub1_pendingCurrentCnt" value="0"/>
	    <c:set var="sub1_pendingOver45Cnt" value="0"/>
	    <c:set var="sub1_pendingMonthlyCnt" value="0"/>	    
	    
	    <c:set var="sub1_amtBasic" value="0"/>
	    <c:set var="sub1_amtDaily" value="0"/>
	    <c:set var="sub1_amtTraffic" value="0"/>
	    
	    <c:set var="sub1_shareAmtBasic" value="0"/>
	    <c:set var="sub1_shareAmtDaily" value="0"/>
	    <c:set var="sub1_shareAmtTraffic" value="0"/>
	    
	    <c:set var="sub1_shareSumYearAmtBasic" value="0"/>
	    <c:set var="sub1_shareSumAmtBasic" value="0"/>
	    <c:set var="sub1_shareSumAmtDaily" value="0"/>
	    
	    <c:set var="sub1_shareSumAmtBasicDaily" value="0"/>
	    <c:set var="sub1_shareSumAmtTraffic" value="0"/>
	    <c:set var="sub1_amtCounsel" value="0"/>
	    <c:set var="sub1_amtEtc" value="0"/>
	    
	    <c:set var="sub1_shareSumAmtTotal" value="0"/>
	    <c:set var="sub1_outAmt" value="0"/>
	    <c:set var="sub1_rowTotal" value="0"/>

        <c:set var="listCnt" value="${itemPersonList.size()}"/>
        <c:forEach  var="item" items="${itemPersonList}" varStatus="status">
            <tr>
                <c:if test="${status.index == 0}">
                <td rowspan="${listCnt + 1}">${teamName}</td>
                </c:if>
                <td>${item.userName}</td>
                <td class="right"><fmt:formatNumber value="${item.receiveMonthCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.receiveYearCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.closeMonthCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.closeYearCnt}" pattern="#,###"/></td>
                <td class="right">
                    <fmt:formatNumber var="itemCloseMonthCnt" value="${item.closeMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveMonthCnt" value="${item.receiveMonthCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${item.receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
                </td>
                <td class="right">
                    <fmt:formatNumber var="itemCloseYearCnt" value="${item.closeYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemReceiveYearCnt" value="${item.receiveYearCnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${item.receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
                </td>
                <td class="right"><fmt:formatNumber value="${item.pendingMonthlyCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.pendingCurrentCnt}" pattern="#,###"/></td>
                <td class="right">
                    <fmt:formatNumber var="itemPendingCurrentCnt" value="${item.pendingCurrentCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemPendingOver45Cnt" value="${item.pendingOver45Cnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${item.pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
                </td>                
                
                <td class="right"><fmt:formatNumber value="${item.amtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtTraffic}" pattern="#,###"/></td>
                
                <td class="right"><fmt:formatNumber value="${item.shareAmtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.shareAmtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.shareAmtTraffic}" pattern="#,###"/></td>

				<td class="right"><fmt:formatNumber value="${item.yearAmtBasic + item.yearShareAmtBasic}" pattern="#,###"/></td><!-- 기본료 누계(공동수행 반영)  -->
				<td class="right"><fmt:formatNumber value="${item.amtBasic + item.shareAmtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtDaily + item.shareAmtDaily}" pattern="#,###"/></td>
                <td class="right">
                    <c:set var="subTotal" value="${item.amtBasic + item.amtDaily + item.shareAmtBasic + item.shareAmtDaily}"/>
                    <fmt:formatNumber value="${subTotal}" pattern="#,###"/>
                </td>
                <td class="right"><fmt:formatNumber value="${item.amtTraffic + item.shareAmtTraffic}" pattern="#,###"/></td>

                <td class="right"><fmt:formatNumber value="${item.amtCounsel + item.shareAmtCounsel}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtEtc + item.shareAmtEtc}" pattern="#,###"/></td>
                <td class="right">
                    <c:set var="rowTotal" value="${subTotal + item.amtTraffic + item.shareAmtTraffic + item.amtCounsel + item.shareAmtCounsel + item.amtEtc + item.shareAmtEtc}"/>
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
	
	        <c:set var="sub1_amtBasic" value="${sub1_amtBasic + item.amtBasic}"/>
	        <c:set var="sub1_amtDaily" value="${sub1_amtDaily + item.amtDaily}"/>
	        <c:set var="sub1_amtTraffic" value="${sub1_amtTraffic + item.amtTraffic}"/>
	        
	        <c:set var="sub1_shareAmtBasic" value="${sub1_shareAmtBasic + item.shareAmtBasic}"/>
	        <c:set var="sub1_shareAmtDaily" value="${sub1_shareAmtDaily + item.shareAmtDaily}"/>
			<c:set var="sub1_shareAmtTraffic" value="${sub1_shareAmtTraffic + item.shareAmtTraffic}"/>
	
			<c:set var="sub1_shareSumYearAmtBasic" value="${sub1_shareSumYearAmtBasic + item.yearAmtBasic + item.yearShareAmtBasic}"/>
			<c:set var="sub1_shareSumAmtBasic" value="${sub1_shareSumAmtBasic + item.amtBasic + item.shareAmtBasic}"/>
			<c:set var="sub1_shareSumAmtDaily" value="${sub1_shareSumAmtDaily + item.amtDaily + item.shareAmtDaily}"/>
			
			<c:set var="sub1_shareSumAmtBasicDaily" value="${sub1_shareSumAmtBasicDaily + subTotal}"/>
			<c:set var="sub1_shareSumAmtTraffic" value="${sub1_shareSumAmtTraffic + item.amtTraffic + item.shareAmtTraffic}"/>
	
	        <c:set var="sub1_amtCounsel" value="${sub1_amtCounsel + item.amtCounsel + item.shareAmtCounsel}"/>
	        <c:set var="sub1_amtEtc" value="${sub1_amtEtc + item.amtEtc + item.shareAmtEtc}"/>
	        <c:set var="sub1_shareSumAmtTotal" value="${sub1_shareSumAmtTotal + shareSumAmtTotal}"/>
	        
	        <c:set var="sub1_outAmt" value="${sub1_outAmt + item.outAmt}"/>
	
	        <c:set var="sub1_subTotal" value="${sub1_subTotal + subTotal}"/>
	        <c:set var="sub1_rowTotal" value="${sub1_rowTotal + rowTotal}"/>
	        
        </c:forEach>
        <tr>
            <c:if test="${listCnt == 0}">
            <td>${teamName}</td>
            </c:if>
            <th>소계</th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_receiveMonthCnt}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_receiveYearCnt}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_closeMonthCnt}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_closeYearCnt}" pattern="#,###"/></th>
            <th style="text-align: right">
                <fmt:formatNumber var="itemCloseMonthCnt" value="${sub1_closeMonthCnt}" pattern="#.###"/>
                <fmt:formatNumber var="itemReceiveMonthCnt" value="${sub1_receiveMonthCnt}" pattern="#.###"/>
                <fmt:formatNumber value="${sub1_receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
            </th>
            <th style="text-align: right">
                <fmt:formatNumber var="itemCloseYearCnt" value="${sub1_closeYearCnt}" pattern="#.###"/>
                <fmt:formatNumber var="itemReceiveYearCnt" value="${sub1_receiveYearCnt}" pattern="#.###"/>
                <fmt:formatNumber value="${sub1_receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
            </th>
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_pendingMonthlyCnt}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_pendingCurrentCnt}" pattern="#,###"/></th>
            <th style="text-align: right">
                <fmt:formatNumber var="itemPendingCurrentCnt" value="${sub1_pendingCurrentCnt}" pattern="#.###"/>
                <fmt:formatNumber var="itemPendingOver45Cnt" value="${sub1_pendingOver45Cnt}" pattern="#.###"/>
                <fmt:formatNumber value="${sub1_pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
            </th>            
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtBasic}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtDaily}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtTraffic}" pattern="#,###"/></th>
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareAmtBasic}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareAmtDaily}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareAmtTraffic}" pattern="#,###"/></th>

            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumYearAmtBasic}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumAmtBasic}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumAmtDaily}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumAmtBasicDaily}" pattern="#,###"/></th>
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_shareSumAmtTraffic}" pattern="#,###"/></th>
            
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtCounsel}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_amtEtc}" pattern="#,###"/></th>
            <th style="text-align: right"><fmt:formatNumber value="${sub1_rowTotal}" pattern="#,###"/></th>
            <th style="text-align: right">
                <span style="color:red;"><fmt:formatNumber value="${sub1_outAmt}" pattern="#,###"/></span>
            </th>
        </tr>
        
        <c:set var="g_receiveMonthCnt" value="${g_receiveMonthCnt + sub1_receiveMonthCnt}"/>
        <c:set var="g_receiveYearCnt" value="${g_receiveYearCnt + sub1_receiveYearCnt}"/>
        <c:set var="g_closeMonthCnt" value="${g_closeMonthCnt + sub1_closeMonthCnt}"/>
        <c:set var="g_closeYearCnt" value="${g_closeYearCnt + sub1_closeYearCnt}"/>
        <c:set var="g_pendingCurrentCnt" value="${g_pendingCurrentCnt + sub1_pendingCurrentCnt}"/>
        <c:set var="g_pendingOver45Cnt" value="${g_pendingOver45Cnt + sub1_pendingOver45Cnt}"/>
        <c:set var="g_pendingMonthlyCnt" value="${g_pendingMonthlyCnt + sub1_pendingMonthlyCnt}"/>

        <c:set var="g_amtBasic" value="${g_amtBasic + sub1_amtBasic}"/>
        <c:set var="g_amtDaily" value="${g_amtDaily + sub1_amtDaily}"/>
        <c:set var="g_amtTraffic" value="${g_amtTraffic + sub1_amtTraffic}"/>
        <c:set var="g_shareAmtBasic" value="${g_shareAmtBasic + sub1_shareAmtBasic}"/>
        <c:set var="g_shareAmtDaily" value="${g_shareAmtDaily + sub1_shareAmtDaily}"/>
        <c:set var="g_shareAmtTraffic" value="${g_shareAmtTraffic + sub1_shareAmtTraffic}"/>
        
        <c:set var="g_shareSumYearAmtBasic" value="${g_shareSumYearAmtBasic + sub1_shareSumYearAmtBasic}"/>
        <c:set var="g_shareSumAmtBasic" value="${g_shareSumAmtBasic + sub1_shareSumAmtBasic}"/>
        <c:set var="g_shareSumAmtDaily" value="${g_shareSumAmtDaily + sub1_shareSumAmtDaily}"/>
        <c:set var="g_shareSumAmtTraffic" value="${g_shareSumAmtTraffic + sub1_shareSumAmtTraffic}"/>
        <c:set var="g_shareSumAmtBasicDaily" value="${g_shareSumAmtBasicDaily + sub1_shareSumAmtBasicDaily}"/>

        <c:set var="g_amtCounsel" value="${g_amtCounsel + sub1_amtCounsel}"/>
        <c:set var="g_amtEtc" value="${g_amtEtc + sub1_amtEtc}"/>
        <c:set var="g_amtTotal" value="${g_amtTotal + sub1_amtTotal}"/>
        <c:set var="g_outAmt" value="${g_outAmt + sub1_outAmt}"/>

        <c:set var="g_subTotal" value="${g_subTotal + sub1_subTotal}"/>
        <c:set var="g_rowTotal" value="${g_rowTotal + sub1_rowTotal}"/>

    </c:forEach>
    <tr>
        <th colspan="2">합계</th>
        <th style="text-align: right"><fmt:formatNumber value="${g_receiveMonthCnt}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_receiveYearCnt}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_closeMonthCnt}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_closeYearCnt}" pattern="#,###"/></th>
        <th style="text-align: right">
            <fmt:formatNumber var="itemCloseMonthCnt" value="${g_closeMonthCnt}" pattern="#.###"/>
            <fmt:formatNumber var="itemReceiveMonthCnt" value="${g_receiveMonthCnt}" pattern="#.###"/>
            <fmt:formatNumber value="${g_receiveMonthCnt == 0 ? 0.0 : itemCloseMonthCnt / itemReceiveMonthCnt * 100}" pattern="#,###.##"/>%
        </th>
        <th style="text-align: right">
            <fmt:formatNumber var="itemCloseYearCnt" value="${g_closeYearCnt}" pattern="#.###"/>
            <fmt:formatNumber var="itemReceiveYearCnt" value="${g_receiveYearCnt}" pattern="#.###"/>
            <fmt:formatNumber value="${g_receiveYearCnt == 0 ? 0.0 : itemCloseYearCnt / itemReceiveYearCnt * 100}" pattern="#,###.##"/>%
        </th>
        <th style="text-align: right"><fmt:formatNumber value="${g_pendingMonthlyCnt}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_pendingCurrentCnt}" pattern="#,###"/></th>
        <th style="text-align: right">
            <fmt:formatNumber var="itemPendingCurrentCnt" value="${g_pendingCurrentCnt}" pattern="#.###"/>
            <fmt:formatNumber var="itemPendingOver45Cnt" value="${g_pendingOver45Cnt}" pattern="#.###"/>
            <fmt:formatNumber value="${g_pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
        </th>                
        
        <th style="text-align: right"><fmt:formatNumber value="${g_amtBasic}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_amtDaily}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_amtTraffic}" pattern="#,###"/></th>
        
        <th style="text-align: right"><fmt:formatNumber value="${g_shareAmtBasic}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_shareAmtDaily}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_shareAmtTraffic}" pattern="#,###"/></th>

        <th style="text-align: right"><fmt:formatNumber value="${g_shareSumYearAmtBasic}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_shareSumAmtBasic}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_shareSumAmtDaily}" pattern="#,###"/></th>
		<th style="text-align: right"><fmt:formatNumber value="${g_shareSumAmtBasicDaily}" pattern="#,###"/></th>
		<th style="text-align: right"><fmt:formatNumber value="${g_shareSumAmtTraffic}" pattern="#,###"/></th>
	
        <th style="text-align: right"><fmt:formatNumber value="${g_amtCounsel}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_amtEtc}" pattern="#,###"/></th>
        <th style="text-align: right"><fmt:formatNumber value="${g_rowTotal}" pattern="#,###"/></th>
        <th style="text-align: right">
            <span style="color:red;"><fmt:formatNumber value="${g_outAmt}" pattern="#,###"/></span>
        </th>
    </tr>
    
</table>
</body>
</html>