<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${categoryList.size() == 0}">
			<tr>
				<td colspan="5" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${categoryList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="category_view_${items.ckey}">
					<td align="center" width="10%">${status.count}</td>
					<td width="40%" style="padding-left:10px;">${items.category_name}</td>
					<td align="center" width="10%">${items.category_ord}</td>
					<td align="center" width="20%">
						<c:choose>
							<c:when test="${items.isuse eq 0}">사용중</c:when>
							<c:otherwise>사용안함</c:otherwise>
						</c:choose>
					</td>
					<td width="20%" align="center">
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doCateModify('${items.ckey}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:doCateDelete('${items.ckey}','${items.category_name}');">삭제</a>
					</td>
				</tr>
				<!-- 수정목록 -->
				<tr id="category_edit_${items.ckey}" style="display:none;background-color:#FFECEC;">
					<td align="center" width="10%">${status.count}</td>
					<td width="40%" style="padding-left:10px;">
						<input type="text" id="category_name_edit_${items.ckey}" name="category_name_add_${items.ckey}" value="${items.category_name}" style="width:480px;"/>					
					</td>
					<td align="center" width="10%">
						<input type="text" id="category_ord_edit_${items.ckey}" name="category_ord_add_${items.ckey}" value="${items.category_ord}" style="text-align:right;width:100px;"/>						
					</td>
					<td align="center" width="20%">
						<select id="category_isuse_edit_${items.ckey}">							
							<option value="0" <c:if test="${items.isuse eq 0}">selected</c:if> >사용중</option>
							<option value="1" <c:if test="${items.isuse eq 1}">selected</c:if> >사용안함</option>
						</select>						
					</td>
					<td width="20%" align="center">
						<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick="javascript:doCateEditSave('${items.ckey}');">저장</a>
						<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick="javascript:doCateEditCancel('${items.ckey}');">취소</a>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>