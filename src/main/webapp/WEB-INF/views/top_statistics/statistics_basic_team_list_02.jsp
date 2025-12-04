<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- NEW 기본통계 - 팀별 평균 통계 - 1종  -->
<div class="tableStyle2" id="area_excel">
	<div style="width:100%; overflow-x: auto; overflow-y: hidden !important;">
		<div style="width:1882px;" >
			<div style="padding-right: 17px; background: #e7ecf1;">
		        <table cellpadding="0" cellspacing="0"  align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
		            <colgroup>
		                <col style="width: 170px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 78px;">
		                <col style="width: 78px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 119px;">
		            </colgroup>
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
		                <th colspan="2" class="border-right" >절대건수</th>
		                <th colspan="3" class="border-right">절대건수</th>
		                <th colspan="2" class="border-right"><!-- 평가건수 -->기준업무량건수</th>
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
		        </table>
			</div>
			<div style="height:570px; overflow-x: hidden !important; overflow-y: auto;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
		            <colgroup>
		                <col style="width: 170px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 69px;">
		                <col style="width: 78px;">
		                <col style="width: 78px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 111px;">
		                <col style="width: 119px;">
		            </colgroup>
		            <c:forEach  var="item" items="${teamList1}" varStatus="status">
		                <tr>
		                    <td class="left border-right">
		                        <c:choose>
		                            <c:when test="${srchArg.excelYN == 'Y'}">
		                                ${item.teamName}<c:if test="${item.teamWritten eq '1' }"> [서면심사]</c:if>
		                            </c:when>
		                            <c:otherwise>
		                                <a href="#noloc" onclick="fnMemberList('${item.teamId}','1');">${item.teamName}
		                                	<c:if test="${item.teamWritten eq '1' }"> [서면심사]</c:if>
		                                </a>
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
		                    <%-- <td class="right"><fmt:formatNumber value="${item.closeMonthEa}" pattern="#,###.###"/></td> --%>
		                    <%-- <td class="right"><fmt:formatNumber value="${item.workloadMonthResult}" pattern="#,###.###"/></td> --%>
		                    <td class="right"><fmt:formatNumber value="${item.workLoadMonthCal}" pattern="#,###.###"/></td>
		                    <%-- <td class="right border-right"><fmt:formatNumber value="${item.closeYearEa}" pattern="#,###.###"/></td> --%>
		                    <td class="right border-right"><fmt:formatNumber value="${item.workloadYearResult}" pattern="#,###.###"/></td>
		                    
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
		                <c:set var="sub1_workloadMonthResult" value="${sub1_workloadMonthResult + item.workLoadMonthCal}"/>
		                <c:set var="sub1_closeYearEa" value="${sub1_closeYearEa + item.closeYearEa}"/>
		                <c:set var="sub1_workloadYearResult" value="${sub1_workloadYearResult + item.workloadYearResult}"/>
		                
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
		                <%-- <th class="right"><fmt:formatNumber value="${sub1_closeMonthEa}" pattern="#,###.###"/></th> --%>
		                <th class="right"><fmt:formatNumber value="${sub1_workloadMonthResult}" pattern="#,###.###"/></th>
		                <%-- <th class="right border-right"><fmt:formatNumber value="${sub1_closeYearEa}" pattern="#,###.###"/></th> --%>
		                <th class="right border-right"><fmt:formatNumber value="${sub1_workloadYearResult}" pattern="#,###.###"/></th>
		                
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
		        </table>
    		</div>
		</div>
	</div>
</div>
