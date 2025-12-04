<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="tableStyle2">
    <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
        <colgroup>
            <col width="60">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
        </colgroup>
        <tr>
            <th rowspan="4"><span style="color: black;">구분</span></th>
            <th rowspan="4"><span style="color: black;">접수번호</span></th>
            <th colspan="14">공동수행자의 비율 및 금액을 반영한 결과</th>
        </tr>
        <tr>
            <th colspan="14">인보이스 현황<span style="color: red">(당월)</span></th>
        </tr>
        <tr>
            <th rowspan="2">기본료</th>
            <th rowspan="2">일비</th>
            <th rowspan="2">건</th>
            <th colspan="3">공동수행지급</th>
            <th colspan="3">공동수행수령</th>
            <th rowspan="2">소계</th>
            <th rowspan="2">교통비</th>
            <th rowspan="2">자문료</th>
            <th rowspan="2">기타</th>
            <th rowspan="2">합계</th>
        </tr>
        <tr>
            <th>기본료</th>
            <th>일비</th>
            <th>건</th>
            <th>기본료</th>
            <th>일비</th>
            <th>건</th>
        </tr>
        <c:set var="total_amtBasic" value="0"/>
        <c:set var="total_amtDaily" value="0"/>
        <fmt:formatNumber var="total_suimRptEa" value="0" pattern="#.##"/>
        <c:set var="total_shareMinusAmtBasic" value="0"/>
        <c:set var="total_shareMinusAmtDaily" value="0"/>
        <fmt:formatNumber var="total_shareMinusEa" value="0" pattern="#.##"/>
        <c:set var="total_sharePlusAmtBasic" value="0"/>
        <c:set var="total_sharePlusAmtDaily" value="0"/>
        <fmt:formatNumber var="total_sharePlusEa" value="0" pattern="#.##"/>
        <c:set var="total_subTotal" value="0"/>
        <c:set var="total_amtTraffic" value="0"/>
        <c:set var="total_amtCounsel" value="0"/>
        <c:set var="total_amtEtc" value="0"/>
        <c:set var="total_rowTotal" value="0"/>

        <c:forEach  var="item" items="${contList}" varStatus="status">
            <tr>
                <td>
                    <c:if test="${item.gubun == 1}"><span style="color: blue">본인 담당건</span></c:if>
                    <c:if test="${item.gubun == 2}"><span style="color: red">공동 수행건</span></c:if>
                </td>
                <td><a href="#noloc" onclick="fnPopSuimDtlPrim('${item.suimRptNo}')">${item.suimAcceptNo}</a></td>
                <td class="right"><fmt:formatNumber value="${item.amtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.suimRptEa}" pattern="#,###.##"/></td>
                <td class="right"><fmt:formatNumber value="${item.shareMinusAmtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.shareMinusAmtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.shareMinusEa}" pattern="#,###.##"/></td>
                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.sharePlusEa}" pattern="#,###.##"/></td>
                <td class="right">
                    <c:set var="subTotal" value="${item.amtBasic + item.amtDaily - item.shareMinusAmtBasic - item.shareMinusAmtDaily + item.sharePlusAmtBasic + item.sharePlusAmtDaily}"/>
                    <fmt:formatNumber value="${subTotal}" pattern="#,###"/>
                </td>
                <td class="right"><fmt:formatNumber value="${item.amtTraffic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtCounsel}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtEtc}" pattern="#,###"/></td>
                <td class="right">
                    <c:set var="rowTotal" value="${subTotal + item.amtTraffic + item.amtCounsel + item.amtEtc}"/>
                    <fmt:formatNumber value="${rowTotal}" pattern="#,###"/>
                </td>
            </tr>
            <c:set var="total_amtBasic" value="${total_amtBasic + item.amtBasic}"/>
            <c:set var="total_amtDaily" value="${total_amtDaily + item.amtDaily}"/>

            <fmt:formatNumber var="total_suimRptEa" value="${total_suimRptEa + item.suimRptEa}" pattern="#.##"/>


            <c:set var="total_shareMinusAmtBasic" value="${total_shareMinusAmtBasic + item.shareMinusAmtBasic}"/>
            <c:set var="total_shareMinusAmtDaily" value="${total_shareMinusAmtDaily + item.shareMinusAmtDaily}"/>

            <fmt:formatNumber var="total_shareMinusEa" value="${total_shareMinusEa + item.shareMinusEa}" pattern="#.##"/>

            <c:set var="total_sharePlusAmtBasic" value="${total_sharePlusAmtBasic + item.sharePlusAmtBasic}"/>
            <c:set var="total_sharePlusAmtDaily" value="${total_sharePlusAmtDaily + item.sharePlusAmtDaily}"/>

            <fmt:formatNumber var="total_sharePlusEa" value="${total_sharePlusEa + item.sharePlusEa}" pattern="#.##"/>

            <c:set var="total_subTotal" value="${total_subTotal + subTotal}"/>
            <c:set var="total_amtTraffic" value="${total_amtTraffic + item.amtTraffic}"/>
            <c:set var="total_amtCounsel" value="${total_amtCounsel + item.amtCounsel}"/>
            <c:set var="total_amtEtc" value="${total_amtEtc + item.amtEtc}"/>
            <c:set var="total_rowTotal" value="${total_rowTotal + rowTotal}"/>
        </c:forEach>
        <tr>
            <th colspan="2">합계</th>
            <th class="right"><fmt:formatNumber value="${total_amtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_amtDaily}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_suimRptEa}" pattern="#,###.##"/></th>
            <th class="right"><fmt:formatNumber value="${total_shareMinusAmtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_shareMinusAmtDaily}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_shareMinusEa}" pattern="#,###.##"/></th>
            <th class="right"><fmt:formatNumber value="${total_sharePlusAmtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_sharePlusAmtDaily}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_sharePlusEa}" pattern="#,###.##"/></th>
            <th class="right"><fmt:formatNumber value="${total_subTotal}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_amtTraffic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_amtCounsel}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_amtEtc}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_rowTotal}" pattern="#,###"/></th>
        </tr>
    </table>
</div>
<!-- 미수금 내역 -->
<table align="center" cellpadding="0" cellspacing="0" width="1060">
    <tr>
        <td width="100%" height="30">
            <p><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0"> <b><font color="black">미수금내역</font></b></p>
        </td>
    </tr>
</table>
<div class="tableStyle2">
    <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
        <colgroup>
            <col width="60">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
        </colgroup>
        <tr>
            <th>NO</th>
            <th>보험사</th>
            <th>접수번호</th>
            <th>계약자</th>
            <th>피보험자</th>
            <th>종결일</th>
            <th>기본보수</th>
            <th>일비</th>
            <th>교통비</th>
            <th>자문료</th>
            <th>기타</th>
            <th>미수금</th>
        </tr>
        <c:set var="cnt" value="${contOutAmtList.size()}"/>
        <c:set var="oTotal_amtBasic" value="0"/>
        <c:set var="oTotal_amtDaily" value="0"/>
        <c:set var="oTotal_amtTraffic" value="0"/>
        <c:set var="oTotal_amtCounsel" value="0"/>
        <c:set var="oTotal_amtEtc" value="0"/>
        <c:set var="oTotal_outAmt" value="0"/>
        <c:forEach  var="item" items="${contOutAmtList}" varStatus="status">
            <tr>
                <td>${cnt - status.index}</td>
                <td>${item.ptnrNm}</td>
                <td><a href="#noloc" onclick="fnPopSuimDtlPrim('${item.suimRptNo}')">${item.suimAcceptNo}</a></td>
                <td>${item.policyholderNm}</td>
                <td>${item.beneficiaryNm}</td>
                <td>${item.closeDate}</td>
                <td class="right"><fmt:formatNumber value="${item.amtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtTraffic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtCounsel}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtEtc}" pattern="#,###"/></td>
                <td class="right">
                    <span style="color: red;"><fmt:formatNumber value="${item.outAmt}" pattern="#,###"/></span>
                </td>
            </tr>
            <c:set var="oTotal_amtBasic" value="${oTotal_amtBasic + item.amtBasic}"/>
            <c:set var="oTotal_amtDaily" value="${oTotal_amtDaily + item.amtDaily}"/>
            <c:set var="oTotal_amtTraffic" value="${oTotal_amtTraffic + item.amtTraffic}"/>
            <c:set var="oTotal_amtCounsel" value="${oTotal_amtCounsel + item.amtCounsel}"/>
            <c:set var="oTotal_amtEtc" value="${oTotal_amtEtc + item.amtEtc}"/>
            <c:set var="oTotal_outAmt" value="${oTotal_outAmt + item.outAmt}"/>
        </c:forEach>
        <tr>
            <th colspan="6">미수금 합계</th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtDaily}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtTraffic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtCounsel}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtEtc}" pattern="#,###"/></th>
            <th class="right">
                <span style="color: red;"><fmt:formatNumber value="${oTotal_outAmt}" pattern="#,###"/></span>
            </th>
        </tr>
    </table>
</div>
