<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="65">
                <col width="130">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <%-- <col width="65">
                <col width="65"> --%>
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>
            <thead>
            <tr>
                <th rowspan="3" style="font-weight: bold;background:#e7ecf1;">Type</th>
                <th class="border-right" rowspan="3" style="font-weight: bold;background:#e7ecf1;">보험사</th>
                <th class="border-right" colspan="2" style="font-weight: bold;background:#e7ecf1;">수임현황</th>
                <th class="border-right" colspan="2" style="font-weight: bold;background:#e7ecf1;">종결현황</th>
                <th class="border-right" style="font-weight: bold;background:#e7ecf1;">미결현황</th>
                <!-- <th class="border-right" colspan="2" style="font-weight: bold;background:#e7ecf1;">종결평가</th> -->
                <th colspan="7" style="background:#e7ecf1;">공동수행자의 비율 및 금액을 반영한 결과</th>
            </tr>
            <tr>
                <th class="border-right" colspan="2" style="background:#e7ecf1;">절대건수</th>
                <th class="border-right" colspan="2" style="background:#e7ecf1;">절대건수</th>
                <th class="border-right" style="background:#e7ecf1;">절대건수</th>
                <!-- <th class="border-right" colspan="2" style="background:#e7ecf1;">평가건수</th> -->
                <th colspan="7" style="background:#e7ecf1;">인보이스 현황</th>
            </tr>
            <tr>
                <th style="background:#e7ecf1;">당월</th>
                <th class="border-right" style="background:#e7ecf1;">년누계</th>
                <th style="background:#e7ecf1;">당월</th>
                <th class="border-right" style="background:#e7ecf1;">년누계</th>
                <th class="border-right" style="background:#e7ecf1;">현재</th>
                <!-- <th style="background:#e7ecf1;">당월</th>
                <th class="border-right" style="background:#e7ecf1;">년누계</th> -->
                <th style="background:#e7ecf1;">기본료</th>
                <th style="background:#e7ecf1;">일비</th>
                <th style="background:#e7ecf1;">소계(기본+일)</th>
                <th style="background:#e7ecf1;">교통비</th>
                <th style="background:#e7ecf1;">자문료</th>
                <th style="background:#e7ecf1;">기타</th>
                <th style="background:#e7ecf1;">합계</th>
            </tr>
            </thead>
        </table>
    </div>
    <div style="height:554px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="65">
                <col width="130">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <%-- <col width="65">
                <col width="65"> --%>
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>
            <!-- 1종 조사 시작 -->
            <tbody>
            <c:set var="invo_mid_sum" value="0"/>
            <c:forEach items="${MisBscPtnr1Main}" var="kind1" varStatus="kind1Status">
                <c:set var="invo_mid_sum" value="${kind1.invo_basic+kind1.invo_daily}"/>
                <c:set var="invo_tot_sum" value="${invo_mid_sum+kind1.invo_traffic+kind1.invo_counsel+kind1.invo_etc}"/>

                <tr>
                    <c:if test="${kind1Status.first}">
                        <td rowspan="${MisBscPtnr1Main.size()}" style="font-weight:bold;background:#F8F8F8;">
                            1종 조사
                        </td>
                    </c:if>
                    <td class="border-right"><!-- 보험사 -->
                            ${kind1.ptnr_nick}
                    </td>
                    <td><!-- 수임현황 - 당월 -->
                        <fmt:formatNumber value="${kind1.suim_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 수임현황 - 년누계 -->
                        <fmt:formatNumber value="${kind1.suim_y}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 종결현황 - 당월 -->
                        <fmt:formatNumber value="${kind1.close_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 종결현황 - 년누계 -->
                        <fmt:formatNumber value="${kind1.close_y}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 미결현황 -->
                        <fmt:formatNumber value="${kind1.suim_mi}" pattern="#,##0.###"/><br>
                    </td>
                    <%-- <td><!-- 종결평가 - 당월 -->
                        <fmt:formatNumber value="${kind1.report_ea_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 종결평가 - 년누계 -->
                        <fmt:formatNumber value="${kind1.report_ea_y}" pattern="#,##0.###"/><br>
                    </td> --%>
                    <td><!-- 인보이스  - 기본료 -->
                        <fmt:formatNumber value="${kind1.invo_basic}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 일비 -->
                        <fmt:formatNumber value="${kind1.invo_daily}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 소계(기본료+일비) -->
                        <fmt:formatNumber value="${invo_mid_sum}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 교통비 -->
                        <fmt:formatNumber value="${kind1.invo_traffic}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 자문료 -->
                        <fmt:formatNumber value="${kind1.invo_counsel}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 기타 -->
                        <fmt:formatNumber value="${kind1.invo_etc}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 합계 -->
                        <fmt:formatNumber value="${invo_tot_sum}" pattern="#,##0.###"/><br>
                    </td>
                </tr>

                <c:set var="Sum1SuimM" value="${kind1.suim_m + Sum1SuimM}"/>
                <c:set var="Sum1SuimY" value="${kind1.suim_y + Sum1SuimY}"/>
                <c:set var="Sum1CloseM" value="${kind1.close_m + Sum1CloseM}"/>
                <c:set var="Sum1CloseY" value="${kind1.close_y + Sum1CloseY}"/>
                <c:set var="Sum1SuimMi" value="${kind1.suim_mi + Sum1SuimMi}"/>
                <c:set var="Sum1RptEaM" value="${kind1.report_ea_m + Sum1RptEaM}"/>
                <c:set var="Sum1RptEaY" value="${kind1.report_ea_y + Sum1RptEaY}"/>
                <c:set var="Sum1Basic" value="${kind1.invo_basic + Sum1Basic}"/>
                <c:set var="Sum1Daily" value="${kind1.invo_daily + Sum1Daily}"/>
                <c:set var="Sum1Mid" value="${invo_mid_sum + Sum1Mid}"/>
                <c:set var="Sum1Traffic" value="${kind1.invo_traffic + Sum1Traffic}"/>
                <c:set var="Sum1Counsel" value="${kind1.invo_counsel + Sum1Counsel}"/>
                <c:set var="Sum1Etc" value="${kind1.invo_etc + Sum1Etc}"/>
                <c:set var="Sum1Tot" value="${invo_tot_sum + Sum1Tot}"/>
            </c:forEach>
            <tr style="background:#e7ecf1;">
                <td class="border-right" colspan="2">1종 조사 소계</td>
                <td><!-- 수임현황 - 당월 - 1종합 -->
                    <fmt:formatNumber value="${Sum1SuimM}" pattern="#,##0.###"/><br>
                </td>
                <td class="border-right"><!-- 수임현황 - 년누계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1SuimY}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 종결현황 - 당월 - 1종합 -->
                    <fmt:formatNumber value="${Sum1CloseM}" pattern="#,##0.###"/><br>
                </td>
                <td class="border-right"><!-- 종결현황 - 년누계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1CloseY}" pattern="#,##0.###"/><br>
                </td>
                <td class="border-right"><!-- 미결현황 - 1종합 -->
                    <fmt:formatNumber value="${Sum1SuimMi}" pattern="#,##0.###"/><br>
                </td>
                <%-- <td><!-- 종결평가 - 당월 - 1종합 -->
                    <fmt:formatNumber value="${Sum1RptEaM}" pattern="#,##0.###"/><br>
                </td>
                <td class="border-right"><!-- 종결평가 - 년누계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1RptEaY}" pattern="#,##0.###"/><br>
                </td> --%>
                <td><!-- 인보이스 - 기본료 - 1종합 -->
                    <fmt:formatNumber value="${Sum1Basic}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 일비 - 1종합 -->
                    <fmt:formatNumber value="${Sum1Daily}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 소계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1Mid}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 교통비 - 1종합 -->
                    <fmt:formatNumber value="${Sum1Traffic}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 자문료 - 1종합 -->
                    <fmt:formatNumber value="${Sum1Counsel}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 기타 - 1종합 -->
                    <fmt:formatNumber value="${Sum1Etc}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 합계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1Tot}" pattern="#,##0.###"/><br>
                </td>
            </tr>
            </tbody>
			<!-- 1종 조사 끝 -->
			
			<!-- 1종 심사 시작 -->
			<tbody>
            <c:set var="invo_mid_sum" value="0"/>
            <c:forEach items="${MisBscPtnr1Written}" var="kind1Written" varStatus="kind1WrittenStatus">
                <c:set var="invo_mid_sum" value="${kind1Written.invo_basic+kind1Written.invo_daily}"/>
                <c:set var="invo_tot_sum" value="${invo_mid_sum+kind1Written.invo_traffic+kind1Written.invo_counsel+kind1Written.invo_etc}"/>

                <tr>
                    <c:if test="${kind1WrittenStatus.first}">
                        <td rowspan="${MisBscPtnr1Written.size()}" style="font-weight:bold;background:#F8F8F8;">
                            1종 심사
                        </td>
                    </c:if>
                    <td class="border-right"><!-- 보험사 -->
                            ${kind1Written.ptnr_nick}
                    </td>
                    <td><!-- 수임현황 - 당월 -->
                        <fmt:formatNumber value="${kind1Written.suim_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 수임현황 - 년누계 -->
                        <fmt:formatNumber value="${kind1Written.suim_y}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 종결현황 - 당월 -->
                        <fmt:formatNumber value="${kind1Written.close_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 종결현황 - 년누계 -->
                        <fmt:formatNumber value="${kind1Written.close_y}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 미결현황 -->
                        <fmt:formatNumber value="${kind1Written.suim_mi}" pattern="#,##0.###"/><br>
                    </td>
                    <%-- <td><!-- 종결평가 - 당월 -->
                        <fmt:formatNumber value="${kind1Written.report_ea_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 종결평가 - 년누계 -->
                        <fmt:formatNumber value="${kind1Written.report_ea_y}" pattern="#,##0.###"/><br>
                    </td> --%>
                    <td><!-- 인보이스  - 기본료 -->
                        <fmt:formatNumber value="${kind1Written.invo_basic}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 일비 -->
                        <fmt:formatNumber value="${kind1Written.invo_daily}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 소계(기본료+일비) -->
                        <fmt:formatNumber value="${invo_mid_sum}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 교통비 -->
                        <fmt:formatNumber value="${kind1Written.invo_traffic}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 자문료 -->
                        <fmt:formatNumber value="${kind1Written.invo_counsel}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 기타 -->
                        <fmt:formatNumber value="${kind1Written.invo_etc}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 합계 -->
                        <fmt:formatNumber value="${invo_tot_sum}" pattern="#,##0.###"/><br>
                    </td>
                </tr>

                <c:set var="Sum1WrittenSuimM" value="${kind1Written.suim_m + Sum1WrittenSuimM}"/>
                <c:set var="Sum1WrittenSuimY" value="${kind1Written.suim_y + Sum1WrittenSuimY}"/>
                <c:set var="Sum1WrittenCloseM" value="${kind1Written.close_m + Sum1WrittenCloseM}"/>
                <c:set var="Sum1WrittenCloseY" value="${kind1Written.close_y + Sum1WrittenCloseY}"/>
                <c:set var="Sum1WrittenSuimMi" value="${kind1Written.suim_mi + Sum1WrittenSuimMi}"/>
                <c:set var="Sum1WrittenRptEaM" value="${kind1Written.report_ea_m + Sum1WrittenRptEaM}"/>
                <c:set var="Sum1WrittenRptEaY" value="${kind1Written.report_ea_y + Sum1WrittenRptEaY}"/>
                <c:set var="Sum1WrittenBasic" value="${kind1Written.invo_basic + Sum1WrittenBasic}"/>
                <c:set var="Sum1WrittenDaily" value="${kind1Written.invo_daily + Sum1WrittenDaily}"/>
                <c:set var="Sum1WrittenMid" value="${invo_mid_sum + Sum1WrittenMid}"/>
                <c:set var="Sum1WrittenTraffic" value="${kind1Written.invo_traffic + Sum1WrittenTraffic}"/>
                <c:set var="Sum1WrittenCounsel" value="${kind1Written.invo_counsel + Sum1WrittenCounsel}"/>
                <c:set var="Sum1WrittenEtc" value="${kind1Written.invo_etc + Sum1WrittenEtc}"/>
                <c:set var="Sum1WrittenTot" value="${invo_tot_sum + Sum1WrittenTot}"/>
            </c:forEach>
            <tr style="background:#e7ecf1;">
                <td class="border-right" colspan="2">1종 심사 소계</td>
                <td><!-- 수임현황 - 당월 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenSuimM}" pattern="#,##0.###"/><br>
                </td>
                <td class="border-right"><!-- 수임현황 - 년누계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenSuimY}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 종결현황 - 당월 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenCloseM}" pattern="#,##0.###"/><br>
                </td>
                <td class="border-right"><!-- 종결현황 - 년누계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenCloseY}" pattern="#,##0.###"/><br>
                </td>
                <td class="border-right"><!-- 미결현황 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenSuimMi}" pattern="#,##0.###"/><br>
                </td>
                <%-- <td><!-- 종결평가 - 당월 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenRptEaM}" pattern="#,##0.###"/><br>
                </td>
                <td class="border-right"><!-- 종결평가 - 년누계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenRptEaY}" pattern="#,##0.###"/><br>
                </td> --%>
                <td><!-- 인보이스 - 기본료 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenBasic}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 일비 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenDaily}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 소계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenMid}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 교통비 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenTraffic}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 자문료 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenCounsel}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 기타 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenEtc}" pattern="#,##0.###"/><br>
                </td>
                <td><!-- 인보이스 - 합계 - 1종합 -->
                    <fmt:formatNumber value="${Sum1WrittenTot}" pattern="#,##0.###"/><br>
                </td>
            </tr>
            </tbody>			
			<!-- 1종 심사 끝 -->
			<!-- 1종 합계 시작 -->
			<tr style="background:#FFF;">
                <th class="border-right" colspan="2">1종 소계</th>
                <th><!-- 수임현황 - 당월 - 총합 -->
                    <fmt:formatNumber value="${Sum1SuimM+Sum1WrittenSuimM}" pattern="#,##0.###"/><br>
                </th>
                <th class="border-right"><!-- 수임현황 - 년누계 - 총합 -->
                    <fmt:formatNumber value="${Sum1SuimY+Sum1WrittenSuimY}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 종결현황 - 당월 - 총합-->
                    <fmt:formatNumber value="${Sum1CloseM+Sum1WrittenCloseM}" pattern="#,##0.###"/><br>
                </th>
                <th class="border-right"><!-- 종결현황 - 년누계 - 총합 -->
                    <fmt:formatNumber value="${Sum1CloseY+Sum1WrittenCloseY}" pattern="#,##0.###"/><br>
                </th>
                <th class="border-right"><!-- 미결현황 - 총합 -->
                    <fmt:formatNumber value="${Sum1SuimMi+Sum1WrittenSuimMi}" pattern="#,##0.###"/><br>
                </th>
                <%-- <th><!-- 종결평가 - 당월 - 총합 -->
                    <fmt:formatNumber value="${Sum1RptEaM+Sum1WrittenRptEaM}" pattern="#,##0.###"/><br>
                </th>
                <th class="border-right"><!-- 종결평가 - 년누계 - 총합 -->
                    <fmt:formatNumber value="${Sum1RptEaY+Sum1WrittenRptEaY}" pattern="#,##0.###"/><br>
                </th> --%>
                <th><!-- 인보이스 - 기본료 - 총합 -->
                    <fmt:formatNumber value="${Sum1Basic+Sum1WrittenBasic}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 일비 - 총합 -->
                    <fmt:formatNumber value="${Sum1Daily+Sum1WrittenDaily}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 소계 - 총합 -->
                    <fmt:formatNumber value="${Sum1Mid+Sum1WrittenMid}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 교통비 - 총합 -->
                    <fmt:formatNumber value="${Sum1Traffic+Sum1WrittenTraffic}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 자문료 - 총합 -->
                    <fmt:formatNumber value="${Sum1Counsel+Sum1WrittenCounsel}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 기타 - 총합 -->
                    <fmt:formatNumber value="${Sum1Etc+Sum1WrittenEtc}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 합계 - 총합 -->
                    <fmt:formatNumber value="${Sum1Tot+Sum1WrittenTot}" pattern="#,##0.###"/><br>
                </th>
            </tr>
			<!-- 1종 합계 끝 -->

            <tbody>
            <c:set var="invo_mid_sum" value="0"/>
            <c:forEach items="${MisBscPtnr4}" var="kind4" varStatus="kind4Status">
                <c:set var="invo_mid_sum" value="${kind4.invo_basic+kind4.invo_daily}"/>
                <c:set var="invo_tot_sum" value="${invo_mid_sum+kind4.invo_traffic+kind4.invo_counsel+kind4.invo_etc}"/>

                <tr>
                    <c:if test="${kind4Status.first}">
                        <td rowspan="${MisBscPtnr4.size()}" style="font-weight:bold;background:#F8F8F8;">
                            4종
                        </td>
                    </c:if>
                    <td class="border-right"><!-- 보험사 -->
                            ${kind4.ptnr_nick}
                    </td>
                    <td><!-- 수임현황 - 당월 -->
                        <fmt:formatNumber value="${kind4.suim_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 수임현황 - 년누계 -->
                        <fmt:formatNumber value="${kind4.suim_y}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 종결현황 - 당월 -->
                        <fmt:formatNumber value="${kind4.close_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 종결현황 - 년누계 -->
                        <fmt:formatNumber value="${kind4.close_y}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 미결현황 -->
                        <fmt:formatNumber value="${kind4.suim_mi}" pattern="#,##0.###"/><br>
                    </td>
                    <%-- <td><!-- 종결평가 - 당월 -->
                        <fmt:formatNumber value="${kind4.report_ea_m}" pattern="#,##0.###"/><br>
                    </td>
                    <td class="border-right"><!-- 종결평가 - 년누계 -->
                        <fmt:formatNumber value="${kind4.report_ea_y}" pattern="#,##0.###"/><br>
                    </td> --%>
                    <td><!-- 인보이스  - 기본료 -->
                        <fmt:formatNumber value="${kind4.invo_basic}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 일비 -->
                        <fmt:formatNumber value="${kind4.invo_daily}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 소계(기본료+일비) -->
                        <fmt:formatNumber value="${invo_mid_sum}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 교통비 -->
                        <fmt:formatNumber value="${kind4.invo_traffic}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 자문료 -->
                        <fmt:formatNumber value="${kind4.invo_counsel}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 기타 -->
                        <fmt:formatNumber value="${kind4.invo_etc}" pattern="#,##0.###"/><br>
                    </td>
                    <td><!-- 인보이스  - 합계 -->
                        <fmt:formatNumber value="${invo_tot_sum}" pattern="#,##0.###"/><br>
                    </td>
                </tr>

                <c:set var="Sum4SuimM" value="${kind4.suim_m + Sum4SuimM}"/>
                <c:set var="Sum4SuimY" value="${kind4.suim_y + Sum4SuimY}"/>
                <c:set var="Sum4CloseM" value="${kind4.close_m + Sum4CloseM}"/>
                <c:set var="Sum4CloseY" value="${kind4.close_y + Sum4CloseY}"/>
                <c:set var="Sum4SuimMi" value="${kind4.suim_mi + Sum4SuimMi}"/>
                <c:set var="Sum4RptEaM" value="${kind4.report_ea_m + Sum4RptEaM}"/>
                <c:set var="Sum4RptEaY" value="${kind4.report_ea_y + Sum4RptEaY}"/>
                <c:set var="Sum4Basic" value="${kind4.invo_basic + Sum4Basic}"/>
                <c:set var="Sum4Daily" value="${kind4.invo_daily + Sum4Daily}"/>
                <c:set var="Sum4Mid" value="${invo_mid_sum + Sum4Mid}"/>
                <c:set var="Sum4Traffic" value="${kind4.invo_traffic + Sum4Traffic}"/>
                <c:set var="Sum4Counsel" value="${kind4.invo_counsel + Sum4Counsel}"/>
                <c:set var="Sum4Etc" value="${kind4.invo_etc + Sum4Etc}"/>
                <c:set var="Sum4Tot" value="${invo_tot_sum + Sum4Tot}"/>
            </c:forEach>
            <tr style="background:#e7ecf1;">
                <th class="border-right" colspan="2">4종 소계</th>
                <th><!-- 수임현황 - 당월 - 4종합 -->
                    <fmt:formatNumber value="${Sum4SuimM}" pattern="#,##0.###"/><br>
                </th>
                <th class="border-right"><!-- 수임현황 - 년누계 - 4종합 -->
                    <fmt:formatNumber value="${Sum4SuimY}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 종결현황 - 당월 - 4종합 -->
                    <fmt:formatNumber value="${Sum4CloseM}" pattern="#,##0.###"/><br>
                </th>
                <th class="border-right"><!-- 종결현황 - 년누계 - 4종합 -->
                    <fmt:formatNumber value="${Sum4CloseY}" pattern="#,##0.###"/><br>
                </th>
                <th class="border-right"><!-- 미결현황 - 4종합 -->
                    <fmt:formatNumber value="${Sum4SuimMi}" pattern="#,##0.###"/><br>
                </th>
                <%-- <th><!-- 종결평가 - 당월 - 4종합 -->
                    <fmt:formatNumber value="${Sum4RptEaM}" pattern="#,##0.###"/><br>
                </th>
                <th class="border-right"><!-- 종결평가 - 년누계 - 4종합 -->
                    <fmt:formatNumber value="${Sum4RptEaY}" pattern="#,##0.###"/><br>
                </th> --%>
                <th><!-- 인보이스 - 기본료 - 4종합 -->
                    <fmt:formatNumber value="${Sum4Basic}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 일비 - 4종합 -->
                    <fmt:formatNumber value="${Sum4Daily}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 소계 - 4종합 -->
                    <fmt:formatNumber value="${Sum4Mid}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 교통비 - 4종합 -->
                    <fmt:formatNumber value="${Sum4Traffic}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 자문료 - 4종합 -->
                    <fmt:formatNumber value="${Sum4Counsel}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 기타 - 4종합 -->
                    <fmt:formatNumber value="${Sum4Etc}" pattern="#,##0.###"/><br>
                </th>
                <th><!-- 인보이스 - 합계 - 4종합 -->
                    <fmt:formatNumber value="${Sum4Tot}" pattern="#,##0.###"/><br>
                </th>
            </tr>

            <tr style="background:#FFF;">
                <th style="color:blue;" class="border-right" colspan="2">합 계</th>
                <th style="color:blue;"><!-- 수임현황 - 당월 - 총합 -->
                    <fmt:formatNumber value="${Sum1SuimM+Sum1WrittenSuimM+Sum4SuimM}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" class="border-right"><!-- 수임현황 - 년누계 - 총합 -->
                    <fmt:formatNumber value="${Sum1SuimY+Sum1WrittenSuimY+Sum4SuimY}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" ><!-- 종결현황 - 당월 - 총합-->
                    <fmt:formatNumber value="${Sum1CloseM+Sum1WrittenCloseM+Sum4CloseM}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" class="border-right"><!-- 종결현황 - 년누계 - 총합 -->
                    <fmt:formatNumber value="${Sum1CloseY+Sum1WrittenCloseY+Sum4CloseY}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" class="border-right"><!-- 미결현황 - 총합 -->
                    <fmt:formatNumber value="${Sum1SuimMi+Sum1WrittenSuimMi+Sum4SuimMi}" pattern="#,##0.###"/><br>
                </th>
                <%-- <th style="color:blue;" ><!-- 종결평가 - 당월 - 총합 -->
                    <fmt:formatNumber value="${Sum1RptEaM+Sum1WrittenRptEaM+Sum4RptEaM}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" class="border-right"><!-- 종결평가 - 년누계 - 총합 -->
                    <fmt:formatNumber value="${Sum1RptEaY+Sum1WrittenRptEaY+Sum4RptEaY}" pattern="#,##0.###"/><br>
                </th> --%>
                <th style="color:blue;" ><!-- 인보이스 - 기본료 - 총합 -->
                    <fmt:formatNumber value="${Sum1Basic+Sum1WrittenBasic+Sum4Basic}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" ><!-- 인보이스 - 일비 - 총합 -->
                    <fmt:formatNumber value="${Sum1Daily+Sum1WrittenDaily+Sum4Daily}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" ><!-- 인보이스 - 소계 - 총합 -->
                    <fmt:formatNumber value="${Sum1Mid+Sum1WrittenMid+Sum4Mid}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" ><!-- 인보이스 - 교통비 - 총합 -->
                    <fmt:formatNumber value="${Sum1Traffic+Sum1WrittenTraffic+Sum4Traffic}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" ><!-- 인보이스 - 자문료 - 총합 -->
                    <fmt:formatNumber value="${Sum1Counsel+Sum1WrittenCounsel+Sum4Counsel}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" ><!-- 인보이스 - 기타 - 총합 -->
                    <fmt:formatNumber value="${Sum1Etc+Sum1WrittenEtc+Sum4Etc}" pattern="#,##0.###"/><br>
                </th>
                <th style="color:blue;" ><!-- 인보이스 - 합계 - 총합 -->
                    <fmt:formatNumber value="${Sum1Tot+Sum1WrittenTot+Sum4Tot}" pattern="#,##0.###"/><br>
                </th>
            </tr>

            </tbody>
        </table>
    </div>
</div>
