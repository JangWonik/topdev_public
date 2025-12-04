<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<table>
<c:choose>						
	<c:when test="${authMemberList.size() != 0}">						
		<c:forEach items="${authMemberList}" var="item" varStatus="status">			
			<tr id="rptListView_${item.suim_rpt_no}">														
				<td width="10%">${authMemberList.size() - status.index}</td>
				<td width="20%">${item.team_name}</td>
				<td width="25%">${item.user_name}</td>
				<td width="15%">
					<c:choose>
						<c:when test="${item.user_state eq 1}"><font color="red">퇴사</font></c:when>
						<c:when test="${item.user_state eq 2}"><font color="green">대기</font></c:when>
						<c:otherwise><font color="blue">재직중</font></c:otherwise>
					</c:choose>					
				</td>
				<td width="20%">${item.reg_date_fmt}</td>
				<td width="10%">
					<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#F6CEEC;" onclick="javascript:doDelUserInfo('${item.user_no}','${item.user_name}');">삭 제</a>
				</td>
			</tr>			
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="6">
				검색된 대상자가 없습니다.
			</td>
		</tr>
	</c:otherwise>
</c:choose>
</table>