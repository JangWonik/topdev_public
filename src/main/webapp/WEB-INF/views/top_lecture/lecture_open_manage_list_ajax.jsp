<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${openList.size() == 0}">
			<tr>
				<td colspan="9" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${openList}" varStatus="status">
				<!-- 보기목록 -->
				<tr>
					<td align="center" width="7%">${openList.size() - status.index}</td>
					<td align="center" width="7%">
						<c:choose>
							<c:when test="${items.team_type eq 0}">공통</c:when>
							<c:when test="${items.team_type eq 1}">물보험</c:when>
							<c:when test="${items.team_type eq 4}">인보험</c:when>
						</c:choose>
					</td>
					<td align="center" width="10%">${items.category_name}</td>
					<td width="20%" style="text-align:left;padding-left:5px;" title="${items.subject}">
						<div style="width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						${items.subject}
						</div>
					</td>
					<td width="10%" align="center">${items.manager_name}</td>					
					<td width="10%" style="text-align:left;padding-left:5px;">${items.link_path}</td>
					<td width="8%" align="center">${items.reg_date_fmt}</td>					
					<td width="18%" style="text-align:left;padding-left:5px;" title="${items.file_org_name}">
						<c:choose>
							<c:when test="${empty items.file_org_name}">파일없음</c:when>
							<c:otherwise>								
								<a href="oOpenFileDownload?okey=${items.okey}">
								<c:choose>
									<c:when test="${fn:length(items.file_org_name) > 14}">
										${fn:substring(items.file_org_name,0,14)}...
									</c:when>
									<c:otherwise>${items.file_org_name}</c:otherwise>
								</c:choose>
								</a>&nbsp;
								<img class="btn_file_del" src="./resources/ls_img/btn_del_s.gif" alt="파일삭제" style="cursor:pointer" onclick="doOpenAttachDelete('${items.okey}','${items.file_org_name}')"/>								
							</c:otherwise>
						</c:choose>						
					</td>
					<td width="10%" align="center">						
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doOpenModify('${items.okey}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:doOpenDelete('${items.okey}','${items.subject}');">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>