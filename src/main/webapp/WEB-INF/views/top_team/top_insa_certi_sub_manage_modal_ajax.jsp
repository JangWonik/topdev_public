<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<table>	
	<tr>
		<th width="10%">순번</th>		
		<th width="30%">등록보종</th>
		<th width="30%">등록번호</th>		
		<th width="30%">-</th>
	</tr>
	<c:if test="${certiSubMemberList.size() == 0}">
		<tr>
			<td colspan="4">등록된 보조인 정보가 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach items="${certiSubMemberList}" var = "memberVo" varStatus="memberStatus">
		<!-- 보기 페이지 -->
		<tr id="tr_certi_view_${memberVo.ckey}">
			<td>${certiSubMemberList.size() - memberStatus.index}</td>			
			<td>${memberVo.certi_type_nm}</td>
			<td>${memberVo.certi_number}</td>						
			<td>
				<a href="javascript:doInfoSubModify('${memberVo.ckey}');" class="btn-certi-aprv" style="background:#CEE3F6;width:25px;">수정</a>				
				<a href="javascript:doInfoSubDeleteModal('${memberVo.ckey}','${memberVo.certi_number}');" class="btn-certi-aprv" style="background:#F6CECE;width:25px;">삭제</a>
			</td>
		</tr>
		<!-- 수정페이지 -->
		<tr id="tr_certi_edit_${memberVo.ckey}" style="display:none;background-color:#F7F8E0;">
			<td>${certiMemberList.size() - memberStatus.index}</td>			
			<td>
				<select id="editCertiType_${memberVo.ckey}" name="editCertiType_${memberVo.ckey}" style="width:80px;">
					<option value="">- 선택 -</option>
					<c:forEach items="${srchCertiTypeList}" var="cTypeVo">							
						<option value="${cTypeVo.certi_type}" <c:if test="${memberVo.certi_type == cTypeVo.certi_type}">selected</c:if> >
							${cTypeVo.certi_type_nm}
						</option>	
					</c:forEach>
				</select>								
			</td>
			<td>
				<input type="text" id="editCertiNumber_${memberVo.ckey}" name="editCertiNumber_${memberVo.ckey}" value="${memberVo.certi_number}" style="width:100px;">				
			</td>			
			<td>
				<a href="javascript:doInfoSubEditSave('${memberVo.ckey}');" class="btn-certi-aprv" style="background:#D0A9F5;width:25px;">저장</a>
				<a href="javascript:doInfoSubEditCancel('${memberVo.ckey}');" class="btn-certi-aprv" style="background:#F6CECE;width:25px;">취소</a>				
			</td>
		</tr>
	</c:forEach>
</table>	