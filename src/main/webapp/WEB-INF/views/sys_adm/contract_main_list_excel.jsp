<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=top_contract_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<table border="1">	
	<tr>
		<th width="5%">No</th>
		<th width="10%">계약서 종류</th>
		<th width="15%">계약명</th>
		<th width="10%">계약자명</th>
		<th width="7%">계약시기</th>
		<th width="7%">계약종기</th>			
		<th width="8%">지점구분</th>
		<th width="7%">등록일</th>
		<th width="8%">등록자</th>
		<th width="15%">비고</th>
		<th width="10%">첨부파일수</th>		
	</tr>
	<c:choose>		
		<c:when test="${contractListExcel.size() == 0}">
			<tr>
				<td colspan="11" align="center">조회 대상건이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${contractListExcel}" varStatus="status">
				<!-- 보기목록 -->
				<tr>
					<td align="center" width="5%">${contractListExcel.size() - status.index}</td>
					<td align="center" width="10%">${items.c_type_val}</td>					
					<td width="15%">${items.t_subject}</td>
					<td width="10%">${items.t_username}</td>
					<td align="center" width="7%">${items.con_sdate_fmt}</td>
					<td align="center" width="7%">${items.con_edate_fmt}</td>			
					<td align="center" width="8%">${items.c_area_val}</td>
					<td align="center" width="7%">${items.reg_date_fmt}</td>
					<td align="center" width="8%">${items.user_name}</td>
					<td width="15%">${items.t_content}</td>
					<td width="10%" align="left">	${items.file_cnt}	</td>										
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</body>
</html>