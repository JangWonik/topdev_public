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
            <c:forEach var="vo" items="${MisEndPtnrTmTraffic1}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTmTraffic1.size() + 1}">1종</td>
                    </c:if>
                    <td style="width: 150px;">${vo.center_name}</td>
                    <td style="width: 150px;">${vo.team_name}</td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic12+vo.price_traffic11+vo.price_traffic10+vo.price_traffic9+vo.price_traffic8+vo.price_traffic7+vo.price_traffic6+vo.price_traffic5+vo.price_traffic4+vo.price_traffic3+vo.price_traffic2+vo.price_traffic}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPrice_traffic12" value="${sumPrice_traffic12 + vo.price_traffic12}" />
                <c:set var="sumPrice_traffic11" value="${sumPrice_traffic11 + vo.price_traffic11}" />
                <c:set var="sumPrice_traffic10" value="${sumPrice_traffic10 + vo.price_traffic10}" />
                <c:set var="sumPrice_traffic9" value="${sumPrice_traffic9 + vo.price_traffic9}" />
                <c:set var="sumPrice_traffic8" value="${sumPrice_traffic8 + vo.price_traffic8}" />
                <c:set var="sumPrice_traffic7" value="${sumPrice_traffic7 + vo.price_traffic7}" />
                <c:set var="sumPrice_traffic6" value="${sumPrice_traffic6 + vo.price_traffic6}" />
                <c:set var="sumPrice_traffic5" value="${sumPrice_traffic5 + vo.price_traffic5}" />
                <c:set var="sumPrice_traffic4" value="${sumPrice_traffic4 + vo.price_traffic4}" />
                <c:set var="sumPrice_traffic3" value="${sumPrice_traffic3 + vo.price_traffic3}" />
                <c:set var="sumPrice_traffic2" value="${sumPrice_traffic2 + vo.price_traffic2}" />
                <c:set var="sumPrice_traffic" value="${sumPrice_traffic + vo.price_traffic}" />
                <c:set var="sumPrice_traffic_sum" value="${sumPrice_traffic_sum + vo.price_traffic12+vo.price_traffic11+vo.price_traffic10+vo.price_traffic9+vo.price_traffic8+vo.price_traffic7+vo.price_traffic6+vo.price_traffic5+vo.price_traffic4+vo.price_traffic3+vo.price_traffic2+vo.price_traffic}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 소계</td>
                <td><fmt:formatNumber value="${sumPrice_traffic12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic_sum}" pattern="#,##0.##"/></td>
            </tr>
            <c:forEach var="vo" items="${MisEndPtnrTmTraffic4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTmTraffic4.size() + 1}">4종</td>
                    </c:if>
                    <td>${vo.team_name}</td>
                        <%-- 												<td><a href="javascript:goMisRegTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">개인별</a></td> --%>
                    <!-- 												<td>보험사별</td> -->
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_traffic12+vo.price_traffic11+vo.price_traffic10+vo.price_traffic9+vo.price_traffic8+vo.price_traffic7+vo.price_traffic6+vo.price_traffic5+vo.price_traffic4+vo.price_traffic3+vo.price_traffic2+vo.price_traffic}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPrice4_traffic12" value="${sumPrice4_traffic12 + vo.price_traffic12}" />
                <c:set var="sumPrice4_traffic11" value="${sumPrice4_traffic11 + vo.price_traffic11}" />
                <c:set var="sumPrice4_traffic10" value="${sumPrice4_traffic10 + vo.price_traffic10}" />
                <c:set var="sumPrice4_traffic9" value="${sumPrice4_traffic9 + vo.price_traffic9}" />
                <c:set var="sumPrice4_traffic8" value="${sumPrice4_traffic8 + vo.price_traffic8}" />
                <c:set var="sumPrice4_traffic7" value="${sumPrice4_traffic7 + vo.price_traffic7}" />
                <c:set var="sumPrice4_traffic6" value="${sumPrice4_traffic6 + vo.price_traffic6}" />
                <c:set var="sumPrice4_traffic5" value="${sumPrice4_traffic5 + vo.price_traffic5}" />
                <c:set var="sumPrice4_traffic4" value="${sumPrice4_traffic4 + vo.price_traffic4}" />
                <c:set var="sumPrice4_traffic3" value="${sumPrice4_traffic3 + vo.price_traffic3}" />
                <c:set var="sumPrice4_traffic2" value="${sumPrice4_traffic2 + vo.price_traffic2}" />
                <c:set var="sumPrice4_traffic" value="${sumPrice4_traffic + vo.price_traffic}" />
                <c:set var="sumPrice4_traffic_sum" value="${sumPrice4_traffic_sum + vo.price_traffic12+vo.price_traffic11+vo.price_traffic10+vo.price_traffic9+vo.price_traffic8+vo.price_traffic7+vo.price_traffic6+vo.price_traffic5+vo.price_traffic4+vo.price_traffic3+vo.price_traffic2+vo.price_traffic}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">4종 소계</td>
                <td><fmt:formatNumber value="${sumPrice4_traffic12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_traffic_sum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="3">합계</td>
                <td><fmt:formatNumber value="${sumPrice_traffic12 + sumPrice4_traffic12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic11 + sumPrice4_traffic11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic10 + sumPrice4_traffic10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic9 + sumPrice4_traffic9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic8 + sumPrice4_traffic8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic7 + sumPrice4_traffic7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic6 + sumPrice4_traffic6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic5 + sumPrice4_traffic5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic4 + sumPrice4_traffic4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic3 + sumPrice4_traffic3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic2 + sumPrice4_traffic2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic + sumPrice4_traffic}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic_sum + sumPrice4_traffic_sum}" pattern="#,##0.##"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
