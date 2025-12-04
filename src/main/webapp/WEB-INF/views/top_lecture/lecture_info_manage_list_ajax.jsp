<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${infoList.size() == 0}">
			<tr>
				<td colspan="12" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${infoList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="info_view_${items.ekey}">
					<td align="center" width="5%">${infoList.size() - status.index}</td>
					<td align="center" width="4%">
						<c:choose>
							<c:when test="${items.team_type eq 0}">공통</c:when>
							<c:when test="${items.team_type eq 1}">물보험</c:when>
							<c:when test="${items.team_type eq 4}">인보험</c:when>
						</c:choose>
					</td>
					<td width="13%" style="text-align:left;padding-left:5px;" title="${items.subject}">
						<div style="width:150px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						${items.subject}
						</div>
					</td>
					<td width="13%" style="text-align:left;padding-left:5px;" title="${items.introduce}">
						<div style="width:150px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						${items.introduce}
						</div>
					</td>
					<td width="7%" align="center">${items.time_second} 초</td>
					<td width="7%" align="center">${items.manager_name}</td>
					<td width="9%" style="text-align:left;padding-left:5px;">${items.link_path}</td>
					<td width="8%" align="center">${items.reg_date_fmt}</td>					
					<td width="13%" align="center" title="${items.file_org_name}">
						<c:choose>
							<c:when test="${empty items.file_org_name}">파일없음</c:when>
							<c:otherwise>
								<a href="eInfoFileDownload?ekey=${items.ekey}">
								<c:choose>
									<c:when test="${fn:length(items.file_org_name) > 10}">
										${fn:substring(items.file_org_name,0,10)}...
									</c:when>
									<c:otherwise>${items.file_org_name}</c:otherwise>
								</c:choose>
								</a>&nbsp;
								<img class="btn_file_del" src="./resources/ls_img/btn_del_s.gif" alt="파일삭제" style="cursor:pointer" onclick="doAttachDelete('${items.ekey}','${items.file_org_name}')"/>								
							</c:otherwise>
						</c:choose>						
					</td>
					<td width="3%" align="center">
						<c:choose>
							<c:when test="${items.preview_flag eq 1}">O</c:when>
							<c:otherwise>X</c:otherwise>
						</c:choose>
					</td>
					<td width="6%" align="center">
						${items.quiz_cnt} 개
						<img src="./resources/ls_img/ls_invoice/btn_s_edite.gif" style="cursor:pointer;"	onclick="updateLectureQuizRelation('${items.ekey}')" title="테스트등록" />
					</td>
					<td width="15%" align="center">
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doInfoView('${items.ekey}');" style="background-color:#FFBF00">보기</a>
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doInfoModify('${items.ekey}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:doInfoDelete('${items.ekey}','${items.subject}');">삭제</a>
					</td>
				</tr>
				
				<!-- 수정목록 -->				
				<tr id="info_edit_${items.ekey}" style="display:none;background-color:#FFECEC;">
					<td align="center" width="4%">${infoList.size() - status.index}</td>
					<td align="center" width="5%">						
						<select id="info_team_type_edit_${items.ekey}" name="info_team_type_edit_${items.ekey}" style="width:50px;">
							<option value="0" <c:if test="${items.team_type eq 0}">selected</c:if> >공통</option>
							<option value="1" <c:if test="${items.team_type eq 1}">selected</c:if> >물보험</option>
							<option value="4" <c:if test="${items.team_type eq 4}">selected</c:if> >인보험</option>
						</select>
					</td>
					<td width="13%" style="text-align:left;padding-left:5px;">
						<input type="text" id="info_subject_edit_${items.ekey}" name="info_subject_edit_${items.ekey}" value="${items.subject}" style="width:150px;"/>
					</td>
					<td width="13%" style="text-align:left;padding-left:5px;">
						<input type="text" id="info_introduce_edit_${items.ekey}" name="info_introduce_edit_${items.ekey}" value="${items.introduce}" style="width:150px;"/>
					</td>
					<td width="7%" align="center">
						<input type="text" id="info_time_second_edit_${items.ekey}" name="info_time_second_edit_${items.ekey}" value="${items.time_second}" style="width:60px;"/> 초
					</td>
					<td width="7%" style="text-align:left;padding-left:5px;">
						<input type="text" id="info_manager_name_edit_${items.ekey}" name="info_manager_name_edit_${items.ekey}" value="${items.manager_name}" style="width:70px;"/>
					</td>
					<td width="9%" style="text-align:left;padding-left:5px;">
						<input type="text" id="info_link_path_edit_${items.ekey}" name="info_link_path_edit_${ekey}" value="${items.link_path}" style="width:95px;"/>
					</td>
					<td width="8%" align="center">${items.reg_date_fmt}</td>
					<%-- <td width="6%" align="center">${items.reg_user_name}</td> --%>
					<td width="13%" align="center">
						<c:choose>
							<c:when test="${empty items.file_org_name}">
								<input type="file" id="info_attach_file_edit_${items.ekey}" name="info_attach_file_edit_${items.ekey}" style="width: 90%;">
							</c:when>
							<c:otherwise>${items.file_org_name}</c:otherwise>
						</c:choose>						
					</td>
					<td colspan="2" width="10%" align="center">미리보기 사용
						<input type="checkbox" id="info_preview_flag_edit_${items.ekey}" name="info_preview_flag_edit_${items.ekey}" <c:if test="${items.preview_flag eq 1}">checked</c:if> >						
					</td>					
					<td width="11%" align="center">
						<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick="javascript:doInfoEditSave('${items.ekey}');">저장</a>
						<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick="javascript:doInfoEditCancel('${items.ekey}');">취소</a>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>	
</table>