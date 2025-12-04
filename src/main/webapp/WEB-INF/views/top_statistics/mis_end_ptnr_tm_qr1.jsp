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
            <c:forEach var="vo" items="${MisEndPtnrTmQr1}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTmQr1.size() + 1}">1종</td>
                    </c:if>
                    <td style="width: 150px;">${vo.center_name}</td>
                    <td style="width: 150px;">${vo.team_name}</td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr12+vo.price_qr11+vo.price_qr10+vo.price_qr9+vo.price_qr8+vo.price_qr7+vo.price_qr6+vo.price_qr5+vo.price_qr4+vo.price_qr3+vo.price_qr2+vo.price_qr}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPrice_qr12" value="${sumPrice_qr12 + vo.price_qr12}" />
                <c:set var="sumPrice_qr11" value="${sumPrice_qr11 + vo.price_qr11}" />
                <c:set var="sumPrice_qr10" value="${sumPrice_qr10 + vo.price_qr10}" />
                <c:set var="sumPrice_qr9" value="${sumPrice_qr9 + vo.price_qr9}" />
                <c:set var="sumPrice_qr8" value="${sumPrice_qr8 + vo.price_qr8}" />
                <c:set var="sumPrice_qr7" value="${sumPrice_qr7 + vo.price_qr7}" />
                <c:set var="sumPrice_qr6" value="${sumPrice_qr6 + vo.price_qr6}" />
                <c:set var="sumPrice_qr5" value="${sumPrice_qr5 + vo.price_qr5}" />
                <c:set var="sumPrice_qr4" value="${sumPrice_qr4 + vo.price_qr4}" />
                <c:set var="sumPrice_qr3" value="${sumPrice_qr3 + vo.price_qr3}" />
                <c:set var="sumPrice_qr2" value="${sumPrice_qr2 + vo.price_qr2}" />
                <c:set var="sumPrice_qr" value="${sumPrice_qr + vo.price_qr}" />
                <c:set var="sumPrice_qr_sum" value="${sumPrice_qr_sum + vo.price_qr12+vo.price_qr11+vo.price_qr10+vo.price_qr9+vo.price_qr8+vo.price_qr7+vo.price_qr6+vo.price_qr5+vo.price_qr4+vo.price_qr3+vo.price_qr2+vo.price_qr}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 소계</td>
                <td><fmt:formatNumber value="${sumPrice_qr12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr_sum}" pattern="#,##0.##"/></td>
            </tr>
            <c:forEach var="vo" items="${MisEndPtnrTmQr4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTmQr4.size() + 1}">4종</td>
                    </c:if>
                    <td>${vo.team_name}</td>
                        <%-- 												<td><a href="javascript:goMisRegTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">개인별</a></td> --%>
                    <!-- 												<td>보험사별</td> -->
                    <td>
                        <fmt:formatNumber value="${vo.price_qr12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_qr12+vo.price_qr11+vo.price_qr10+vo.price_qr9+vo.price_qr8+vo.price_qr7+vo.price_qr6+vo.price_qr5+vo.price_qr4+vo.price_qr3+vo.price_qr2+vo.price_qr}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPrice4_qr12" value="${sumPrice4_qr12 + vo.price_qr12}" />
                <c:set var="sumPrice4_qr11" value="${sumPrice4_qr11 + vo.price_qr11}" />
                <c:set var="sumPrice4_qr10" value="${sumPrice4_qr10 + vo.price_qr10}" />
                <c:set var="sumPrice4_qr9" value="${sumPrice4_qr9 + vo.price_qr9}" />
                <c:set var="sumPrice4_qr8" value="${sumPrice4_qr8 + vo.price_qr8}" />
                <c:set var="sumPrice4_qr7" value="${sumPrice4_qr7 + vo.price_qr7}" />
                <c:set var="sumPrice4_qr6" value="${sumPrice4_qr6 + vo.price_qr6}" />
                <c:set var="sumPrice4_qr5" value="${sumPrice4_qr5 + vo.price_qr5}" />
                <c:set var="sumPrice4_qr4" value="${sumPrice4_qr4 + vo.price_qr4}" />
                <c:set var="sumPrice4_qr3" value="${sumPrice4_qr3 + vo.price_qr3}" />
                <c:set var="sumPrice4_qr2" value="${sumPrice4_qr2 + vo.price_qr2}" />
                <c:set var="sumPrice4_qr" value="${sumPrice4_qr + vo.price_qr}" />
                <c:set var="sumPrice4_qr_sum" value="${sumPrice4_qr_sum + vo.price_qr12+vo.price_qr11+vo.price_qr10+vo.price_qr9+vo.price_qr8+vo.price_qr7+vo.price_qr6+vo.price_qr5+vo.price_qr4+vo.price_qr3+vo.price_qr2+vo.price_qr}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">4종 소계</td>
                <td><fmt:formatNumber value="${sumPrice4_qr12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice4_qr_sum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="3">합계</td>
                <td><fmt:formatNumber value="${sumPrice_qr12 + sumPrice4_qr12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr11 + sumPrice4_qr11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr10 + sumPrice4_qr10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr9 + sumPrice4_qr9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr8 + sumPrice4_qr8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr7 + sumPrice4_qr7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr6 + sumPrice4_qr6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr5 + sumPrice4_qr5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr4 + sumPrice4_qr4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr3 + sumPrice4_qr3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr2 + sumPrice4_qr2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr + sumPrice4_qr}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_qr_sum + sumPrice4_qr_sum}" pattern="#,##0.##"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
