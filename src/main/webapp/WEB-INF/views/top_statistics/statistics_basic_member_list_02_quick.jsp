<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 개인기준 개인별 통계 -->
<div class="tableStyle2">
    <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>        
        <tr>
            <th class="border-right" rowspan="4"><span style="color: black;"><b>이름</b></span></th>
            <th class="border-right" colspan="2">수임현황</th>
            <th class="border-right" colspan="2">종결현황</th>
            <th class="border-right border-left" colspan="2" rowspan="2">처리율(%)</th>
            <th class="border-right" colspan="3">미결현황</th>            
            <th colspan="15"><b>공동수행 반영</b></th>
        </tr>
        <tr>
            <th class="border-right" colspan="2">절대건수</th>
            <th class="border-right" colspan="2">절대건수</th>
            <th class="border-right" colspan="3">절대건수</th>            
            <th colspan="15">인보이스 현황<span style="color: red">(당월)</span></th>
        </tr>
        <tr>
            <th rowspan="2">당월</th>
            <th class="border-right" rowspan="2">년누계</th>
            <th rowspan="2">당월</th>
            <th class="border-right" rowspan="2">년누계</th>
            <th rowspan="2">당월</th>
            <th class="border-right" rowspan="2">년누계</th>
            
            <th rowspan="2">전월</th>
            <th rowspan="2">현재</th>
            <th class="border-right" rowspan="2">30,15</th>            
            
            <th class="border-right" colspan="3" style="background: YELLO;"> 공동수행 반영 전 </th>
            <th class="border-right" colspan="3" style="background: YELLO;"> 공동수행 </th>
            <th class="border-right" colspan="5" style="background: YELLO;"> 공동수행 반영 후 </th>
            
            <th class="border-left" rowspan="2">자문료</th>
            <th rowspan="2">기타</th>
            <th rowspan="2">합계</th>
            <th rowspan="2">미수금</th>
        </tr>
        <tr>
            <th>기본료</th>
            <th>일비</th>
            <th class="border-right">교통비</th>
             
            <th>기본료</th>
            <th>일비</th>
            <th class="border-right">교통비</th>
            
            <th>기본료(누계)</th>
            <th>기본료</th>
            <th>일비</th>
            <th>기본료+일비</th>
            <th class="border-right">교통비</th>
        </tr>
        
        <c:set var="sub1_receiveMonthCnt" value="0"/>
        <c:set var="sub1_receiveYearCnt" value="0"/>
        <c:set var="sub1_closeMonthCnt" value="0"/>
        <c:set var="sub1_closeYearCnt" value="0"/>
        
        
        <c:set var="sub1_pendingCurrentCnt" value="0"/>
        <c:set var="sub1_pendingOver45Cnt" value="0"/>
        <c:set var="sub1_pendingMonthlyCnt" value="0"/>
        
        <c:set var="sub1_closeMonthEa" value="0"/>
        <c:set var="sub1_closeShareEa" value="0"/>
        
        <c:set var="sub1_amtBasic" value="0"/>
        <c:set var="sub1_amtDaily" value="0"/>
        <c:set var="sub1_amtTraffic" value="0"/>
        
        <c:set var="sub1_shareAmtBasic" value="0"/>
        <c:set var="sub1_shareAmtDaily" value="0"/>
        <c:set var="sub1_shareAmtTraffic" value="0"/>
        
        <c:set var="sub1_shareSumAmtBasic" value="0"/>
        <c:set var="sub1_shareSumAmtDaily" value="0"/>
        <c:set var="sub1_shareSumYearAmtBasic" value="0"/>
        
        <c:set var="sub1_shareSumAmtBasicDaily" value="0"/>
        <c:set var="sub1_shareSumAmtTraffic" value="0"/>
        <c:set var="sub1_amtCounsel" value="0"/>
        <c:set var="sub1_amtEtc" value="0"/>
        
        <c:set var="sub1_shareSumAmtTotal" value="0"/>
        <c:set var="sub1_outAmt" value="0"/>
        
        <c:forEach  var="item" items="${memberPersonStandardList}" varStatus="status">
            <tr>
                <td class="border-right">
                    <c:choose>
                        <c:when test="${srchArg.excelYN == 'Y'}">
                            ${item.userName}
                        </c:when>
                        <c:otherwise>
                            <a href="#noloc" onclick="fnMemberDetail('${item.userNo}');">${item.userName}</a>
                        </c:otherwise>
                    </c:choose>
                </td>
                
                <!-- 수임/종결 현황 -->
                <td class="right"><fmt:formatNumber value="${item.receiveMonthCnt}" pattern="#,###"/></td>
                <td class="right border-right"><fmt:formatNumber value="${item.receiveYearCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.closeMonthCnt}" pattern="#,###"/></td>
                <td class="right border-right"><fmt:formatNumber value="${item.closeYearCnt}" pattern="#,###"/></td>
                
                <!-- 처리율 -->
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
                
                <!-- 미결현황 -->
                <td class="right"><fmt:formatNumber value="${item.pendingMonthlyCnt}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.pendingCurrentCnt}" pattern="#,###"/></td>
                <td class="right border-right">
                    <fmt:formatNumber var="itemPendingCurrentCnt" value="${item.pendingCurrentCnt}" pattern="#.###"/>
                    <fmt:formatNumber var="itemPendingOver45Cnt" value="${item.pendingOver45Cnt}" pattern="#.###"/>
                    <fmt:formatNumber value="${item.pendingCurrentCnt == 0 ? 0.0 : itemPendingOver45Cnt / itemPendingCurrentCnt * 100}" pattern="#,###.##"/>%
                </td>                
                
                <td class="right"><fmt:formatNumber value="${item.amtBasic}" pattern="#,###"/></td><!-- 기본료(공동수행 미반영) -->
                <td class="right"><fmt:formatNumber value="${item.amtDaily}" pattern="#,###"/></td><!-- 일비(공동수행 미반영)  -->
                <td class="right border-right"><fmt:formatNumber value="${item.amtTraffic}" pattern="#,###"/></td><!-- 교통비(공동수행 미반영) -->
                
                <td class="right"><fmt:formatNumber value="${item.shareAmtBasic}" pattern="#,###"/></td><!-- 공동수행 기본료 -->
                <td class="right"><fmt:formatNumber value="${item.shareAmtDaily}" pattern="#,###"/></td><!-- 공동수행 일비 -->
                <td class="right border-right"><fmt:formatNumber value="${item.shareAmtTraffic}" pattern="#,###"/></td><!-- 공동수행 교통비 -->
                
                <td class="right"><fmt:formatNumber value="${item.yearAmtBasic + item.yearShareAmtBasic}" pattern="#,###"/></td><!-- 기본료 누계(공동수행 반영)  -->
                <td class="right"><fmt:formatNumber value="${item.amtBasic + item.shareAmtBasic}" pattern="#,###"/></td><!-- 기본료(공동수행 반영) -->
                <td class="right"><fmt:formatNumber value="${item.amtDaily + item.shareAmtDaily}" pattern="#,###"/></td><!-- 일비(공동수행 반영) -->
                
                <!-- 기본료+일비  ( 공동수행 반영 ) -->
                <td class="right">
                	<c:set var="subTotal" value="${item.amtBasic + item.amtDaily + item.shareAmtBasic + item.shareAmtDaily}"/>
                	<fmt:formatNumber value="${subTotal}" pattern="#,###"/>
               	</td>
               	
                <td class="right border-right"><fmt:formatNumber value="${item.amtTraffic + item.shareAmtTraffic}" pattern="#,###"/></td><!-- 교통비(공동수행 반영)-->                
                <td class="right"><fmt:formatNumber value="${item.amtCounsel + item.shareAmtCounsel}" pattern="#,###"/></td><!-- 자문료 -->
                <td class="right"><fmt:formatNumber value="${item.amtEtc + item.shareAmtEtc}" pattern="#,###"/></td><!-- 기타 -->
                
                <!-- 합계 -->
                <td class="right">
					<c:set var="shareSumAmtTotal" value="${subTotal + item.amtTraffic + item.shareAmtTraffic + item.amtCounsel + item.shareAmtCounsel + item.amtEtc + item.shareAmtEtc}"/>          	
                	<fmt:formatNumber value="${shareSumAmtTotal}" pattern="#,###"/>
               	</td>
                
                <!-- 미수금 -->
                <td class="right"><span style="color:red;"><fmt:formatNumber value="${item.outAmt}" pattern="#,###"/></span></td>
                
            </tr>
	        
            <c:set var="sub1_receiveMonthCnt" value="${sub1_receiveMonthCnt + item.receiveMonthCnt}"/>
            <c:set var="sub1_receiveYearCnt" value="${sub1_receiveYearCnt + item.receiveYearCnt}"/>
            <c:set var="sub1_closeMonthCnt" value="${sub1_closeMonthCnt + item.closeMonthCnt}"/>
            <c:set var="sub1_closeYearCnt" value="${sub1_closeYearCnt + item.closeYearCnt}"/>            
	        
            <c:set var="sub1_pendingCurrentCnt" value="${sub1_pendingCurrentCnt + item.pendingCurrentCnt}"/>
            <c:set var="sub1_pendingOver45Cnt" value="${sub1_pendingOver45Cnt + item.pendingOver45Cnt}"/>
            <c:set var="sub1_pendingMonthlyCnt" value="${sub1_pendingMonthlyCnt + item.pendingMonthlyCnt}"/><!-- 기간 미결 카운트 -->
            
            <c:set var="sub1_closeMonthEa" value="${sub1_closeMonthEa + item.closeMonthEa}"/>
            <c:set var="sub1_closeMonthWorkloadEa" value="${sub1_closeMonthWorkloadEa + item.closeMonthWorkloadEa}"/><!-- 표준업무 월 합계추가 by top3009 -->
            <c:set var="sub1_closeShareEa" value="${sub1_closeShareEa + item.closeShareEa}"/>
            <c:set var="sub1_closeShareWorkloadEa" value="${sub1_closeShareWorkloadEa + item.closeShareWorkloadEa}"/><!-- 표준업무 공동적용 합계추가 by top3009 -->

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
            <th class="border-right">합계</th>
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
                        
            <th class="right"><fmt:formatNumber value="${sub1_amtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${sub1_amtDaily}" pattern="#,###"/></th>
            <th class="right border-right"><fmt:formatNumber value="${sub1_amtTraffic}" pattern="#,###"/></th>
            
            <th class="right"><fmt:formatNumber value="${sub1_shareAmtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${sub1_shareAmtDaily}" pattern="#,###"/></th>
            <th class="right border-right"><fmt:formatNumber value="${sub1_shareAmtTraffic}" pattern="#,###"/></th>
            
            <th class="right"><fmt:formatNumber value="${sub1_shareSumYearAmtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${sub1_shareSumAmtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${sub1_shareSumAmtDaily}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${sub1_shareSumAmtBasicDaily}" pattern="#,###"/></th>
            <th class="right border-right"><fmt:formatNumber value="${sub1_shareSumAmtTraffic}" pattern="#,###"/></th>
            
            <th class="right"><fmt:formatNumber value="${sub1_amtCounsel}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${sub1_amtEtc}" pattern="#,###"/></th>
            
            <th class="right"><fmt:formatNumber value="${sub1_shareSumAmtTotal}" pattern="#,###"/></th>
            <th class="right">
                <span style="color:red;">
                	<c:choose>
                		<c:when test="${sub1_outAmt > 0}">
                			<fmt:formatNumber value="${sub1_outAmt}" pattern="#,###"/>
                		</c:when>
                		<c:otherwise>
                			<fmt:formatNumber value="${totalOutAmt}" pattern="#,###"/>		
                		</c:otherwise>
                	</c:choose>                
               	</span>
            </th>
        </tr>
    </table>
</div>

