<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>	
	<style>p,td{font-size:10pt;}</style>
</head>
<body>	
<table border="1">
		<tr>
			<th>순번</th>
			<th>부서명</th>
			<th>이름</th>								
		</tr>
		<c:choose>
			<c:when test="${certiSubMemberList.size() == 0}">
				<tr>
					<td colspan="3">담당 손해사정사로 등록된 보조인이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${certiSubMemberList}" var = "subMemberVo" varStatus="status">
					<tr>
						<td>${certiSubMemberList.size() - status.index}</td>
						<td>${subMemberVo.team_name}</td>
						<td>${subMemberVo.user_name}</td>				
					</tr>
				</c:forEach>		
			</c:otherwise>
		</c:choose>			
	</table>
</body>
</html>