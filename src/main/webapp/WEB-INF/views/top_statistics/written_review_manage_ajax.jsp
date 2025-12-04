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
			<input type="hidden" id="nChkDate" value="${nChkDate}">
			<c:forEach var="items" items="${writtenList}" varStatus="status">				
				<input type="hidden" id="user_no_${status.index}" value="${items.userNo}"/>
				<tr id="written_view_${status.index}">
					<td style="width:120px;text-align:center;">${items.ptnrName}</td>			
					<td style="width:140px;text-align:center;">${items.centerName}</td>
					<td style="width:120px;text-align:center;">${items.teamName}</td>
					<td style="width:100px;text-align:center;">${items.userName}</td>
					<td style="width:85px;text-align:right;">${items.suimCnt} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">${items.endCnt} 건&nbsp;</td>
					<td style="width:85px;text-align:right;">
						<a href="javascript:doCancelView('${items.userNo}','${items.teamId}','${items.teamName}','${items.userName}','${items.baseDateFmt}')">
						${items.cancelCnt} 건
						</a>
						&nbsp;
						<a href="javascript:doCancelModal('${items.userNo}','${items.teamId}','${items.teamName}','${items.userName}','${items.baseDateFmt}');">						
						<img src="./resources/ls_img/report/icon_change.gif" class="change-button" style="cursor:pointer;" border="0" width="14" height="14">&nbsp;
						</a>
					</td>
					<td style="width:85px;text-align:right;">
						<a href="javascript:doTransView('${items.userNo}','${items.teamId}','${items.teamName}','${items.userName}','${items.baseDateFmt}')">
						${items.transCntMinus} 건
						</a>
						&nbsp;
						<a href="javascript:doTransModal('${items.userNo}','${items.teamId}','${items.teamName}','${items.userName}','${items.baseDateFmt}');">
						<img src="./resources/ls_img/report/icon_change.gif" class="change-button" style="cursor:pointer;" border="0" width="14" height="14">&nbsp;
						</a>
					</td>
					<td style="width:85px;text-align:right;">${items.unsolveCnt} 건&nbsp;</td>
					<td style="width:100px;text-align:center;">${items.baseDateFmt}</td>
					<td style="width:100px;text-align:center;">${items.regDateFmt}</td>
					<%-- <td style="width:110px;text-align:center;">
						<c:if test="${!empty items.serialNo}">
							<a href="#noloc" class="btn-equipment-cancel" id="btn-delete" onclick='javascript:doDelete(${items.serialNo});'>삭제</a>
						</c:if>						
					</td> --%>
				</tr>
				<tr id="written_edit_${status.index}" style="display:none;">				
					<td style="width:120px;text-align:center;">${items.ptnrName}
						<input type="hidden" name="ptnr_id" id="ptnr_id_${status.index}" value="${items.ptnrId}"/>
					</td>															
					<td style="width:140px;text-align:center;">${items.centerName}</td>
					<td style="width:120px;text-align:center;">${items.teamName}
						<input type="hidden" name="team_id" id="team_id_${status.index}" value="${items.teamId}"/>
					</td>						
					<td style="width:100px;text-align:center;">${items.userName}</td>
					<td style="width:85px;text-align:right;">
						<input type="text" name="suim_cnt" id="suim_cnt_${status.index}" value="${items.suimCnt}" style="width:60px;text-align:right;"> 건&nbsp;
					</td>
					<td style="width:85px;text-align:right;">
						<input type="text" name="end_cnt" id="end_cnt_${status.index}" value="${items.endCnt}" style="width:60px;text-align:right;"> 건&nbsp;
					</td>
					<td style="width:85px;text-align:right;">
						${items.cancelCnt} 건&nbsp;						
					</td>
					<td style="width:85px;text-align:right;">
						${items.transCntMinus} 건&nbsp;						
					</td>
					<td style="width:85px;text-align:right;">						
						${items.unsolveCnt} 건&nbsp;
					</td>
					<td style="width:100px;text-align:center;">						
						${s_base_date}
						<input type="hidden" name="base_date" id="base_date_${status.index}" value="${s_base_date}" readonly style="width:90px;">
					</td>
					<td style="width:100px;text-align:center;">${items.regDateFmt}</td>					
				</tr>
			</c:forEach>				
		</c:otherwise>
	</c:choose>	
</table>
<script>
$(document).ready(function(){
	$("#top_loading").hide();
	_initMask();
	
	var nChkDate = $("#nChkDate").val();
	//이전날짜 데이터는 삭제 불가 (당분간 이전데이터도 등록되도록 수정)
	//if( nChkDate < 0 ){
		//$(".btn-equipment-cancel").hide();		
	//}	
});
</script>