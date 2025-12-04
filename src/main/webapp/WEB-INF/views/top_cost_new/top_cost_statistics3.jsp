<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2" id="dataTable">
	<div style="padding-right: 20px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
<%--             <caption>팀 기본통계</caption> --%>
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
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>
            <thead>
            <tr>
                <th>Type</th>
                <th>팀명</th>
                <th>유류대</th>
                <th>통행료</th>
                <th>대중교통비</th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th>합계</th>
            </tr>
            </thead>
        </table>
    </div>
    <div style="height:570px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
<%--             <caption>팀 기본통계</caption> --%>
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
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>
            <tbody>
            <c:forEach var="vo" items="${getTCStmClaim0}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getTCStmClaim0.size()}">총괄</td>
                    </c:if>
                    <td>
                    	<c:choose>
                    		<c:when test="${srchArg.excelYN == 'Y'}">
                    			<p>${vo.getTeam_name()}</p>
                    		</c:when>
                    		<c:otherwise>
                    			<p><a href="javascript:goTCSTmMbr2('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.getTeam_name()}</a></p>
                    		</c:otherwise>
                    	</c:choose>                    
                    </td>
                    <td><fmt:formatNumber value="${vo.cash11 + vo.card11}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash21 + vo.card21}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash31 + vo.card31}" pattern="#,##0.##"/></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><fmt:formatNumber value="${vo.cashSum + vo.cardSum}" pattern="#,##0.##"/></td>
                    <c:set var="sum0_cash11" value="${sum0_cash11 + vo.cash11}" />
                    <c:set var="sum0_cash21" value="${sum0_cash21 + vo.cash21}" />
                    <c:set var="sum0_cash31" value="${sum0_cash31 + vo.cash31}" />
                    <c:set var="sum0_cashSum" value="${sum0_cashSum + vo.cashSum}" />
                    <c:set var="sum0_card11" value="${sum0_card11 + vo.card11}" />
                    <c:set var="sum0_card21" value="${sum0_card21 + vo.card21}" />
                    <c:set var="sum0_card31" value="${sum0_card31 + vo.card31}" />
                    <c:set var="sum0_cardSum" value="${sum0_cardSum + vo.cardSum}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">카드</td>
                <td><fmt:formatNumber value="${sum0_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum0_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">현금</td>
                <td><fmt:formatNumber value="${sum0_cash11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum0_cashSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">소계</td>
                <td><fmt:formatNumber value="${sum0_cash11+sum0_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash21+sum0_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash31+sum0_card31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum0_cashSum+sum0_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <c:forEach var="vo" items="${getTCStmClaim1}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getTCStmClaim1.size()}">1종</td>
                    </c:if>
                    <td>
                    	<c:choose>
                    		<c:when test="${srchArg.excelYN == 'Y'}">
                    			<p>${vo.getTeam_name()}</p>
                    		</c:when>
                    		<c:otherwise>
                    			<p><a href="javascript:goTCSTmMbr2('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.getTeam_name()}</a></p>
                    		</c:otherwise>
                    	</c:choose>                    
                    </td>
                    <td><fmt:formatNumber value="${vo.cash11 + vo.card11}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash21 + vo.card21}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash31 + vo.card31}" pattern="#,##0.##"/></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><fmt:formatNumber value="${vo.cashSum + vo.cardSum}" pattern="#,##0.##"/></td>
                    <c:set var="sum1_cash11" value="${sum1_cash11 + vo.cash11}" />
                    <c:set var="sum1_cash21" value="${sum1_cash21 + vo.cash21}" />
                    <c:set var="sum1_cash31" value="${sum1_cash31 + vo.cash31}" />
                    <c:set var="sum1_cashSum" value="${sum1_cashSum + vo.cashSum}" />
                    <c:set var="sum1_card11" value="${sum1_card11 + vo.card11}" />
                    <c:set var="sum1_card21" value="${sum1_card21 + vo.card21}" />
                    <c:set var="sum1_card31" value="${sum1_card31 + vo.card31}" />
                    <c:set var="sum1_cardSum" value="${sum1_cardSum + vo.cardSum}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">카드</td>
                <td><fmt:formatNumber value="${sum1_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum1_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">현금</td>
                <td><fmt:formatNumber value="${sum1_cash11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum1_cashSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">소계</td>
                <td><fmt:formatNumber value="${sum1_cash11+sum1_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash21+sum1_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash31+sum1_card31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum1_cashSum+sum1_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <c:forEach var="vo" items="${getTCStmClaim4}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getTCStmClaim4.size()}">4종</td>
                    </c:if>
                    <td>
                    	<c:choose>
                    		<c:when test="${srchArg.excelYN == 'Y'}">
                    			<p>${vo.getTeam_name()}</p>
                    		</c:when>
                    		<c:otherwise>
                    			<p><a href="javascript:goTCSTmMbr2('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.getTeam_name()}</a></p>
                    		</c:otherwise>
                    	</c:choose>                    
                    </td>
                    <td><fmt:formatNumber value="${vo.cash11 + vo.card11}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash21 + vo.card21}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash31 + vo.card31}" pattern="#,##0.##"/></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><fmt:formatNumber value="${vo.cashSum + vo.cardSum}" pattern="#,##0.##"/></td>
                    <c:set var="sum4_cash11" value="${sum4_cash11 + vo.cash11}" />
                    <c:set var="sum4_cash21" value="${sum4_cash21 + vo.cash21}" />
                    <c:set var="sum4_cash31" value="${sum4_cash31 + vo.cash31}" />
                    <c:set var="sum4_cashSum" value="${sum4_cashSum + vo.cashSum}" />
                    <c:set var="sum4_card11" value="${sum4_card11 + vo.card11}" />
                    <c:set var="sum4_card21" value="${sum4_card21 + vo.card21}" />
                    <c:set var="sum4_card31" value="${sum4_card31 + vo.card31}" />
                    <c:set var="sum4_cardSum" value="${sum4_cardSum + vo.cardSum}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">카드</td>
                <td><fmt:formatNumber value="${sum4_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum4_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">현금</td>
                <td><fmt:formatNumber value="${sum4_cash11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum4_cashSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">소계</td>
                <td><fmt:formatNumber value="${sum4_cash11+sum4_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash21+sum4_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash31+sum4_card31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum4_cashSum+sum4_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">합계</td>
                <td><fmt:formatNumber value="${sum0_cash11+sum0_card11+sum1_cash11+sum1_card11+sum4_cash11+sum4_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash21+sum0_card21+sum1_cash21+sum1_card21+sum4_cash21+sum4_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash31+sum0_card31+sum1_cash31+sum1_card31+sum4_cash31+sum4_card31}" pattern="#,##0.##"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><fmt:formatNumber value="${sum0_cashSum+sum0_cardSum +sum1_cashSum+sum1_cardSum +sum4_cashSum+sum4_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
