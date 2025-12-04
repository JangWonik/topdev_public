<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=WebLoginLogList.xls"); %>

<%@ page language="java" contentType="vnd.ms-xls; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="application/vnd.ms-xls; charset=UTF-8">
	<meta charset="UTF-8">
</head>

<body>

	<h1>WebLoginLogList.xls</h1>
	<br /><br />
	<!-- 검색 조건 테이블 -->
	<h2>검색 조건 테이블</h2>
			<table border="1">
				<tr>
					<th bgcolor="#e7ecf1">사원 이름</th>
					<td>
						<c:choose>
							<c:when test="${mbrNm == null or mbrNm == ''}">전체</c:when>
							<c:otherwise>${mbrNm}</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
	<!-- //검색 조건 테이블 -->
	<br /><br />
	<!-- 검색 결과 테이블 -->
	<h2>검색 결과 테이블</h2>
			<table border="1">
				<tr>
					<th bgcolor="#e7ecf1">no</th>
					<th bgcolor="#e7ecf1">아이디 No.</th>
					<th bgcolor="#e7ecf1">아이디</th>
					<th bgcolor="#e7ecf1">이름</th>
					<th bgcolor="#e7ecf1">IP</th>
					<th bgcolor="#e7ecf1">접속시간</th>
				</tr>
				<c:forEach items="${getLogInLogListExcel}" var="getLogInLogListExcel">
				<tr>
					<td>${getLogInLogListExcel.getSerial_no()}</td>
					<td>${getLogInLogListExcel.getUser_no()}</td>
					<td>${getLogInLogListExcel.getUser_id()}</td>
					<td>${getLogInLogListExcel.getUser_name()}</td>
					<td>${getLogInLogListExcel.getIp_addr()}</td>
					<td>${getLogInLogListExcel.getReg_date()}</td>
				</tr>
				</c:forEach>
			</table>
	<!-- //검색 결과 테이블 -->

</body>

</html>
