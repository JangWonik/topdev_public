<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
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
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2">Type</th>
                <th rowspan="2" colspan="2">팀</th>
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
            </colgroup>
            <tbody>
            <c:set var="sub1_basicCnt" value="0"/>
            <c:set var="sub1_primCnt" value="0"/>
            <c:set var="sub1_endsumCnt" value="0"/>
            <c:set var="sub1_compCnt" value="0"/>
            <c:set var="sub1_conCnt" value="0"/>
            <c:set var="sub1_insCnt" value="0"/>
            <c:set var="sub1_claCnt" value="0"/>
            <c:set var="sub1_compdisCnt" value="0"/>
            <c:set var="sub1_condisCnt" value="0"/>
            <c:set var="sub1_insdisCnt" value="0"/>
            <c:set var="sub1_cladisCnt" value="0"/>
            <c:set var="sub2_basicCnt" value="0"/>
			<c:set var="sub2_primCnt" value="0"/>
			<c:set var="sub2_endsumCnt" value="0"/>
			<c:set var="sub2_compCnt" value="0"/>
			<c:set var="sub2_conCnt" value="0"/>
			<c:set var="sub2_insCnt" value="0"/>
			<c:set var="sub2_claCnt" value="0"/>
			<c:set var="sub2_compdisCnt" value="0"/>
			<c:set var="sub2_condisCnt" value="0"/>
			<c:set var="sub2_insdisCnt" value="0"/>
			<c:set var="sub2_cladisCnt" value="0"/>            
            <input type="hidden" id="totCnt" value="${TeamList1.size()+TeamList4.size()}"/>                        
            <c:forEach var="vo" items="${TeamList1}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${TeamList1.size()+1}">1종</td>                        
                    </c:if>
                    <td>${vo.teamName}</td>
                    <td><a href="javascript:goTeamMember('${vo.teamId}','${vo.teamName}','${vo.teamType}');">개인별</a></td>
                    <td>${vo.basicCnt}</td>
                    <td>${vo.primCnt}</td>
                    <td>${vo.basicCnt+vo.primCnt}</td>
                    <td><font color="blue">${vo.compCnt}</font></td>
                    <td>${vo.conCnt}</td>
                    <td>${vo.insCnt}</td>
                    <td>${vo.claCnt}</td>
                    <td><font color="red">${vo.basicCnt+vo.primCnt-vo.claCnt}</font></td>
                    <td>${vo.basicCnt+vo.primCnt-vo.conCnt}</td>                    
                    <td>${vo.basicCnt+vo.primCnt-vo.insCnt}</td>
                    <td>${vo.basicCnt+vo.primCnt-vo.claCnt}</td>                    
                </tr>
                <c:set var="sub1_basicCnt" value="${sub1_basicCnt + vo.basicCnt}"/>
                <c:set var="sub1_primCnt" value="${sub1_primCnt + vo.primCnt}"/>
                <c:set var="sub1_endsumCnt" value="${sub1_endsumCnt + (vo.basicCnt+vo.primCnt)}"/>
                <c:set var="sub1_compCnt" value="${sub1_compCnt + vo.compCnt}"/>
                <c:set var="sub1_conCnt" value="${sub1_conCnt + vo.conCnt}"/>
                <c:set var="sub1_insCnt" value="${sub1_insCnt + vo.insCnt}"/>
                <c:set var="sub1_claCnt" value="${sub1_claCnt + vo.claCnt}"/>
                <c:set var="sub1_compdisCnt" value="${sub1_compdisCnt + (vo.basicCnt+vo.primCnt-vo.claCnt)}"/>
                <c:set var="sub1_condisCnt" value="${sub1_condisCnt + (vo.basicCnt+vo.primCnt-vo.conCnt)}"/>
                <c:set var="sub1_insdisCnt" value="${sub1_insdisCnt + (vo.basicCnt+vo.primCnt-vo.insCnt)}"/>
                <c:set var="sub1_cladisCnt" value="${sub1_cladisCnt + (vo.basicCnt+vo.primCnt-vo.claCnt)}"/>                                
            </c:forEach>
            <!-- 1종 합계부분 시작 -->
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 소계</td>
				<td><b><fmt:formatNumber value="${sub1_basicCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_primCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_endsumCnt}" pattern="#,###"/></b></td>
				<td><b><font color="blue"><fmt:formatNumber value="${sub1_compCnt}" pattern="#,###"/></font></b></td>
				<td><b><fmt:formatNumber value="${sub1_conCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_insCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_claCnt}" pattern="#,###"/></b></td>
				<td><b><font color="red"><fmt:formatNumber value="${sub1_compdisCnt}" pattern="#,###"/></font></b></td>
				<td><b><fmt:formatNumber value="${sub1_condisCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_insdisCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_cladisCnt}" pattern="#,###"/></b></td>
            </tr>            
            <!-- 1종 합계부분 끝 -->            
            <c:forEach var="vo" items="${TeamList4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${TeamList4.size()+1}">4종</td>
                    </c:if>
                    <td>${vo.teamName}</td>
                    <td><a href="javascript:goTeamMember('${vo.teamId}','${vo.teamName}','${vo.teamType}');">개인별</a></td>
                    <td>${vo.basicCnt}</td>
                    <td>${vo.primCnt}</td>
                    <td>${vo.basicCnt+vo.primCnt}</td>
                    <td><font color="blue">${vo.compCnt }</font></td>
                    <td>${vo.conCnt}</td>
                    <td>${vo.insCnt}</td>
                    <td>${vo.claCnt}</td>
                    <td><font color="red">${vo.basicCnt+vo.primCnt-vo.claCnt}</font></td>
                    <td>${vo.basicCnt+vo.primCnt-vo.conCnt}</td>                    
                    <td>${vo.basicCnt+vo.primCnt-vo.insCnt}</td>
                    <td>${vo.basicCnt+vo.primCnt-vo.claCnt}</td>
                </tr>
                <c:set var="sub2_basicCnt" value="${sub2_basicCnt + vo.basicCnt}"/>
				<c:set var="sub2_primCnt" value="${sub2_primCnt + vo.primCnt}"/>
				<c:set var="sub2_endsumCnt" value="${sub2_endsumCnt + (vo.basicCnt+vo.primCnt)}"/>
				<c:set var="sub2_compCnt" value="${sub2_compCnt + vo.compCnt}"/>
				<c:set var="sub2_conCnt" value="${sub2_conCnt + vo.conCnt}"/>
				<c:set var="sub2_insCnt" value="${sub2_insCnt + vo.insCnt}"/>
				<c:set var="sub2_claCnt" value="${sub2_claCnt + vo.claCnt}"/>
				<c:set var="sub2_compdisCnt" value="${sub2_compdisCnt + (vo.basicCnt+vo.primCnt-vo.claCnt)}"/>
				<c:set var="sub2_condisCnt" value="${sub2_condisCnt + (vo.basicCnt+vo.primCnt-vo.conCnt)}"/>
				<c:set var="sub2_insdisCnt" value="${sub2_insdisCnt + (vo.basicCnt+vo.primCnt-vo.insCnt)}"/>
				<c:set var="sub2_cladisCnt" value="${sub2_cladisCnt + (vo.basicCnt+vo.primCnt-vo.claCnt)}"/>
            </c:forEach>
            <!-- 4종 합계부분 시작 -->
            <tr bgcolor="#E7ECF1">
                <td colspan="2">4종 소계</td>
				<td><b><fmt:formatNumber value="${sub2_basicCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub2_primCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub2_endsumCnt}" pattern="#,###"/></b></td>
				<td><b><font color="blue"><fmt:formatNumber value="${sub2_compCnt}" pattern="#,###"/></font></b></td>
				<td><b><fmt:formatNumber value="${sub2_conCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub2_insCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub2_claCnt}" pattern="#,###"/></b></td>
				<td><b><font color="red"><fmt:formatNumber value="${sub2_compdisCnt}" pattern="#,###"/></font></b></td>
				<td><b><fmt:formatNumber value="${sub2_condisCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub2_insdisCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub2_cladisCnt}" pattern="#,###"/></b></td>
            </tr>            
            <!-- 4종 합계부분 끝 -->
            <!-- 1+4종 합계부분 시작 -->
            <tr bgcolor="#E7ECF1">
                <td colspan="3"><b>1종+4종 합계</b></td>
				<td><b><fmt:formatNumber value="${sub1_basicCnt+sub2_basicCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_primCnt+sub2_primCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_endsumCnt+sub2_endsumCnt}" pattern="#,###"/></b></td>
				<td><b><font color="blue"><fmt:formatNumber value="${sub1_compCnt+sub2_compCnt}" pattern="#,###"/></font></b></td>
				<td><b><fmt:formatNumber value="${sub1_conCnt+sub2_conCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_insCnt+sub2_insCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_claCnt+sub2_claCnt}" pattern="#,###"/></b></td>
				<td><b><font color="red"><fmt:formatNumber value="${sub1_compdisCnt+sub2_compdisCnt}" pattern="#,###"/></font></b></td>
				<td><b><fmt:formatNumber value="${sub1_condisCnt+sub2_condisCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_insdisCnt+sub2_insdisCnt}" pattern="#,###"/></b></td>
				<td><b><fmt:formatNumber value="${sub1_cladisCnt+sub2_cladisCnt}" pattern="#,###"/></b></td>
            </tr>
            <!-- 1+4종 합계부분 끝 -->
            </tbody>
        </table>
    </div>
</div>