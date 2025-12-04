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
		<c:when test="${eduClassListCnt == 0 }">
			<tr>
				<td colspan="6">조회 된 교육자료가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${eduClassList}" var="item" varStatus="var">
				<tr>
					<td width="5%">${eduClassList.size() - var.index}</td>
					<td width="15%">${item.category_name}</td>
					<td width="45%">${item.file_name}</td>
					<td width="10%">${item.teacher_name }</td>
					<td width="10%">${item.reg_date_fmt}</td>
					<td width="15%">
						<input type="button" value="시청하기" class="buttonEduView" onclick="javascript:openEduView('${item.ekey}');">
						<input type="button" value="자료받기" class="buttonEduDown" onclick="javascript:reportDown('${item.ekey}');">
						
					</td>
				</tr>		
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</body>
</html>