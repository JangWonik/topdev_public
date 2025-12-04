<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<table>	
	<tr>
		<th width="5%">순번</th>
		<th width="15%">부서명</th>
		<th width="12%">이름</th>
		<th width="10%">등록보종</th>
		<th width="15%">등록번호</th>
		<th width="13%">등록일자</th>
		<th width="18%">지점연락처</th>
		<th width="12%">-</th>
	</tr>
	<c:forEach items="${certiMemberList}" var = "memberVo" varStatus="memberStatus">
		<!-- 보기 페이지 -->
		<tr id="tr_certi_view_${memberVo.ckey}">
			<td>${certiMemberList.size() - memberStatus.index}</td>
			<td>${memberVo.team_name}</td>
			<td>${memberVo.user_name}</td>
			<td>${memberVo.certi_type_nm}</td>
			<td>${memberVo.certi_number}</td>
			<td>${memberVo.certi_date_fmt}</td>
			<td>${memberVo.work_phone}</td>			
			<td>
				<a href="javascript:doInfoModify('${memberVo.ckey}');" class="btn-certi-aprv" style="background:#CEE3F6;width:25px;">수정</a>
				<%-- <a href="javascript:doInfoDelete('${memberVo.ckey}','${memberVo.user_no}');" class="btn-certi-aprv" style="background:#F6CECE;width:25px;">삭제</a> --%>
				<!-- 보조인 여부와 관계없이 삭제 안내 모달창을 보여주는 방식으로 변경 -->
				<a href="javascript:doInfoDeleteModal('${memberVo.ckey}','${memberVo.user_no}');" class="btn-certi-aprv" style="background:#F6CECE;width:25px;">삭제</a>
			</td>
		</tr>
		<!-- 수정페이지 -->
		<tr id="tr_certi_edit_${memberVo.ckey}" style="display:none;background-color:#F7F8E0;">
			<td>${certiMemberList.size() - memberStatus.index}</td>
			<td>${memberVo.team_name}</td>
			<td>${memberVo.user_name}</td>
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
				<input type="text" class="calendar" id="editCertiDate_${memberVo.ckey}" name="editCertiDate_${memberVo.ckey}" value="${memberVo.certi_date_fmt}" style="width:80px;">
			</td>
			<td>
				<input type="text" id="editCertiPhone1_${memberVo.ckey}" name="editCertiPhone1_${memberVo.ckey}" style="width:30px;" maxlength="3" value="${memberVo.work_phone1}">-
				<input type="text" id="editCertiPhone2_${memberVo.ckey}" name="editCertiPhone2_${memberVo.ckey}" style="width:40px;" maxlength="4" value="${memberVo.work_phone2}">-
				<input type="text" id="editCertiPhone3_${memberVo.ckey}" name="editCertiPhone3_${memberVo.ckey}" style="width:40px;" maxlength="4" value="${memberVo.work_phone3}">				
			</td>
			<td>
				<a href="javascript:doInfoEditSave('${memberVo.ckey}');" class="btn-certi-aprv" style="background:#D0A9F5;width:25px;">저장</a>
				<a href="javascript:doInfoEditCancel('${memberVo.ckey}');" class="btn-certi-aprv" style="background:#F6CECE;width:25px;">취소</a>				
			</td>
		</tr>
	</c:forEach>
</table>	