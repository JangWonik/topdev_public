<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("CR", "\r"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<div class="tableStyle2" style="width: 750px;">
	<table class="vacation-ins-table">
		<tr>
			<th width="15%" height="25px">계약서 종류</th>
			<td width="35%">${contractMap.c_type_val}</td>
			<th width="15%">계약명</th>
			<td width="35%">${contractMap.t_subject}</td>						
		</tr>
		<tr>
			<th width="15%" height="25px">본부구분</th>
			<td width="35%">
				<c:choose>
					<c:when test="${contractMap.team_type eq 1}">1종</c:when>
					<c:when test="${contractMap.team_type eq 4}">4종</c:when>
					<c:otherwise>공통</c:otherwise>
				</c:choose>				
			</td>
			<th>지점구분</th>
			<td width="35%">${contractMap.c_area_val}</td>						
		</tr>
		<tr>
			<th width="15%" height="25px">계약자명</th>
			<td width="35%">${contractMap.t_username}</td>
			<th>계약체결일</th>
			<td width="35%">${contractMap.sign_date_fmt}</td>						
		</tr>
		<tr>
			<th width="15%" height="25px">계약시기</th>
			<td width="35%">${contractMap.con_sdate_fmt}</td>
			<th>계약종기</th>
			<td width="35%">${contractMap.con_edate_fmt}</td>						
		</tr>
		<tr>
			<th width="15%" height="35px">파일첨부</th>
			<td colspan="3" style="text-align:left;padding-left:10px;">
				<c:choose>
					<c:when test="${contractFileList.size() == 0 }">첨부된 파일이 없습니다.</c:when>
					<c:otherwise>
						<c:forEach var="items" items="${contractFileList}" varStatus="status">
							<div style="padding-top:5px;">
								<a href="#" onclick="javascript:fnFileDown('${items.fkey}')">
									${items.file_org_name} &nbsp;<img src="./resources/ls_img/icon_disket.gif" title="파일다운로드">
								</a>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>								
			</td>
		</tr>					
		<tr>
			<th width="15%" height="100">비고</th>
			<td colspan="3" align="left" style="text-align:left;padding-left:10px;">				
				${fn:replace(fn:replace(contractMap.t_content , LF , '<br>'), ' ', '&nbsp;')}
			</td>
		</tr>
	</table>				
</div>