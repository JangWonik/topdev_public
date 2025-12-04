<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<c:choose>		
		<c:when test="${writtenTeamList.size() == 0}">
			<tr>
				<td colspan="9" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<input type="hidden" id="written_total_size" value="${writtenTeamList.size()}"/>			
			<c:forEach var="items" items="${writtenTeamList}" varStatus="status">
				<c:set var="sumSuimCnt" value="${sumSuimCnt + items.suimCnt}"/>
				<c:set var="sumEndCnt" value="${sumEndCnt + items.endCnt}"/>
				<c:set var="sumCancelCnt" value="${sumCancelCnt + items.cancelCnt}"/>
				<%-- <c:set var="sumTransCnt" value="${sumTransCnt + items.transCnt}"/> --%>
				<c:set var="sumTransCnt" value="${sumTransCnt + items.transCntMinus}"/>
				<c:set var="sumUnsolveCnt" value="${sumUnsolveCnt + items.unsolveCnt}"/>
												
				<input type="hidden" id="user_no_${status.index}" value="${items.userNo}"/>
				<tr id="written_view_${items.serialNo}">
					<td style="width:150px;text-align:center;">${items.ptnrName}</td>			
					<td style="width:150px;text-align:center;">${items.centerName}</td>
					<td style="width:150px;text-align:center;">${items.teamName}</td>					
					<td style="width:85px;text-align:right;">${items.suimCnt} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.endCnt} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.cancelCnt} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.transCntMinus} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.unsolveCnt} 건&nbsp;</td>
					<td style="width:110px;text-align:center;">${items.baseDateFmt}</td>
					<td style="width:110px;text-align:center;">${items.regDateFmt}</td>					
				</tr>
			</c:forEach>
			<tr>
				<th colspan="3">합 계</th>
				<th style="text-align:right;">${sumSuimCnt} 건&nbsp;</th>
				<th style="text-align:right;">${sumEndCnt} 건&nbsp;</th>				
				<th style="text-align:right;">${sumCancelCnt} 건&nbsp;</th>
				<th style="text-align:right;">${sumTransCnt} 건&nbsp;</th>
				<th style="text-align:right;">${sumUnsolveCnt} 건&nbsp;</th>
				<th colspan="2">-</th>
			</tr>
		</c:otherwise>
	</c:choose>	
</table>
<script>
$(document).ready(function(){
	$("#top_loading").hide();	
});
</script>