<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${insuList.size() == 0}">
			<tr>
				<td colspan="6" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${insuList}" varStatus="status">			 	
			 	<tr id="insu_company_view_${items.ikey}">
			 		<td width="5%" align="center">${insuList.size() - status.index}</td>			 		
			 		<td width="50%" align="center">${items.insu_name}</td>
			 		<td width="10%" align="center">
			 			<c:choose>
			 				<c:when test="${items.is_use eq 0}">사용함</c:when>
			 				<c:otherwise>미사용</c:otherwise>
			 			</c:choose>
			 		</td>			 		
			 		<td width="10%" align="center">${items.reg_user_name}</td>
			 		<td width="10%" align="center">${items.reg_date_fmt}</td>
			 		<td width="15%" align="center">
			 			<a class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doInsuMod('${items.ikey}');" href="#noloc">수정</a>
			 			<a class="btn-equipment-del-s" id="btn-search" onclick="javascript:doInsuDelete('${items.ikey}','${items.insu_name}');" href="#noloc">삭제</a>
			 		</td>
			 	</tr>
			 	<tr id="insu_company_edit_${items.ikey}" style="display:none;">
			 		<td width="5%" align="center">${insuList.size() - status.index}</td>			 		
			 		<td width="50%" align="center">
			 			<input type="text" style="width:600px;" id="insu_name_mod_${items.ikey}" name="insu_name_mod_${items.ikey}" value="${items.insu_name}">			 			
			 		</td>
			 		<td width="10%" align="center">
			 			<select id="is_use_mod_${items.ikey}" name="is_use_mod_${items.ikey}" style="width:100px;">
			 				<option value="0" <c:if test="${items.is_use eq 0}"> selected </c:if> >사용함</option>
			 				<option value="1" <c:if test="${items.is_use eq 1}"> selected </c:if> >미사용</option>
			 			</select>			 			
			 		</td>			 		
			 		<td width="10%" align="center">${items.reg_user_name}</td>
			 		<td width="10%" align="center">${items.reg_date_fmt}</td>
			 		<td width="15%" align="center">
			 			<a class="btn-equipment-save-s" id="btn-search" onclick="javascript:doInsuModSave('${items.ikey}');" href="#noloc">저장</a>
			 			<a class="btn-equipment-del-s" id="btn-search" onclick="javascript:doInsuModCancel('${items.ikey}');" href="#noloc">취소</a>
			 		</td>
			 	</tr>			 	
			 </c:forEach>			
		</c:otherwise>
	</c:choose>	
</table>