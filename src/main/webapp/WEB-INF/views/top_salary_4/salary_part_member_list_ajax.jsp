<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${partMemberList.size() == 0}">
			<tr>
				<td colspan="9" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${partMemberList}" varStatus="status">			 	
			 	<tr id="part_member_view_${items.user_no}" <c:if test='${items.salary_4_part eq 0}'>bgcolor="#D0F5A9"</c:if> >			 	
			 		<td width="5%" align="center">${partMemberList.size() - status.index}</td>
			 		<td width="15%" align="center">${items.center_name}</td>
			 		<td width="15%" align="center">${items.team_name}</td>
			 		<td width="6%" align="center">${items.work_level_nm}</td>
			 		<td width="12%" align="center">${items.user_name}</td>			 		
			 		<td width="10%" align="center">${items.join_date_fmt}</td>
			 		<td width="15%" align="center">
			 			<c:choose>
			 				<c:when test="${items.salary_4_insu eq 0}"> - </c:when>
			 				<c:otherwise>${items.salary_4_insu_name}</c:otherwise>
			 			</c:choose>
			 		</td>
			 		<td width="15%" align="center">
			 			<c:choose>
			 				<c:when test="${items.salary_4_part eq 0}"> - </c:when>
			 				<c:otherwise>${items.salary_4_part_name}</c:otherwise>
			 			</c:choose>			 			
			 		</td>
			 		<td width="12%" align="center">
			 			<a class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doMemberPartMod(${items.user_no});" href="#noloc">수정</a>
			 		</td>
			 	</tr>
			 	<tr id="part_member_edit_${items.user_no}" style="display:none;">
			 		<td width="5%" align="center">${partMemberList.size() - status.index}</td>
			 		<td width="15%" align="center">${items.center_name}</td>
			 		<td width="15%" align="center">${items.team_name}</td>
			 		<td width="6%" align="center">${items.work_level_nm}</td>
			 		<td width="12%" align="center">${items.user_name}</td>			 		
			 		<td width="10%" align="center">${items.join_date_fmt}</td>
			 		<td width="15%" align="center">			 						 				
	 					<select id="sel_part_insu_${items.user_no}" style="width: 150px;" onchange="javascript:doPartInsuChange(${items.user_no});">
	 						<option value="0" <c:if test="${items.salary_4_insu eq 0}">selected</c:if> >미설정</option>
	 						<c:forEach var="selInsu" items="${selInsuList}" varStatus="status">
	 							<option value="${selInsu.ikey}" <c:if test="${items.salary_4_insu eq selInsu.ikey}">selected</c:if> >${selInsu.insu_name}</option>
	 						</c:forEach>
	 					</select>	
			 		</td>
			 		<td width="15%" align="center">
			 			<select id="sel_part_${items.user_no}" style="width: 150px;">
			 				<option value="0" <c:if test="${items.salary_4_part eq 0}">selected</c:if> >미설정</option>
			 				<c:forEach var="selPart" items="${selPartList}" varStatus="status">
	 							<option value="${selPart.pkey}" <c:if test="${items.salary_4_part eq selPart.pkey}">selected</c:if> >${selPart.part_name}</option>
	 						</c:forEach>
			 			</select>			 			
			 		</td>
			 		<td width="12%" align="center">
			 			<a class="btn-equipment-save-s" id="btn-search" onclick="javascript:doMemberPartSave(${items.user_no});" href="#noloc">저장</a>
			 			<a class="btn-equipment-cancel-s" id="btn-search" onclick="javascript:doMemberPartCancel(${items.user_no});" href="#noloc">취소</a>
			 		</td>
			 	</tr>			 	
			 </c:forEach>			
		</c:otherwise>
	</c:choose>	
</table>