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
                <th style="width: 150px;">보험사</th>
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
            <!-- 1종 조사 시작 -->
            <c:forEach var="vo" items="${MisEndPtnrTraffic1Main}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmTraffic');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTraffic1Main.size()}">1종 조사</td>
                    </c:if>
                    <td style="width: 150px;">
                    	${vo.ptnr_nick}
                   	</td>
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
                <td colspan="2">1종 조사 소계</td>
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
            <!-- 1종 조사 끝 -->
            
            <!-- 1종 심사 시작 -->
            <c:forEach var="vo" items="${MisEndPtnrTraffic1Written}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmTraffic');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTraffic1Written.size()}">1종 심사</td>
                    </c:if>
                    <td style="width: 150px;">
                    	${vo.ptnr_nick}
                   	</td>
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
                <c:set var="sumPriceWritten_traffic12" value="${sumPriceWritten_traffic12 + vo.price_traffic12}" />
                <c:set var="sumPriceWritten_traffic11" value="${sumPriceWritten_traffic11 + vo.price_traffic11}" />
                <c:set var="sumPriceWritten_traffic10" value="${sumPriceWritten_traffic10 + vo.price_traffic10}" />
                <c:set var="sumPriceWritten_traffic9" value="${sumPriceWritten_traffic9 + vo.price_traffic9}" />
                <c:set var="sumPriceWritten_traffic8" value="${sumPriceWritten_traffic8 + vo.price_traffic8}" />
                <c:set var="sumPriceWritten_traffic7" value="${sumPriceWritten_traffic7 + vo.price_traffic7}" />
                <c:set var="sumPriceWritten_traffic6" value="${sumPriceWritten_traffic6 + vo.price_traffic6}" />
                <c:set var="sumPriceWritten_traffic5" value="${sumPriceWritten_traffic5 + vo.price_traffic5}" />
                <c:set var="sumPriceWritten_traffic4" value="${sumPriceWritten_traffic4 + vo.price_traffic4}" />
                <c:set var="sumPriceWritten_traffic3" value="${sumPriceWritten_traffic3 + vo.price_traffic3}" />
                <c:set var="sumPriceWritten_traffic2" value="${sumPriceWritten_traffic2 + vo.price_traffic2}" />
                <c:set var="sumPriceWritten_traffic" value="${sumPriceWritten_traffic + vo.price_traffic}" />
                <c:set var="sumPriceWritten_traffic_sum" value="${sumPriceWritten_traffic_sum + vo.price_traffic12+vo.price_traffic11+vo.price_traffic10+vo.price_traffic9+vo.price_traffic8+vo.price_traffic7+vo.price_traffic6+vo.price_traffic5+vo.price_traffic4+vo.price_traffic3+vo.price_traffic2+vo.price_traffic}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 심사 소계</td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_traffic_sum}" pattern="#,##0.##"/></td>
            </tr>
            <!-- 1종 심사 끝 -->
            
            <!-- 1종 소계 시작 -->
            <tr bgcolor="#E7ECF1">
                <th colspan="2">1종 소계</th>
                <th><fmt:formatNumber value="${sumPrice_traffic12 + sumPriceWritten_traffic12}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic11 + sumPriceWritten_traffic11}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic10 + sumPriceWritten_traffic10}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic9 + sumPriceWritten_traffic9}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic8 + sumPriceWritten_traffic8}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic7 + sumPriceWritten_traffic7}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic6 + sumPriceWritten_traffic6}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic5 + sumPriceWritten_traffic5}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic4 + sumPriceWritten_traffic4}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic3 + sumPriceWritten_traffic3}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic2 + sumPriceWritten_traffic2}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic + sumPriceWritten_traffic}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_traffic_sum + sumPriceWritten_traffic_sum}" pattern="#,##0.##"/></th>
            </tr>
            <!-- 1종 소계 끝 -->
            
            <c:forEach var="vo" items="${MisEndPtnrTraffic4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmQr');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTraffic4.size()}">4종</td>
                    </c:if>
                    <td>
                    	${vo.ptnr_nick}
                   	</td>
                        <%--	<td><a href="javascript:goMisRegTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">개인별</a></td> --%>
                    <!-- <td>보험사별</td> -->
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
                <th colspan="2">4종 소계</th>
                <th><fmt:formatNumber value="${sumPrice4_traffic12}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic11}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic10}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic9}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic8}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic7}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic6}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic5}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic4}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic3}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic2}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_traffic_sum}" pattern="#,##0.##"/></th>
            </tr>
            <tr bgcolor="#E7ECF1">
                <th style="color:blue;" colspan="2">합 계</th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic12 + sumPriceWritten_traffic12 + sumPrice4_traffic12}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic11 + sumPriceWritten_traffic11 + sumPrice4_traffic11}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic10 + sumPriceWritten_traffic10 + sumPrice4_traffic10}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic9 + sumPriceWritten_traffic9 + sumPrice4_traffic9}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic8 + sumPriceWritten_traffic8 + sumPrice4_traffic8}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic7 + sumPriceWritten_traffic7 + sumPrice4_traffic7}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic6 + sumPriceWritten_traffic6 + sumPrice4_traffic6}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic5 + sumPriceWritten_traffic5 + sumPrice4_traffic5}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic4 + sumPriceWritten_traffic4 + sumPrice4_traffic4}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic3 + sumPriceWritten_traffic3 + sumPrice4_traffic3}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic2 + sumPriceWritten_traffic2 + sumPrice4_traffic2}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic + sumPriceWritten_traffic + sumPrice4_traffic}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_traffic_sum + sumPriceWritten_traffic_sum + sumPrice4_traffic_sum}" pattern="#,##0.##"/></th>
            </tr>
            </tbody>
        </table>
    </div>
</div>
