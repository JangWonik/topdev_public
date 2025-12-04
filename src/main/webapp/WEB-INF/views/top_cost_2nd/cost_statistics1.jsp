<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2" id="dataTable">
	<div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
            <colgroup>
                <col style="width:6%;">
                <col style="width:10%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
            </colgroup>
            <thead>
            <tr>
                <th>Type</th>
                <th>팀명</th>
                <th>대중교통비</th>
                <th>유류대</th>
                <th>주차비</th>
                <th>통행료</th>
                <th>숙박비</th>
                <th>회식대</th>
                <th>식대</th>
                <th>업무협의비</th>
                <th>물품구입비</th>
                <th>우편요금</th>
                <th>통신료</th>
                <th>문서발급비</th>
                <th>수도광열비</th>
                <th>합계</th>
            </tr>
            </thead>
        </table>
	</div>
    <div style="height:570px; overflow-x: hidden; overflow-y: auto;">
        <table class="costStatisticsTable" cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
            <colgroup>
                <col style="width:6%;">
                <col style="width:10%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
                <col style="width:6%;">
            </colgroup>
            <tbody>
            <c:forEach var="vo" items="${getTCStm0}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getTCStm0.size()}">총괄</td>
                    </c:if>
                    <td>
                    	<c:choose>
                    		<c:when test="${srchArg.excelYN == 'Y'}">
                    			<p>${vo.getTeam_name()}</p>
                    		</c:when>
                    		<c:otherwise>
                    			<p><a href="javascript:goTCSTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.getTeam_name()}</a></p>
                    		</c:otherwise>
                    	</c:choose>
                    </td>
                    <td><fmt:formatNumber value="${vo.cash11 + vo.card11}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash21 + vo.card21}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash31 + vo.card31}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash41 + vo.card41}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash51 + vo.card51}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash61 + vo.card61}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash71 + vo.card71}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash81 + vo.card81}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash91 + vo.card91}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash101 + vo.card101}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash111 + vo.card111}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash121 + vo.card121}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash131 + vo.card131}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cashSum + vo.cardSum}" pattern="#,##0.##"/></td>
                    <c:set var="sum0_cash11" value="${sum0_cash11 + vo.cash11}" />
                    <c:set var="sum0_cash21" value="${sum0_cash21 + vo.cash21}" />
                    <c:set var="sum0_cash31" value="${sum0_cash31 + vo.cash31}" />
                    <c:set var="sum0_cash41" value="${sum0_cash41 + vo.cash41}" />
                    <c:set var="sum0_cash51" value="${sum0_cash51 + vo.cash51}" />
                    <c:set var="sum0_cash61" value="${sum0_cash61 + vo.cash61}" />
                    <c:set var="sum0_cash71" value="${sum0_cash71 + vo.cash71}" />
                    <c:set var="sum0_cash81" value="${sum0_cash81 + vo.cash81}" />
                    <c:set var="sum0_cash91" value="${sum0_cash91 + vo.cash91}" />
                    <c:set var="sum0_cash101" value="${sum0_cash101 + vo.cash101}" />
                    <c:set var="sum0_cash111" value="${sum0_cash111 + vo.cash111}" />
                    <c:set var="sum0_cash121" value="${sum0_cash121 + vo.cash121}" />
                    <c:set var="sum0_cash131" value="${sum0_cash131 + vo.cash131}" />
                    <c:set var="sum0_cashSum" value="${sum0_cashSum + vo.cashSum}" />
                    <c:set var="sum0_card11" value="${sum0_card11 + vo.card11}" />
                    <c:set var="sum0_card21" value="${sum0_card21 + vo.card21}" />
                    <c:set var="sum0_card31" value="${sum0_card31 + vo.card31}" />
                    <c:set var="sum0_card41" value="${sum0_card41 + vo.card41}" />
                    <c:set var="sum0_card51" value="${sum0_card51 + vo.card51}" />
                    <c:set var="sum0_card61" value="${sum0_card61 + vo.card61}" />
                    <c:set var="sum0_card71" value="${sum0_card71 + vo.card71}" />
                    <c:set var="sum0_card81" value="${sum0_card81 + vo.card81}" />
                    <c:set var="sum0_card91" value="${sum0_card91 + vo.card91}" />
                    <c:set var="sum0_card101" value="${sum0_card101 + vo.card101}" />
                    <c:set var="sum0_card111" value="${sum0_card111 + vo.card111}" />
                    <c:set var="sum0_card121" value="${sum0_card121 + vo.card121}" />
                    <c:set var="sum0_card131" value="${sum0_card131 + vo.card131}" />
                    <c:set var="sum0_cardSum" value="${sum0_cardSum + vo.cardSum}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">카드</td>
                <td><fmt:formatNumber value="${sum0_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_card131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">현금</td>
                <td><fmt:formatNumber value="${sum0_cash11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cashSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">소계</td>
                <td><fmt:formatNumber value="${sum0_cash11+sum0_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash21+sum0_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash31+sum0_card31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash41+sum0_card41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash51+sum0_card51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash61+sum0_card61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash71+sum0_card71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash81+sum0_card81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash91+sum0_card91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash101+sum0_card101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash111+sum0_card111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash121+sum0_card121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash131+sum0_card131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cashSum+sum0_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <c:forEach var="vo" items="${getTCStm1}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getTCStm1.size()}">1종</td>
                    </c:if>
                    <td>
                    	<c:choose>
                    		<c:when test="${srchArg.excelYN == 'Y'}">
                    			<p>${vo.getTeam_name()}</p>
                    		</c:when>
                    		<c:otherwise>
                    			<p><a href="javascript:goTCSTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.getTeam_name()}</a></p>
                    		</c:otherwise>
                    	</c:choose>                    
                    </td>
                    <td><fmt:formatNumber value="${vo.cash11 + vo.card11}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash21 + vo.card21}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash31 + vo.card31}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash41 + vo.card41}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash51 + vo.card51}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash61 + vo.card61}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash71 + vo.card71}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash81 + vo.card81}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash91 + vo.card91}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash101 + vo.card101}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash111 + vo.card111}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash121 + vo.card121}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash131 + vo.card131}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cashSum + vo.cardSum}" pattern="#,##0.##"/></td>
                    <c:set var="sum1_cash11" value="${sum1_cash11 + vo.cash11}" />
                    <c:set var="sum1_cash21" value="${sum1_cash21 + vo.cash21}" />
                    <c:set var="sum1_cash31" value="${sum1_cash31 + vo.cash31}" />
                    <c:set var="sum1_cash41" value="${sum1_cash41 + vo.cash41}" />
                    <c:set var="sum1_cash51" value="${sum1_cash51 + vo.cash51}" />
                    <c:set var="sum1_cash61" value="${sum1_cash61 + vo.cash61}" />
                    <c:set var="sum1_cash71" value="${sum1_cash71 + vo.cash71}" />
                    <c:set var="sum1_cash81" value="${sum1_cash81 + vo.cash81}" />
                    <c:set var="sum1_cash91" value="${sum1_cash91 + vo.cash91}" />
                    <c:set var="sum1_cash101" value="${sum1_cash101 + vo.cash101}" />
                    <c:set var="sum1_cash111" value="${sum1_cash111 + vo.cash111}" />
                    <c:set var="sum1_cash121" value="${sum1_cash121 + vo.cash121}" />
                    <c:set var="sum1_cash131" value="${sum1_cash131 + vo.cash131}" />
                    <c:set var="sum1_cashSum" value="${sum1_cashSum + vo.cashSum}" />
                    <c:set var="sum1_card11" value="${sum1_card11 + vo.card11}" />
                    <c:set var="sum1_card21" value="${sum1_card21 + vo.card21}" />
                    <c:set var="sum1_card31" value="${sum1_card31 + vo.card31}" />
                    <c:set var="sum1_card41" value="${sum1_card41 + vo.card41}" />
                    <c:set var="sum1_card51" value="${sum1_card51 + vo.card51}" />
                    <c:set var="sum1_card61" value="${sum1_card61 + vo.card61}" />
                    <c:set var="sum1_card71" value="${sum1_card71 + vo.card71}" />
                    <c:set var="sum1_card81" value="${sum1_card81 + vo.card81}" />
                    <c:set var="sum1_card91" value="${sum1_card91 + vo.card91}" />
                    <c:set var="sum1_card101" value="${sum1_card101 + vo.card101}" />
                    <c:set var="sum1_card111" value="${sum1_card111 + vo.card111}" />
                    <c:set var="sum1_card121" value="${sum1_card121 + vo.card121}" />
                    <c:set var="sum1_card131" value="${sum1_card131 + vo.card131}" />
                    <c:set var="sum1_cardSum" value="${sum1_cardSum + vo.cardSum}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">카드</td>
                <td><fmt:formatNumber value="${sum1_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_card131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">현금</td>
                <td><fmt:formatNumber value="${sum1_cash11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cashSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">소계</td>
                <td><fmt:formatNumber value="${sum1_cash11+sum1_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash21+sum1_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash31+sum1_card31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash41+sum1_card41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash51+sum1_card51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash61+sum1_card61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash71+sum1_card71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash81+sum1_card81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash91+sum1_card91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash101+sum1_card101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash111+sum1_card111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash121+sum1_card121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cash131+sum1_card131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum1_cashSum+sum1_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <c:forEach var="vo" items="${getTCStm4}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getTCStm4.size()}">4종</td>
                    </c:if>
                    <td>
                    	<c:choose>
                    		<c:when test="${srchArg.excelYN == 'Y'}">
                    			<p>${vo.getTeam_name()}</p>
                    		</c:when>
                    		<c:otherwise>
                    			<p><a href="javascript:goTCSTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.getTeam_name()}</a></p>
                    		</c:otherwise>
                    	</c:choose>   
                    </td>
                    <td><fmt:formatNumber value="${vo.cash11 + vo.card11}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash21 + vo.card21}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash31 + vo.card31}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash41 + vo.card41}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash51 + vo.card51}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash61 + vo.card61}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash71 + vo.card71}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash81 + vo.card81}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash91 + vo.card91}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash101 + vo.card101}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash111 + vo.card111}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash121 + vo.card121}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cash131 + vo.card131}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.cashSum + vo.cardSum}" pattern="#,##0.##"/></td>
                    <c:set var="sum4_cash11" value="${sum4_cash11 + vo.cash11}" />
                    <c:set var="sum4_cash21" value="${sum4_cash21 + vo.cash21}" />
                    <c:set var="sum4_cash31" value="${sum4_cash31 + vo.cash31}" />
                    <c:set var="sum4_cash41" value="${sum4_cash41 + vo.cash41}" />
                    <c:set var="sum4_cash51" value="${sum4_cash51 + vo.cash51}" />
                    <c:set var="sum4_cash61" value="${sum4_cash61 + vo.cash61}" />
                    <c:set var="sum4_cash71" value="${sum4_cash71 + vo.cash71}" />
                    <c:set var="sum4_cash81" value="${sum4_cash81 + vo.cash81}" />
                    <c:set var="sum4_cash91" value="${sum4_cash91 + vo.cash91}" />
                    <c:set var="sum4_cash101" value="${sum4_cash101 + vo.cash101}" />
                    <c:set var="sum4_cash111" value="${sum4_cash111 + vo.cash111}" />
                    <c:set var="sum4_cash121" value="${sum4_cash121 + vo.cash121}" />
                    <c:set var="sum4_cash131" value="${sum4_cash131 + vo.cash131}" />
                    <c:set var="sum4_cashSum" value="${sum4_cashSum + vo.cashSum}" />
                    <c:set var="sum4_card11" value="${sum4_card11 + vo.card11}" />
                    <c:set var="sum4_card21" value="${sum4_card21 + vo.card21}" />
                    <c:set var="sum4_card31" value="${sum4_card31 + vo.card31}" />
                    <c:set var="sum4_card41" value="${sum4_card41 + vo.card41}" />
                    <c:set var="sum4_card51" value="${sum4_card51 + vo.card51}" />
                    <c:set var="sum4_card61" value="${sum4_card61 + vo.card61}" />
                    <c:set var="sum4_card71" value="${sum4_card71 + vo.card71}" />
                    <c:set var="sum4_card81" value="${sum4_card81 + vo.card81}" />
                    <c:set var="sum4_card91" value="${sum4_card91 + vo.card91}" />
                    <c:set var="sum4_card101" value="${sum4_card101 + vo.card101}" />
                    <c:set var="sum4_card111" value="${sum4_card111 + vo.card111}" />
                    <c:set var="sum4_card121" value="${sum4_card121 + vo.card121}" />
                    <c:set var="sum4_card131" value="${sum4_card131 + vo.card131}" />
                    <c:set var="sum4_cardSum" value="${sum4_cardSum + vo.cardSum}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">카드</td>
                <td><fmt:formatNumber value="${sum4_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_card131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">현금</td>
                <td><fmt:formatNumber value="${sum4_cash11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cashSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">소계</td>
                <td><fmt:formatNumber value="${sum4_cash11+sum4_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash21+sum4_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash31+sum4_card31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash41+sum4_card41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash51+sum4_card51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash61+sum4_card61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash71+sum4_card71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash81+sum4_card81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash91+sum4_card91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash101+sum4_card101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash111+sum4_card111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash121+sum4_card121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cash131+sum4_card131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum4_cashSum+sum4_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">합계</td>
                <td><fmt:formatNumber value="${sum0_cash11+sum0_card11+sum1_cash11+sum1_card11+sum4_cash11+sum4_card11}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash21+sum0_card21+sum1_cash21+sum1_card21+sum4_cash21+sum4_card21}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash31+sum0_card31+sum1_cash31+sum1_card31+sum4_cash31+sum4_card31}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash41+sum0_card41+sum1_cash41+sum1_card41+sum4_cash41+sum4_card41}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash51+sum0_card51+sum1_cash51+sum1_card51+sum4_cash51+sum4_card51}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash61+sum0_card61+sum1_cash61+sum1_card61+sum4_cash61+sum4_card61}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash71+sum0_card71+sum1_cash71+sum1_card71+sum4_cash71+sum4_card71}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash81+sum0_card81+sum1_cash81+sum1_card81+sum4_cash81+sum4_card81}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash91+sum0_card91+sum1_cash91+sum1_card91+sum4_cash91+sum4_card91}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash101+sum0_card101+sum1_cash101+sum1_card101+sum4_cash101+sum4_card101}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash111+sum0_card111+sum1_cash111+sum1_card111+sum4_cash111+sum4_card111}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash121+sum0_card121+sum1_cash121+sum1_card121+sum4_cash121+sum4_card121}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cash131+sum0_card131+sum1_cash131+sum1_card131+sum4_cash131+sum4_card131}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sum0_cashSum+sum0_cardSum +sum1_cashSum+sum1_cardSum +sum4_cashSum+sum4_cardSum}" pattern="#,##0.##"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
