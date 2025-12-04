<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>	
</head>
<body>
<table>
	<c:choose>
		<c:when test="${templateListCnt == 0 }">
			<tr>
				<td colspan="7">조회 된 자료가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${templateList}" var="item" varStatus="var">
				<tr>
					<td width="10%">${item.team_type}종</td>					
					<td width="20%">${item.category_name}</td>
					<td width="40%">
						<a href="#noloc" onclick="fnTemplateDown('${item.tkey}');">
							${item.template_org_file}
						</a>
					</td>
					<td width="10%">${item.reg_date_fmt}</td>
					<td width="10%">${item.user_name}</td>					
					<td width="10%">
						<a href="#noloc" onclick="fnTemplateDelete('${item.tkey}');"><img src='./resources/ls_img/btn_del_s.gif'></a>&nbsp;
						<c:if test="${!empty item.template_org_file}">
							<a href="#noloc" onclick="fnTemplateDown('${item.tkey}');"><img src='./resources/ls_img/icon_disket.gif'></a>
						</c:if>						
					</td>					
				</tr>		
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</body>
</html>