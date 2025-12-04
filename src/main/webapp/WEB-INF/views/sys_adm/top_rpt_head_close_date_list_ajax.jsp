<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<table>
<c:choose>						
	<c:when test="${rptList.size() != 0}">						
		<c:forEach items="${rptList}" var="item" varStatus="status">			
			<tr id="rptListView_${item.suim_rpt_no}">														
				<td width="10%">${rptList.size() - status.index}</td>
				<td width="25%">${item.suim_accept_no}</td>
				<td width="25%">${item.ptnr_nick}</td>
				<td width="25%">${item.close_date}</td>
				<td width="15%">
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#CEE3F6;" onclick="javascript:doCloseDateEdit(${item.suim_rpt_no});">수 정</a>
				</td>
			</tr>
			<tr id="rptListEdit_${item.suim_rpt_no}" style="display:none;background-color:#FFECEC;">
				<td width="10%">${rptList.size() - status.index}</td>
				<td width="25%">${item.suim_accept_no}</td>
				<td width="25%">${item.ptnr_nick}</td>
				<td width="25%">
					<input type="text" class="calendar" id="close_date_edit_${item.suim_rpt_no}" name="close_date_edit_${item.suim_rpt_no}" value="${item.close_date}" maxlength="10" style="width:200px;"/>
				</td>
				<td width="15%">
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#CEE3F6;" onclick='javascript:doCloseDateSave(${item.suim_rpt_no});'>저 장</a>
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#F6CED8;" onclick='javascript:doCloseDateCancel(${item.suim_rpt_no});'>취 소</a>
				</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="5">
				검색된 보고서가 없습니다.
			</td>
		</tr>
	</c:otherwise>
</c:choose>
</table>