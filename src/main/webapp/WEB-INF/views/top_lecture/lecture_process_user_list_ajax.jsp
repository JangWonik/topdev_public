<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${processUserList.size() == 0}">
			<tr>
				<td colspan="11" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${processUserList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="process_user_view_${items.pkey}">
					<td align="center" width="5%">${processUserList.size() - status.index}</td>
					<td align="center" width="5%">
						<c:choose>
							<c:when test="${items.team_type eq 0}">공통</c:when>
							<c:when test="${items.team_type eq 1}">물보험</c:when>
							<c:when test="${items.team_type eq 4}">인보험</c:when>
						</c:choose>
					</td>
					<td width="6%" align="center">${items.category_name}</td>
					<td width="20%" style="text-align:left;padding-left:5px;">${items.p_title}</td>
					<td width="15%" align="center">${items.apply_sdate_fmt} ~ ${items.apply_edate_fmt}</td>
					<td width="15%" align="center">${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>					
					<td width="10%" align="center">${items.total_time_fmt}</td>
					<td width="8%" align="center">${items.reg_date_fmt}</td>
					<td width="8%" align="center">
						${items.lecture_cnt} 개
						&nbsp;<img src="./resources/ls_img/btns_view.gif" style="cursor:pointer;"	onclick="lectureRelationView('${items.pkey}')" title="교육과정보기" />
					</td>					
					<td width="8%" align="center">						
						<c:choose>
							<c:when test="${items.ap_state eq 10}">
								<a href="#noloc" class="btn-equipment-green" id="btn-search" onclick="doUserApplyView('${items.pkey}','10');">결재대기</a>
							</c:when>
							<c:when test="${items.ap_state eq 11}">
								<a href="#noloc" class="btn-equipment-gray" id="btn-search" onclick="doUserApplyView('${items.pkey}','11');">결재완료</a>								
							</c:when>
							<c:when test="${items.ap_state eq 12}">
								<a href="#noloc" class="btn-equipment-cancel" id="btn-search" onclick="doUserApplyView('${items.pkey}','12');">결재반려</a>
							</c:when>
							<c:when test="${items.ap_state eq 99}">
								<a href="#noloc" class="btn-equipment-gray" id="btn-search" onclick="doUserApplyView('${items.pkey}','99');">신청취소</a>
							</c:when>
							<c:otherwise>
								<a href="#noloc" class="btn-equipment-mod" id="btn-search" onclick="doUserApply('${items.pkey}','${items.p_title}');">수강신청</a>		
							</c:otherwise>
						</c:choose>		
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>