<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${memberList.size() == 0}">
			<tr>
				<td colspan="9" align="center">검색결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${memberList}" varStatus="status">
				<c:set var="idx" value="${memberList.size() - status.index}"/>
				<tr id="info_view_${idx}">
					<td width="50px;">${idx}</td>
					<td width="100px;">${items.base_year}</td>
					<td width="100px;">${items.center_name}</td>
					<td width="100px;">${items.team_name}</td>
					<td width="100px;">${items.user_name}</td>
					<td width="50px;">${items.work_level_name}</td>
					<td width="100px;">${items.work_type_name}</td>
					<td width="100px;">${items.join_date_fmt}</td>
					<td width="150px;">
						<b>${items.target_val}</b>&nbsp;&nbsp;
						<c:choose>
							<c:when test="${empty items.base_year}">
								<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" style="background-color:#F781F3;" onclick="javascript:doInfoAdd('${idx}');">추가</a>
							</c:when>
							<c:otherwise>
								<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doInfoModify('${idx}');">수정</a>		
							</c:otherwise>
						</c:choose>
					</td>
					<td width="100px;">${items.user_state_name}</td>
					<c:if test="${memberList.size() < 23}">
						<td width="10px;"></td>
					</c:if>
				</tr>
				<tr id="info_edit_${idx}" style="display:none;background-color:#FFECEC;">
					<td width="50px;">${idx}</td>
					<td width="100px;">${items.base_year}</td>
					<td width="100px;">${items.center_name}</td>
					<td width="100px;">${items.team_name}</td>
					<td width="100px;">${items.user_name}</td>
					<td width="50px;">${items.work_level_name}</td>
					<td width="100px;">${items.work_type_name}</td>
					<td width="100px;">${items.join_date_fmt}</td>
					<td width="150px;">
						<input type="text" id="edit_target_val_${idx}" name="edit_target_val_${idx}" value="${items.target_val}" style="width:50px;text-align:right;"/>&nbsp;&nbsp;
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" style="background-color:#819FF7;" onclick="javascript:doInfoSave('${idx}','${items.user_no}','${items.base_year}');">저장</a>
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" style="background-color:#FA58AC;" onclick="javascript:doInfoCancel('${idx}');">취소</a>
					</td>
					<td width="100px;">${items.user_state_name}</td>
					<c:if test="${memberList.size() < 23}">
						<td width="10px;"></td>
					</c:if>
				</tr>
				<tr id="info_add_${idx}" style="display:none;background-color:#FFECEC;">
					<td width="50px;">${idx}</td>
					<td width="100px;">
						<input type="text" id="add_base_year_${idx}" name="add_base_year_${idx}" value="" style="width:80px;"/>
					</td>
					<td width="100px;">${items.center_name}</td>
					<td width="100px;">${items.team_name}</td>
					<td width="100px;">${items.user_name}</td>
					<td width="50px;">${items.work_level_name}</td>
					<td width="100px;">${items.work_type_name}</td>
					<td width="100px;">${items.join_date_fmt}</td>
					<td width="150px;">
						<input type="text" id="add_target_val_${idx}" name="add_target_val_${idx}" value="" style="width:50px;text-align:right;"/>&nbsp;&nbsp;
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" style="background-color:#819FF7;" onclick="javascript:doInfoAddSave('${idx}','${items.user_no}');">저장</a>
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" style="background-color:#FA58AC;" onclick="javascript:doInfoAddCancel('${idx}');">취소</a>
					</td>
					<td width="100px;">${items.user_state_name}</td>
					<c:if test="${memberList.size() < 23}">
						<td width="10px;"></td>
					</c:if>
				</tr>
			</c:forEach>			
		</c:otherwise>
	</c:choose>
</table>