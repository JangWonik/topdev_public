<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<c:choose>		
		<c:when test="${writtenList.size() == 0}">
			<tr>
				<td colspan="9" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<input type="hidden" id="written_total_size" value="${writtenList.size()}"/>			
			<c:forEach var="items" items="${writtenList}" varStatus="status">
				<input type="hidden" id="user_no_${status.index}" value="${items.userNo}"/>
				<tr id="written_view_${items.serialNo}">			
					<td style="width:120px;text-align:center;">${items.ptnrName}</td>
					<td style="width:140px;text-align:center;">${items.centerName}</td>
					<td style="width:120px;text-align:center;">${items.teamName}</td>
					<td style="width:100px;text-align:center;">${items.userName}</td>
					<td style="width:85px;text-align:right;">${items.suimCnt} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.endCnt} 건&nbsp;</td>
					<%-- <td style="width:85px;text-align:right;">${items.cancelCnt} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.transCnt} 건&nbsp;</td> --%>
					<td style="width:85px;text-align:right;">
						<a href="javascript:doCancelView('${items.userNo}','${items.teamId}','${items.teamName}','${items.userName}','${items.baseDateFmt}')">
						${items.cancelCnt} 건
						</a>												
						<img src="./resources/ls_img/report/icon_change.gif" style="cursor:pointer;" border="0" width="14" height="14" onclick="doCancelModal('${items.userNo}','${items.teamId}','${items.teamName}','${items.userName}','${items.baseDateFmt}');">&nbsp;
					</td>
					<td style="width:85px;text-align:right;">
						<a href="javascript:doTransView('${items.userNo}','${items.teamId}','${items.teamName}','${items.userName}','${items.baseDateFmt}')">
						${items.transCntMinus} 건
						</a>						
						<img src="./resources/ls_img/report/icon_change.gif" style="cursor:pointer;" border="0" width="14" height="14" onclick="doTransModal('${items.userNo}','${items.teamId}','${items.teamName}','${items.userName}','${items.baseDateFmt}');">&nbsp;
					</td>					
					<td style="width:85px;text-align:right;">${items.unsolveCnt} 건&nbsp;</td>
					<td style="width:100px;text-align:center;">${items.baseDateFmt}</td>
					<td style="width:100px;text-align:center;">${items.regDateFmt}</td>
					<td style="width:110px;text-align:center;">
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doModify('${items.serialNo}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:doDelete('${items.serialNo}');">삭제</a>						
					</td>										
				</tr>
				<tr id="written_edit_${items.serialNo}" style="display:none;">	
					<td style="width:120px;text-align:center;">${items.ptnrName}</td>		
					<td style="width:140px;text-align:center;">${items.centerName}</td>
					<td style="width:120px;text-align:center;">${items.teamName}
						<input type="hidden" id="modTeamId_${items.serialNo}" name="modTeamId" value="${items.teamId}"/>
					</td>
					<td style="width:100px;text-align:center;">
						${items.userName}
						<input type="hidden" id="modUserNo_${items.serialNo}" name="modUserNo" value="${items.userNo}"/>
					</td>
					<td style="width:85px;text-align:right;">
						<input type="text" id="modSuimCnt_${items.serialNo}" name="modSuimCnt" value="${items.suimCnt}" size="3" /> 건&nbsp;
					</td>
					<td style="width:85px;text-align:right;">
						<input type="text" id="modEndCnt_${items.serialNo}" name="modEndCnt" value="${items.endCnt}"  size="3" /> 건&nbsp;
					</td>
					<td style="width:85px;text-align:right;">${items.cancelCnt} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.transCntMinus} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.unsolveCnt} 건&nbsp;</td>
					<td style="width:100px;text-align:center;">${items.baseDateFmt}
						<input type="hidden" id="modBaseDate_${items.serialNo}" name="modBaseDate" value="${items.baseDateFmt}"/>
					</td>					
					<td style="width:100px;text-align:center;">${items.regDateFmt}</td>
					<td style="width:110px;text-align:center;">
						<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick="javascript:doSave('${items.serialNo}');">저장</a>
						<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick="javascript:doCancel('${items.serialNo}');">취소</a>
					</td>										
				</tr>				
			</c:forEach>				
		</c:otherwise>
	</c:choose>	
</table>
<script>
$(document).ready(function(){
	$("#top_loading").hide();	
});
</script>