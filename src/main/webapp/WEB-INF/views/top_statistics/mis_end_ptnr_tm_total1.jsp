<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <thead>
            <tr>
                <th>Type</th>
                <th style="width: 150px;">센터</th>
                <th style="width: 150px;">부서</th>
                <th>${nowVO.monBefore11.substring(0,7)}</th>
                <th>${nowVO.monBefore10.substring(0,7)}</th>
                <th>${nowVO.monBefore9.substring(0,7)}</th>
                <th>${nowVO.monBefore8.substring(0,7)}</th>
                <th>${nowVO.monBefore7.substring(0,7)}</th>
                <th>${nowVO.monBefore6.substring(0,7)}</th>
                <th>${nowVO.monBefore5.substring(0,7)}</th>
                <th>${nowVO.monBefore4.substring(0,7)}</th>
                <th>${nowVO.monBefore3.substring(0,7)}</th>
                <th>${nowVO.monBefore2.substring(0,7)}</th>
                <th>${nowVO.monBefore1.substring(0,7)}</th>
                <th>${nowVO.monBefore0.substring(0,7)}</th>
                <th>합계</th>
            </tr>
            </thead>
        </table>
    </div>
    <div style="height:634px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <tbody>
            <c:forEach var="vo" items="${MisEndPtnrTmTotal1}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTmTotal1.size() + 1}">1종</td>
                    </c:if>
                    <td style="width: 150px;">${vo.center_name}</td>
                    <td style="width: 150px;">${vo.team_name}</td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total12+vo.price_total11+vo.price_total10+vo.price_total9+vo.price_total8+vo.price_total7+vo.price_total6+vo.price_total5+vo.price_total4+vo.price_total3+vo.price_total2+vo.price_total}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPrice_total12" value="${sumPrice_total12 + vo.price_total12}" />
                <c:set var="sumPrice_total11" value="${sumPrice_total11 + vo.price_total11}" />
                <c:set var="sumPrice_total10" value="${sumPrice_total10 + vo.price_total10}" />
                <c:set var="sumPrice_total9" value="${sumPrice_total9 + vo.price_total9}" />
                <c:set var="sumPrice_total8" value="${sumPrice_total8 + vo.price_total8}" />
                <c:set var="sumPrice_total7" value="${sumPrice_total7 + vo.price_total7}" />
                <c:set var="sumPrice_total6" value="${sumPrice_total6 + vo.price_total6}" />
                <c:set var="sumPrice_total5" value="${sumPrice_total5 + vo.price_total5}" />
                <c:set var="sumPrice_total4" value="${sumPrice_total4 + vo.price_total4}" />
                <c:set var="sumPrice_total3" value="${sumPrice_total3 + vo.price_total3}" />
                <c:set var="sumPrice_total2" value="${sumPrice_total2 + vo.price_total2}" />
                <c:set var="sumPrice_total" value="${sumPrice_total + vo.price_total}" />
                <c:set var="sumPrice_total_sum" value="${sumPrice_total_sum + vo.price_total12+vo.price_total11+vo.price_total10+vo.price_total9+vo.price_total8+vo.price_total7+vo.price_total6+vo.price_total5+vo.price_total4+vo.price_total3+vo.price_total2+vo.price_total}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 소계</td>
                <td><fmt:formatNumber value="${sumPrice_total12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total_sum}" pattern="#,##0.##"/></td>
            </tr>
            <c:forEach var="vo" items="${MisEndPtnrTmTotal4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTmTotal4.size() + 1}">4종</td>
                    </c:if>
                    <td>${vo.center_name}</td>
                    <td>${vo.team_name}</td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_total12+vo.price_total11+vo.price_total10+vo.price_total9+vo.price_total8+vo.price_total7+vo.price_total6+vo.price_total5+vo.price_total4+vo.price_total3+vo.price_total2+vo.price_total}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPrice4_total12" value="${sumPrice4_total12 + vo.price_total12}" />
                <c:set var="sumPrice4_total11" value="${sumPrice4_total11 + vo.price_total11}" />
                <c:set var="sumPrice4_total10" value="${sumPrice4_total10 + vo.price_total10}" />
                <c:set var="sumPrice4_total9" value="${sumPrice4_total9 + vo.price_total9}" />
                <c:set var="sumPrice4_total8" value="${sumPrice4_total8 + vo.price_total8}" />
                <c:set var="sumPrice4_total7" value="${sumPrice4_total7 + vo.price_total7}" />
                <c:set var="sumPrice4_total6" value="${sumPrice4_total6 + vo.price_total6}" />
                <c:set var="sumPrice4_total5" value="${sumPrice4_total5 + vo.price_total5}" />
                <c:set var="sumPrice4_total4" value="${sumPrice4_total4 + vo.price_total4}" />
                <c:set var="sumPrice4_total3" value="${sumPrice4_total3 + vo.price_total3}" />
                <c:set var="sumPrice4_total2" value="${sumPrice4_total2 + vo.price_total2}" />
                <c:set var="sumPrice4_total" value="${sumPrice4_total + vo.price_total}" />
                <c:set var="sumPrice4_total_sum" value="${sumPrice4_total_sum + vo.price_total12+vo.price_total11+vo.price_total10+vo.price_total9+vo.price_total8+vo.price_total7+vo.price_total6+vo.price_total5+vo.price_total4+vo.price_total3+vo.price_total2+vo.price_total}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">4종 소계</td>
                <td><fmt:formatNumber value="${sumPrice4_total12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_total_sum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="3">합계</td>
                <td><fmt:formatNumber value="${sumPrice_total12 + sumPrice4_total12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total11 + sumPrice4_total11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total10 + sumPrice4_total10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total9 + sumPrice4_total9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total8 + sumPrice4_total8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total7 + sumPrice4_total7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total6 + sumPrice4_total6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total5 + sumPrice4_total5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total4 + sumPrice4_total4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total3 + sumPrice4_total3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total2 + sumPrice4_total2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total + sumPrice4_total}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_total_sum + sumPrice4_total_sum}" pattern="#,##0.##"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
