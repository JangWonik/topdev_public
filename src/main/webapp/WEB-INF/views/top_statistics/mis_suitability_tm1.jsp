<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2" id="dataTable">
    <div style="padding-right: 20px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" summary="팀 기본통계 1종">
            <caption>팀 기본통계</caption>
            <colgroup>
                <col width="65">
                <col width="130">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="80">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="80">
            </colgroup>
            <thead>
            <tr align="center" bgcolor="#EFEFEF">
                <td class="td" nowrap rowspan="3"><B>Type</B></td>
                <td class="td" nowrap rowspan="3"><B>팀</B></td>
                <td class="td" nowrap rowspan="2" colspan="2"><B>수임현황</B></td>
                <td class="td" nowrap colspan="6">종결현황</td>
                <td class="td" nowrap rowspan="3">미결현황</td>
                <td class="td" nowrap rowspan="2" colspan="3">지급</td>
            </tr>
            <tr align="center" bgcolor="#EFEFEF">
                <td class="td" nowrap colspan="2">조사 완료</td>
                <td class="td" nowrap colspan="2">조사 실패</td>
                <td class="td" nowrap colspan="2">합계</td>
            </tr>
            <tr align="center" bgcolor="#EFEFEF">
                <td class="td" nowrap>당월</td>
                <td class="td" nowrap>년누계</td>
                <td class="td" nowrap>당월</td>
                <td class="td" nowrap>년누계</td>
                <td class="td" nowrap>당월</td>
                <td class="td" nowrap>년누계</td>
                <td class="td" nowrap>당월</td>
                <td class="td" nowrap>년누계</td>
                <td class="td" nowrap>일반</td>
                <td class="td" nowrap>공장</td>
                <td class="td" nowrap>합계</td>
            </tr>
            </thead>
        </table>
    </div>
    <div style="height:566px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" summary="팀 기본통계 1종">
            <caption>팀 기본통계</caption>
            <colgroup>
                <col width="65">
                <col width="130">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="80">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="80">
            </colgroup>
            <tbody>
            <c:forEach var="vo" items="${getMisSuitabilityTm1}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getMisSuitabilityTm1.size()}">1종</td>
                    </c:if>
                    <td><p><a href="javascript:goMisSuitabilityTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.team_name}</a></p></td>
                    <td><fmt:formatNumber value="${vo.reg_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.reg_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_m_fail}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_y_fail}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_sum_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_sum_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_mi}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_a}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_b}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum}" pattern="#,##0.##"/></td>

                    <c:set var="sumReg_m1" value="${vo.reg_m + sumReg_m1}" />
                    <c:set var="sumReg_y1" value="${vo.reg_y + sumReg_y1}" />
                    <c:set var="sumEnd_m1" value="${vo.end_m + sumEnd_m1}" />
                    <c:set var="sumEnd_y1" value="${vo.end_y + sumEnd_y1}" />
                    <c:set var="sumEnd_m_fail1" value="${vo.end_m_fail + sumEnd_m_fail1}" />
                    <c:set var="sumEnd_y_fail1" value="${vo.end_y_fail + sumEnd_y_fail1}" />
                    <c:set var="sumEnd_sum_m1" value="${vo.end_sum_m + sumEnd_sum_m1}" />
                    <c:set var="sumEnd_sum_y1" value="${vo.end_sum_y + sumEnd_sum_y1}" />
                    <c:set var="sumEnd_mi1" value="${vo.end_mi + sumEnd_mi1}" />
                    <c:set var="sumPrice_a1" value="${vo.price_a + sumPrice_a1}" />
                    <c:set var="sumPrice_b1" value="${vo.price_b + sumPrice_b1}" />
                    <c:set var="sumPrice_sum1" value="${vo.price_sum + sumPrice_sum1}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 합계</td>
                <td><fmt:formatNumber value="${sumReg_m1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumReg_y1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_m1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_y1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_m_fail1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_y_fail1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_sum_m1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_sum_y1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_mi1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_a1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_b1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum1}" pattern="#,##0.##"/></td>
            </tr>
            <c:forEach var="vo" items="${getMisSuitabilityTm4}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getMisSuitabilityTm4.size()}">4종</td>
                    </c:if>
                    <td><p><a href="javascript:goMisSuitabilityTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.team_name}</a></p></td>
                    <td><fmt:formatNumber value="${vo.reg_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.reg_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_m_fail}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_y_fail}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_sum_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_sum_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_mi}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_a}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_b}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum}" pattern="#,##0.##"/></td>

                    <c:set var="sumReg_m4" value="${vo.reg_m + sumReg_m4}" />
                    <c:set var="sumReg_y4" value="${vo.reg_y + sumReg_y4}" />
                    <c:set var="sumEnd_m4" value="${vo.end_m + sumEnd_m4}" />
                    <c:set var="sumEnd_y4" value="${vo.end_y + sumEnd_y4}" />
                    <c:set var="sumEnd_m_fail4" value="${vo.end_m_fail + sumEnd_m_fail4}" />
                    <c:set var="sumEnd_y_fail4" value="${vo.end_y_fail + sumEnd_y_fail4}" />
                    <c:set var="sumEnd_sum_m4" value="${vo.end_sum_m + sumEnd_sum_m4}" />
                    <c:set var="sumEnd_sum_y4" value="${vo.end_sum_y + sumEnd_sum_y4}" />
                    <c:set var="sumEnd_mi4" value="${vo.end_mi + sumEnd_mi4}" />
                    <c:set var="sumPrice_a4" value="${vo.price_a + sumPrice_a4}" />
                    <c:set var="sumPrice_b4" value="${vo.price_b + sumPrice_b4}" />
                    <c:set var="sumPrice_sum4" value="${vo.price_sum + sumPrice_sum4}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">4종 합계</td>
                <td><fmt:formatNumber value="${sumReg_m4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumReg_y4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_m4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_y4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_m_fail4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_y_fail4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_sum_m4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_sum_y4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_mi4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_a4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_b4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum4}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">합계</td>
                <td><fmt:formatNumber value="${sumReg_m1+sumReg_m4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumReg_y1+sumReg_y4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_m1+sumEnd_m4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_y1+sumEnd_y4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_m_fail1+sumEnd_m_fail4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_y_fail1+sumEnd_y_fail4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_sum_m1+sumEnd_sum_m4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_sum_y1+sumEnd_sum_y4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_mi1+sumEnd_mi4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_a1+sumPrice_a4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_b1+sumPrice_b4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum1+sumPrice_sum4}" pattern="#,##0.##"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
