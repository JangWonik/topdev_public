<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${title_Session}</title>    
<div id="equipment-action-dialog" title="장비 체크 내역" style="font-size: 15px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 750px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="30%">설명</th>
				<td width="70%">소속부서가 없거나 팀 그룹(센터)에 배정 된 장비 목록</td>				
			</tr>
		</table>
		<br/>	
		<table>	
			<tr>
				<th width="10%">순번</th>
				<th width="20%">센터명</th>
				<th width="20%">부서명</th>				
				<th width="15%">이름</th>
				<th width="10%">장비종류</th>
				<th width="10%">장비상태</th>
				<th width="15%">일련번호</th>
			</tr>
			<c:choose>
				<c:when test="${trubleEqList.size() eq 0}">
					<tr>
						<td colspan="7">문제되는 장비가 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${trubleEqList}" var = "eqVo" varStatus="eqStatus">
						<tr>
							<td>${trubleEqList.size() - eqStatus.index}</td>
							<td>${eqVo.center_name}</td>
							<td>${eqVo.team_name}</td>
							<td>${eqVo.user_name}</td>
							<td>${eqVo.eq_type_nm}</td>
							<td>${eqVo.eq_state_nm}</td>
							<td style="letter-spacing:0px;">${eqVo.eq_no}</td>
						</tr>				
					</c:forEach>
				</c:otherwise>
			</c:choose>			
		</table>		
	</div>			
</div>