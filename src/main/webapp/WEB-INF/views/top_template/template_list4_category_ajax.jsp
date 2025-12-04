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
		<c:when test="${templateCategoryList.size() == 0 }">
			<tr>
				<td colspan="7">조회 된 자료가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${templateCategoryList}" var="item" varStatus="var">
				<tr>
					<td width="10%">${item.col_cd}</td>					
					<td width="75%">${item.col_val}</td>
					<td width="15%">						
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:fnCategoryModify('${item.col_cd}','${item.col_val}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:fnCategoryDel('${item.col_cd}');">삭제</a>
					</td>
				</tr>							
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</body>
</html>