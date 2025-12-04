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
            <c:forEach var="vo" items="${MisEndPtnrQr1Main}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmQr');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrQr1Main.size()}">1종 조사</td>
                    </c:if>
                    <td style="width: 150px;">
                    	${vo.ptnr_nick}
                   	</td>
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
                <td colspan="2">1종 조사 소계</td>
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
            <!-- 1종 조사 끝 -->
            
            <!-- 1종 심사 시작 -->
            <c:forEach var="vo" items="${MisEndPtnrQr1Written}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmQr');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrQr1Written.size()}">1종 심사</td>
                    </c:if>
                    <td style="width: 150px;">
                    	${vo.ptnr_nick}
                   	</td>
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
                <c:set var="sumPriceWritten_qr12" value="${sumPriceWritten_qr12 + vo.price_qr12}" />
                <c:set var="sumPriceWritten_qr11" value="${sumPriceWritten_qr11 + vo.price_qr11}" />
                <c:set var="sumPriceWritten_qr10" value="${sumPriceWritten_qr10 + vo.price_qr10}" />
                <c:set var="sumPriceWritten_qr9" value="${sumPriceWritten_qr9 + vo.price_qr9}" />
                <c:set var="sumPriceWritten_qr8" value="${sumPriceWritten_qr8 + vo.price_qr8}" />
                <c:set var="sumPriceWritten_qr7" value="${sumPriceWritten_qr7 + vo.price_qr7}" />
                <c:set var="sumPriceWritten_qr6" value="${sumPriceWritten_qr6 + vo.price_qr6}" />
                <c:set var="sumPriceWritten_qr5" value="${sumPriceWritten_qr5 + vo.price_qr5}" />
                <c:set var="sumPriceWritten_qr4" value="${sumPriceWritten_qr4 + vo.price_qr4}" />
                <c:set var="sumPriceWritten_qr3" value="${sumPriceWritten_qr3 + vo.price_qr3}" />
                <c:set var="sumPriceWritten_qr2" value="${sumPriceWritten_qr2 + vo.price_qr2}" />
                <c:set var="sumPriceWritten_qr" value="${sumPriceWritten_qr + vo.price_qr}" />
                <c:set var="sumPriceWritten_qr_sum" value="${sumPriceWritten_qr_sum + vo.price_qr12+vo.price_qr11+vo.price_qr10+vo.price_qr9+vo.price_qr8+vo.price_qr7+vo.price_qr6+vo.price_qr5+vo.price_qr4+vo.price_qr3+vo.price_qr2+vo.price_qr}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 심사 소계</td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_qr_sum}" pattern="#,##0.##"/></td>
            </tr>
            <!-- 1종 심사 끝 -->
            
            <!-- 1종 소계 시작 -->
            <tr bgcolor="#E7ECF1">
                <th colspan="2">1종 소계</th>
                <th><fmt:formatNumber value="${sumPrice_qr12 + sumPriceWritten_qr12}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr11 + sumPriceWritten_qr11}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr10 + sumPriceWritten_qr10}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr9 + sumPriceWritten_qr9}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr8 + sumPriceWritten_qr8}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr7 + sumPriceWritten_qr7}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr6 + sumPriceWritten_qr6}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr5 + sumPriceWritten_qr5}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr4 + sumPriceWritten_qr4}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr3 + sumPriceWritten_qr3}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr2 + sumPriceWritten_qr2}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr + sumPriceWritten_qr}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_qr_sum + sumPriceWritten_qr_sum}" pattern="#,##0.##"/></th>
            </tr>
            <!-- 1종 소계 끝 -->
            
            <c:forEach var="vo" items="${MisEndPtnrQr4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmQr');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrQr4.size()}">4종</td>
                    </c:if>
                    <td>
	                    ${vo.ptnr_nick}
                   	</td>
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
                <th colspan="2">4종 소계</th>
                <th><fmt:formatNumber value="${sumPrice4_qr12}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr11}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr10}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr9}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr8}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr7}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr6}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr5}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr4}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr3}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr2}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_qr_sum}" pattern="#,##0.##"/></th>
            </tr>
            <tr bgcolor="#E7ECF1">
                <th style="color:blue;" colspan="2">합 계</th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr12 + sumPriceWritten_qr12 + sumPrice4_qr12}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr11 + sumPriceWritten_qr11 + sumPrice4_qr11}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr10 + sumPriceWritten_qr10 + sumPrice4_qr10}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr9 + sumPriceWritten_qr9 + sumPrice4_qr9}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr8 + sumPriceWritten_qr8 + sumPrice4_qr8}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr7 + sumPriceWritten_qr7 + sumPrice4_qr7}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr6 + sumPriceWritten_qr6 + sumPrice4_qr6}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr5 + sumPriceWritten_qr5 + sumPrice4_qr5}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr4 + sumPriceWritten_qr4 + sumPrice4_qr4}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr3 + sumPriceWritten_qr3 + sumPrice4_qr3}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr2 + sumPriceWritten_qr2 + sumPrice4_qr2}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr + sumPriceWritten_qr + sumPrice4_qr}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_qr_sum + sumPriceWritten_qr_sum + sumPrice4_qr_sum}" pattern="#,##0.##"/></th>
            </tr>
            </tbody>
        </table>
    </div>
</div>
