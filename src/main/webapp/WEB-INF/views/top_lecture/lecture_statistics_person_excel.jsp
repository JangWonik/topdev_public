<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=LecturePersonstatistics.xls"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>	

<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="application/vnd.ms-xls; charset=UTF-8">	
</head>
<body>
<table border=1>	
	<tr>
		<th width="10%">No</th>
		<th width="17%">센터명</th>
		<th width="17%">부서명</th>
		<th width="16%">이름</th>
		<th width="10%">신청중</th>
		<th width="10%">교육중</th>
		<th width="10%">교육완료</th>
		<th width="10%">완료율</th>						
	</tr>
	<c:choose>		
		<c:when test="${personList.size() == 0}">
			<tr>
				<td colspan="8" align="center">검색조회 결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${personList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="person_view_${items.user_no}">
					<td align="center" width="10%">${status.count}</td>
					<td align="center" width="17%">${items.center_name}</td>
					<td align="center" width="17%">${items.team_name}</td>
					<td align="center" width="16%">${items.user_name}</td>
					<td align="center" width="10%">${items.approval_cnt}</td>
					<td align="center" width="10%">${items.ing_cnt}</td>
					<td align="center" width="10%">${items.end_cnt}</td>
					<td align="center" width="10%" style="text-align:right;padding-right:10px;">${items.end_per} %</td>					
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</body>
</html>