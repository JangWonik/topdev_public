<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>
		<c:when test="${contractTypeList.size() eq 0}">
			<tr>
				<td colspan="4" align="center">등록 된 계약서 종류 분류 값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${contractTypeList}" varStatus="status">
				<tr id="tr_conType_${items.ckey}">
					<td width="10%" align="center">${contractTypeList.size() - status.index}</td>
					<td width="60%" style="text-align:left;padding-left:10px;">${items.code_name}</td>
					<td width="20%" align="center">
						<c:choose>
							<c:when test="${items.is_del eq 0}">사용함</c:when>
							<c:otherwise>사용안함</c:otherwise>
						</c:choose>
					</td>			
					<td width="20%" align="center">
						<a class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doTypeModify('${items.ckey}');" href="#noloc">수정</a>&nbsp;
						<a class="btn-equipment-del-s" id="btn-search" onclick="javascript:doTypeDelete('${items.ckey}','${items.code_name}');" href="#noloc">삭제</a>
					</td>
				</tr>
				
				<tr id="tr_conType_edit_${items.ckey}" style="display:none;">
					<td width="10%" align="center">${contractTypeList.size() - status.index}</td>
					<td width="60%" style="text-align:left;padding-left:10px;">
						<input type="text" id="type_code_name_mod_${items.ckey}" name="type_code_name_mod_${items.ckey}" style="width:670px;" value="${items.code_name}"/>
					</td>
					<td width="20%" align="center">						
						사용함 <input type="radio" id="type_is_del_mod_${items.ckey}_0" name="type_is_del_mod_${items.ckey}" value="0" <c:if test="${items.is_del eq 0}">checked</c:if> >&nbsp;
						사용안함 <input type="radio" id="type_is_del_mod_${items.ckey}_1" name="type_is_del_mod_${items.ckey}" value="1" <c:if test="${items.is_del eq 1}">checked</c:if>>
					</td>
					<td width="20%" align="center">
						<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick="javascript:typeModSave('${items.ckey}');">저장</a>&nbsp;
						<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick="javascript:typeModCancel('${items.ckey}');">취소</a>
					</td>			
				</tr>
			</c:forEach>	
		</c:otherwise>
	</c:choose>
</table>