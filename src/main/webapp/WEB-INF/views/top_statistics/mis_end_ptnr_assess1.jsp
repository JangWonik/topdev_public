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
            <c:forEach var="vo" items="${MisEndPtnrAssess1Main}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmAssess');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrAssess1Main.size()}">1종 조사</td>
                    </c:if>
                    <td style="width: 150px;">
                    	${vo.ptnr_nick}
                   	</td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPrice_assess12" value="${sumPrice_assess12 + vo.price_assess12}" />
                <c:set var="sumPrice_assess11" value="${sumPrice_assess11 + vo.price_assess11}" />
                <c:set var="sumPrice_assess10" value="${sumPrice_assess10 + vo.price_assess10}" />
                <c:set var="sumPrice_assess9" value="${sumPrice_assess9 + vo.price_assess9}" />
                <c:set var="sumPrice_assess8" value="${sumPrice_assess8 + vo.price_assess8}" />
                <c:set var="sumPrice_assess7" value="${sumPrice_assess7 + vo.price_assess7}" />
                <c:set var="sumPrice_assess6" value="${sumPrice_assess6 + vo.price_assess6}" />
                <c:set var="sumPrice_assess5" value="${sumPrice_assess5 + vo.price_assess5}" />
                <c:set var="sumPrice_assess4" value="${sumPrice_assess4 + vo.price_assess4}" />
                <c:set var="sumPrice_assess3" value="${sumPrice_assess3 + vo.price_assess3}" />
                <c:set var="sumPrice_assess2" value="${sumPrice_assess2 + vo.price_assess2}" />
                <c:set var="sumPrice_assess" value="${sumPrice_assess + vo.price_assess}" />
                <c:set var="sumPrice_assess_sum" value="${sumPrice_assess_sum + vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 조사 소계</td>
                <td><fmt:formatNumber value="${sumPrice_assess12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess_sum}" pattern="#,##0.##"/></td>
            </tr>
            <!-- 1종 조사 끝 -->
            
            <!-- 1종 심사 시작 -->
            <c:forEach var="vo" items="${MisEndPtnrAssess1Written}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmAssess');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrAssess1Written.size()}">1종 심사</td>
                    </c:if>
                    <td style="width: 150px;">
                    	${vo.ptnr_nick}
                   	</td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPriceWritten_assess12" value="${sumPriceWritten_assess12 + vo.price_assess12}" />
                <c:set var="sumPriceWritten_assess11" value="${sumPriceWritten_assess11 + vo.price_assess11}" />
                <c:set var="sumPriceWritten_assess10" value="${sumPriceWritten_assess10 + vo.price_assess10}" />
                <c:set var="sumPriceWritten_assess9" value="${sumPriceWritten_assess9 + vo.price_assess9}" />
                <c:set var="sumPriceWritten_assess8" value="${sumPriceWritten_assess8 + vo.price_assess8}" />
                <c:set var="sumPriceWritten_assess7" value="${sumPriceWritten_assess7 + vo.price_assess7}" />
                <c:set var="sumPriceWritten_assess6" value="${sumPriceWritten_assess6 + vo.price_assess6}" />
                <c:set var="sumPriceWritten_assess5" value="${sumPriceWritten_assess5 + vo.price_assess5}" />
                <c:set var="sumPriceWritten_assess4" value="${sumPriceWritten_assess4 + vo.price_assess4}" />
                <c:set var="sumPriceWritten_assess3" value="${sumPriceWritten_assess3 + vo.price_assess3}" />
                <c:set var="sumPriceWritten_assess2" value="${sumPriceWritten_assess2 + vo.price_assess2}" />
                <c:set var="sumPriceWritten_assess" value="${sumPriceWritten_assess + vo.price_assess}" />
                <c:set var="sumPriceWritten_assess_sum" value="${sumPriceWritten_assess_sum + vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 심사 소계</td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess12}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess10}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess9}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess8}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess7}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess6}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess5}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess3}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess2}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPriceWritten_assess_sum}" pattern="#,##0.##"/></td>
            </tr>            
            <!-- 1종 심사 끝 -->
            
            <!-- 1종 소계 시작-->
            <tr bgcolor="#E7ECF1">
                <th colspan="2">1종 소계</th>
                <th><fmt:formatNumber value="${sumPrice_assess12 + sumPriceWritten_assess12}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess11 + sumPriceWritten_assess11}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess10 + sumPriceWritten_assess10}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess9 + sumPriceWritten_assess9}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess8 + sumPriceWritten_assess8}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess7 + sumPriceWritten_assess7}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess6 + sumPriceWritten_assess6}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess5 + sumPriceWritten_assess5}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess4 + sumPriceWritten_assess4}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess3 + sumPriceWritten_assess3}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess2 + sumPriceWritten_assess2}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess + sumPriceWritten_assess}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice_assess_sum + sumPriceWritten_assess_sum}" pattern="#,##0.##"/></th>
            </tr> 
            <!-- 1종 소계 끝-->            
            
            <c:forEach var="vo" items="${MisEndPtnrAssess4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
         	        onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTmAssess');">
         	        
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrAssess4.size()}">4종</td>
                    </c:if>
                    <td>
                    	${vo.ptnr_nick}
                   	</td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess12}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess11}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess10}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess9}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess8}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess7}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess6}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess5}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess4}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess3}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess2}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess}" pattern="#,##0.##"/><br>
                    </td>
                    <td>
                        <fmt:formatNumber value="${vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" pattern="#,##0.##"/>
                    </td>
                </tr>
                <c:set var="sumPrice4_assess12" value="${sumPrice4_assess12 + vo.price_assess12}" />
                <c:set var="sumPrice4_assess11" value="${sumPrice4_assess11 + vo.price_assess11}" />
                <c:set var="sumPrice4_assess10" value="${sumPrice4_assess10 + vo.price_assess10}" />
                <c:set var="sumPrice4_assess9" value="${sumPrice4_assess9 + vo.price_assess9}" />
                <c:set var="sumPrice4_assess8" value="${sumPrice4_assess8 + vo.price_assess8}" />
                <c:set var="sumPrice4_assess7" value="${sumPrice4_assess7 + vo.price_assess7}" />
                <c:set var="sumPrice4_assess6" value="${sumPrice4_assess6 + vo.price_assess6}" />
                <c:set var="sumPrice4_assess5" value="${sumPrice4_assess5 + vo.price_assess5}" />
                <c:set var="sumPrice4_assess4" value="${sumPrice4_assess4 + vo.price_assess4}" />
                <c:set var="sumPrice4_assess3" value="${sumPrice4_assess3 + vo.price_assess3}" />
                <c:set var="sumPrice4_assess2" value="${sumPrice4_assess2 + vo.price_assess2}" />
                <c:set var="sumPrice4_assess" value="${sumPrice4_assess + vo.price_assess}" />
                <c:set var="sumPrice4_assess_sum" value="${sumPrice4_assess_sum + vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="2">4종 소계</th>
                <th><fmt:formatNumber value="${sumPrice4_assess12}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess11}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess10}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess9}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess8}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess7}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess6}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess5}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess4}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess3}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess2}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess}" pattern="#,##0.##"/></th>
                <th><fmt:formatNumber value="${sumPrice4_assess_sum}" pattern="#,##0.##"/></th>
            </tr>
            <tr bgcolor="#E7ECF1">
                <th style="color:blue;" colspan="2">합 계</th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess12 + sumPriceWritten_assess12 + sumPrice4_assess12}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess11 + sumPriceWritten_assess11 + sumPrice4_assess11}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess10 + sumPriceWritten_assess10 + sumPrice4_assess10}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess9 + sumPriceWritten_assess9 + sumPrice4_assess9}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess8 + sumPriceWritten_assess8 + sumPrice4_assess8}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess7 + sumPriceWritten_assess7 + sumPrice4_assess7}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess6 + sumPriceWritten_assess6 + sumPrice4_assess6}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess5 + sumPriceWritten_assess5 + sumPrice4_assess5}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess4 + sumPriceWritten_assess4 + sumPrice4_assess4}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess3 + sumPriceWritten_assess3 + sumPrice4_assess3}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess2 + sumPriceWritten_assess2 + sumPrice4_assess2}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess + sumPriceWritten_assess + sumPrice4_assess}" pattern="#,##0.##"/></th>
                <th style="color:blue;"><fmt:formatNumber value="${sumPrice_assess_sum + sumPriceWritten_assess_sum + sumPrice4_assess_sum}" pattern="#,##0.##"/></th>
            </tr>
            </tbody>
        </table>
    </div>
</div>
