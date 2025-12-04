<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="tableStyle2">
    <div style="background: #e7ecf1;<c:if test='${MemberList.size() > 21}'>padding-right: 17px;</c:if>">    
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="120">
                <col width="120">
                <col width="85">
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
                <th rowspan="2">센터</th>
                <th rowspan="2">팀</th>
                <th rowspan="2">이름</th>
                <th colspan="3">종결건수</th>
                <th colspan="4">교부</th>
                <th colspan="4">미교부</th>                
            </tr>
            <tr>
            	<th>기본수임</th>
            	<th>농작물</th>
            	<th>합계</th>
            	<th>교부완료건수</th>            	                
                <th>계약자</th>
                <th>피보험자</th>
                <th>피청구권자</th>
                <th>미교부건수</th>                
                <th>계약자</th>
                <th>피보험자</th>
                <th>피청구권자</th>                                                
            </tr>            
            </thead>
        </table>
    </div>
    <div style="height:654px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="120">
                <col width="120">
                <col width="85">
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
            <c:set var="sum_basicCnt" value="0"/>
            <c:set var="sum_primCnt" value="0"/>
            <c:set var="sum_endsumCnt" value="0"/>
            <c:set var="sum_compCnt" value="0"/>
            <c:set var="sum_conCnt" value="0"/>
            <c:set var="sum_insCnt" value="0"/>
            <c:set var="sum_claCnt" value="0"/>
            <c:set var="sum_compdisCnt" value="0"/>
            <c:set var="sum_condisCnt" value="0"/>
            <c:set var="sum_insdisCnt" value="0"/>
            <c:set var="sum_cladisCnt" value="0"/>
            <input type="hidden" id="totCnt" value="${MemberList.size()}"/>                        
            <c:forEach var="vo" items="${MemberList}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MemberList.size()}"><a href="javascript:goTeamList();">${vo.centerName}</a></td>
                    </c:if>
                    <td><a href="javascript:goTeamList();">${team_name}</a></td>
                    <td><a href="javascript:goPersonList('${vo.userNo}','${vo.userName}','${team_name}');">${vo.userName}</a>                    
                    </td>
                    <td>${vo.basicCnt}</td>
                    <td>${vo.primCnt}</td>
                    <td><b>${vo.basicCnt+vo.primCnt}</b></td>
                    <td><font color="blue">${vo.compCnt }</font></td>
                    <td>${vo.conCnt}</td>
                    <td>${vo.insCnt}</td>
                    <td>${vo.claCnt}</td>
                    <td><font color="red">${vo.basicCnt+vo.primCnt-vo.claCnt}</font></td>
                    <td>${vo.basicCnt+vo.primCnt-vo.conCnt}</td>                    
                    <td>${vo.basicCnt+vo.primCnt-vo.insCnt}</td>
                    <td>${vo.basicCnt+vo.primCnt-vo.claCnt}</td>                    
                </tr>
                <c:set var="sum_basicCnt" value="${sum_basicCnt + vo.basicCnt}"/>
                <c:set var="sum_primCnt" value="${sum_primCnt + vo.primCnt}"/>
                <c:set var="sum_endsumCnt" value="${sum_endsumCnt + (vo.basicCnt+vo.primCnt)}"/>
                <c:set var="sum_compCnt" value="${sum_compCnt + vo.compCnt}"/>
                <c:set var="sum_conCnt" value="${sum_conCnt + vo.conCnt}"/>
                <c:set var="sum_insCnt" value="${sum_insCnt + vo.insCnt}"/>
                <c:set var="sum_claCnt" value="${sum_claCnt + vo.claCnt}"/>
                <c:set var="sum_compdisCnt" value="${sum_compdisCnt + (vo.basicCnt+vo.primCnt-vo.claCnt)}"/>
                <c:set var="sum_condisCnt" value="${sum_condisCnt + (vo.basicCnt+vo.primCnt-vo.conCnt)}"/>
                <c:set var="sum_insdisCnt" value="${sum_insdisCnt + (vo.basicCnt+vo.primCnt-vo.insCnt)}"/>
                <c:set var="sum_cladisCnt" value="${sum_cladisCnt + (vo.basicCnt+vo.primCnt-vo.claCnt)}"/>                
            </c:forEach>
	            <tr bgcolor="#E7ECF1">
	                <td colspan="3"><b>합계</b></td>
					<td><b><fmt:formatNumber value="${sum_basicCnt}" pattern="#,###"/></b></td>
					<td><b><fmt:formatNumber value="${sum_primCnt}" pattern="#,###"/></b></td>
					<td><b><fmt:formatNumber value="${sum_endsumCnt}" pattern="#,###"/></b></td>
					<td><b><font color="blue"><fmt:formatNumber value="${sum_compCnt}" pattern="#,###"/></font></b></td>
					<td><b><fmt:formatNumber value="${sum_conCnt}" pattern="#,###"/></b></td>
					<td><b><fmt:formatNumber value="${sum_insCnt}" pattern="#,###"/></b></td>
					<td><b><fmt:formatNumber value="${sum_claCnt}" pattern="#,###"/></b></td>
					<td><b><font color="red"><fmt:formatNumber value="${sum_compdisCnt}" pattern="#,###"/></font></b></td>
					<td><b><fmt:formatNumber value="${sum_condisCnt}" pattern="#,###"/></b></td>
					<td><b><fmt:formatNumber value="${sum_insdisCnt}" pattern="#,###"/></b></td>
					<td><b><fmt:formatNumber value="${sum_cladisCnt}" pattern="#,###"/></b></td>					
	            </tr>            
            </tbody>
        </table>        
    </div>
</div>