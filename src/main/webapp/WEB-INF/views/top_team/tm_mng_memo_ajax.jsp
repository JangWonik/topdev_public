<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table class="tableStyle2">	
	<c:choose>		
		<c:when test="${memoList.size() == 0}">
			<tr>
				<td colspan="5" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${memoList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="memo_view_${items.pkey}">
					<td align="center" width="5%">${memoList.size() - status.index}</td>
					<td width="70%" style="text-align:left;padding-left:10px;">${items.memo_content}</td>
					<td align="center" width="10%">${items.user_name}</td>
					<td align="center" width="10%">${items.reg_date_fmt}</td>
					<td align="center" width="15%">						
						<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick="javascript:doMemoModify('${items.pkey}');">수정</a>
						<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick="javascript:doMemoDelete('${items.pkey}','${items.memo_content}');">삭제</a>
					</td>
				</tr>
				<!-- 수정목록 -->
				<tr id="memo_edit_${items.pkey}" style="display:none;background-color:#FFECEC;">
					<td align="center" width="5%">${memoList.size() - status.index}</td>
					<td width="70%" style="text-align:left;padding-left:10px;">
						<input type="text" id="memo_content_edit_${items.pkey}" name="memo_content_edit_${items.pkey}" value="${items.memo_content}" style="width:480px;"/>					
					</td>
					<td align="center" width="10%">${items.user_name}</td>
					<td align="center" width="10%">${items.reg_date_fmt}</td>										
					<td width="15%" align="center">
						<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick="javascript:doMemoEditSave('${items.pkey}');">저장</a>
						<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick="javascript:doMemoEditCancel('${items.pkey}');">취소</a>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>