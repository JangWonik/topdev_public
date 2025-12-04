<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<table>
<c:choose>						
	<c:when test="${rptList.size() != 0}">						
		<c:forEach items="${rptList}" var="item" varStatus="status">			
			<tr id="rptListView_${item.serial_no}">														
				<td width="10%">${rptList.size() - status.index}</td>
				<td width="10%">${item.suim_accept_no}</td>
				<td width="10%">${item.accept_team_name}</td>
				<td width="10%">${item.accept_name}</td>
				<td width="24%" style="text-align:left;padding-left:10px;" title="${item.help_memo}">
					<c:choose>
						<c:when test="${item.help_memo != ''}">
							<c:choose>
								<c:when test="${fn:length(item.help_memo) > 24}">
									${fn:substring(item.help_memo,0,24)}...
								</c:when>
								<c:otherwise>${item.help_memo}</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
				</td>
				<td width="10%">${item.client_team_name}</td>
				<td width="10%">${item.client_name}</td>
				<td width="15%">
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#CEE3F6;width:70px;" onclick="javascript:doHelpEdit('${item.serial_no}','${item.client_id}');">의뢰인 수정</a>
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#F6CEEC;width:50px;" onclick="javascript:doHelpDel('${item.serial_no}','${item.suim_accept_no}','${item.accept_name}');">삭제</a>
				</td>
			</tr>
			<tr id="rptListEdit_${item.serial_no}" style="display:none;background-color:#FFECEC;">
				<td width="10%">${rptList.size() - status.index}</td>
				<td width="10%">${item.suim_accept_no}</td>
				<td width="10%">${item.accept_team_name}</td>
				<td width="10%">${item.accept_name}</td>
				<td width="24%" style="text-align:left;padding-left:10px;" title="${item.help_memo}">
					<c:choose>
						<c:when test="${item.help_memo != ''}">
							<c:choose>
								<c:when test="${fn:length(item.help_memo) > 24}">
									${fn:substring(item.help_memo,0,24)}...
								</c:when>
								<c:otherwise>${item.help_memo}</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
				</td>
				<td width="20%" colspan="2">
					<select id="editHelpListSel_${item.serial_no}" name="editHelpListSel_${item.serial_no}" style="width:90%;text-align:left;">
						<option value="0">- 선택 -</option>
						<c:forEach items="${userList}" var="member" varStatus="status">
							<option value="${member.userNo}">${member.teamName} / ${member.userName}</option>
						</c:forEach>
					</select>
				</td>
				<td width="15%">
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#CEE3F6;" onclick='javascript:doHelpSave(${item.serial_no});'>저 장</a>
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#F6CED8;" onclick='javascript:doHelpCancel(${item.serial_no});'>취 소</a>
				</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="8">
				검색된 보고서가 없습니다.
			</td>
		</tr>
	</c:otherwise>
</c:choose>
</table>