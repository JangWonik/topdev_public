<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>	
</head>
<body>
<div class="tableStyle2" style="border-top:0px;">
	<table>							
		<c:choose>
			<c:when test="${userDupList.size() == 0}">
				<tr>
					<td colspan="5" align="center">조회 결과가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${userDupList}" var="item" varStatus="status">
				<tr>
					<td width="10%">${userDupList.size() - status.index}</td>
					<td width="20%">${item.team_name}</td>
					<td width="15%">${item.user_name}</td>
					<td width="12%">${item.ip_addr}</td>
					<td width="12%">${item.reg_date_fmt}</td>
					<td width="12%">
						<c:choose>
							<c:when test="${item.login_state eq 1}"><font color="blue">로그인</font></c:when>
							<c:when test="${item.login_state eq 2}"><font color="red">로그아웃</font></c:when>
							<c:otherwise>기본상태</c:otherwise>
						</c:choose>						
					</td>
					<td>
						<input class="buttonMini" onclick="javascript:doDupUpdate('${item.user_no}','U')" type="button" value="로그아웃" style="background-color:#F5DA81;">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input class="buttonMini" onclick="javascript:doDupUpdate('${item.user_no}','D')" type="button" value="정보삭제" >						
					</td>
				</tr>
				</c:forEach>	
			</c:otherwise>
		</c:choose>		
	</table>
</div>
</body>
</html>