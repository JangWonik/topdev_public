<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${processList.size() == 0}">
			<tr>
				<td colspan="12" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${processList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="process_view_${items.pkey}">
					<td align="center" width="5%">${processList.size() - status.index}</td>
					<td align="center" width="5%">
						<c:choose>
							<c:when test="${items.lecture_type eq 0 }">상시교육</c:when>
							<c:when test="${items.lecture_type eq 1 }">의무교육</c:when>
						</c:choose>
					</td>
					<td align="center" width="5%">
						<c:choose>
							<c:when test="${items.team_type eq 0}">공통</c:when>
							<c:when test="${items.team_type eq 1}">물보험</c:when>
							<c:when test="${items.team_type eq 4}">인보험</c:when>
						</c:choose>
					</td>
					<td width="12%" align="center">${items.category_name}</td>
					<td width="15%" style="text-align:left;padding-left:5px;" title="${items.p_content}">${items.p_title}</td>
					<td width="10%" align="center">${items.apply_sdate_fmt} ~ ${items.apply_edate_fmt}</td>
					<td width="10%" align="center">${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>
					<td width="8%" align="center">${items.reg_user_name}</td>
					<td width="8%" align="center">${items.reg_date_fmt}</td>
					<td width="6%" align="center">
						${items.lecture_cnt} 개
						<img src="./resources/ls_img/ls_invoice/btn_s_edite.gif" style="cursor:pointer;"	onclick="updateLectureRelation('${items.pkey}')" title="교육등록" />
					</td>
					<td width="6%" align="center">
						<c:choose>
							<c:when test="${items.isuse eq 0}">사용중</c:when>
							<c:when test="${items.isuse eq 1}">미사용</c:when>
						</c:choose>
						<br/>
						<c:choose>
							<c:when test="${items.qna_use eq 0}">미사용</c:when>
							<c:when test="${items.qna_use eq 1}">사용중</c:when>
						</c:choose>						
					</td>					
					<td width="10%" align="center">						
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doProcessModify('${items.pkey}','${items.category_no}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:doProcessDelete('${items.pkey}','${items.p_title}');">삭제</a>
					</td>
				</tr>
				
				<!-- 수정목록 시작 -->
				<tr id="process_edit_${items.pkey}" style="display:none;background-color:#FFECEC;">
					<td colspan="12">
						<table>
							<tr>
								<th width="5%">No</th>			
								<th width="12%">구분</th>
								<th width="23%">분류</th>
								<th width="25%">과정명</th>
								<th width="25%">수강신청기간</th>						
								<th width="10%">과정 사용여부</th>
								<th width="10%"> - </th>			
							</tr>
							<tr>
								<td align="center" rowspan="3">
									${processList.size() - status.index}
								</td>
								<td align="center">
									<select id="process_team_type_edit_${items.pkey}" name="process_team_type_edit_${items.pkey}" style="width:110px;">
										<option value="0" <c:if test="${items.team_type eq 0}">selected</c:if> >공통</option>
										<option value="1" <c:if test="${items.team_type eq 1}">selected</c:if> >물보험</option>
										<option value="4" <c:if test="${items.team_type eq 4}">selected</c:if> >인보험</option>
									</select>
								</td>
								<td style="padding-left:5px;">				
									<select id="process_category_no_edit_${items.pkey}" name="process_category_no_edit_${items.pkey}" style="width: 220px;">
										<option value="">- 전체 -</option>
										<c:forEach items="${selCategoryList}" var="categoryVo">
											<option value="${categoryVo.ckey}" >${categoryVo.category_name}</option>
										</c:forEach>
									</select>
								</td>
								<td style="padding-left:5px;">									
									<input type="text" id="process_p_title_edit_${items.pkey}" name="process_p_title_edit_${items.pkey}" value="${items.p_title}" style="width:270px;"/>
								</td>
								<td align="center">									
									<input type="text" class="calendar" id="process_apply_sdate_edit_${items.pkey}" name="process_apply_sdate_edit_${items.pkey}" value="${items.apply_sdate_fmt}" style="width:100px;"/> ~ 
									<input type="text" class="calendar" id="process_apply_edate_edit_${items.pkey}" name="process_apply_edate_edit_${items.pkey}" value="${items.apply_edate_fmt}" style="width:100px;"/>					
								</td>			
								<td align="center">									
									<select id="process_isuse_edit_${items.pkey}" name="process_isuse_edit_${items.pkey}" style="width:90px;">
										<option value="0" <c:if test="${items.isuse eq 0}">selected</c:if> >사용</option>
										<option value="1" <c:if test="${items.isuse eq 1}">selected</c:if> >미사용</option>					
									</select>
								</td>
								<td align="center" rowspan="3">
									<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick="javascript:doProcessEditSave('${items.pkey}');">저장</a>
									<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick="javascript:doProcessEditCancel('${items.pkey}');">취소</a>
								</td>			
							</tr>
							<tr>
								<th>교육구분</th>
								<th colspan="2">과정설명</th>
								<th>교육기간</th>
								<th>Q&A 사용여부</th>
							</tr>
							<tr>
								<td align="center">
									<select id="process_lecture_type_edit_${items.pkey}" name="process_lecture_type_edit_${items.pkey}" style="width:110px;">
										<option value="0" <c:if test="${items.lecture_type eq 0}">selected</c:if> >상시교육</option>
										<option value="1" <c:if test="${items.lecture_type eq 1}">selected</c:if> >의무교육</option>					
									</select>
								</td>
								<td style="padding-left:5px;" colspan="2">
									<input type="text" id="process_p_content_edit_${items.pkey}" name="process_content_edit_${items.pkey}" style="width:505px;" value="${items.p_content}"/>
								</td>
								<td align="center">									
									<input type="text" class="calendar" id="process_show_sdate_edit_${items.pkey}" name="process_show_sdate_edit_${items.pkey}" value="${items.show_sdate_fmt}" style="width:100px;"/> ~ 
									<input type="text" class="calendar" id="process_show_edate_edit_${items.pkey}" name="process_show_edate_edit_${items.pkey}" value="${items.show_edate_fmt}" style="width:100px;"/>	
								</td>
								<td align="center">
									<select id="process_qna_use_edit_${items.pkey}" name="process_qna_use_edit_${items.pkey}" style="width:90px;">
										<option value="0" <c:if test="${items.qna_use eq 0}">selected</c:if> >미사용</option>
										<option value="1" <c:if test="${items.qna_use eq 1}">selected</c:if> >사용</option>					
									</select>
								</td>
							</tr>
						</table>
					</td>					
				</tr>		
				<!-- 수정목록 끝 -->		
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>