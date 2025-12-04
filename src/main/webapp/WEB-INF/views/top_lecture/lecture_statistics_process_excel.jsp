<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=LectureProcessstatistics.xls"); %>

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
		<th width="5%">No</th>
		<th width="8%">교육구분</th>
		<th width="8%">구분</th>
		<th width="21%">과정명</th>
		<th width="15%">신청기간</th>
		<th width="15%">교육기간</th>
		<th width="7%" title="교육 신청인원 중 결재완료가 된 인원수">신청인원</th>
		<th width="7%" title="교육진도율이 99%미만 인원수">교육중</th>
		<th width="7%" title="교육진도율이 99%이상 인원수">교육완료</th>
		<th width="7%" title="교육신청인원 대비 완료인원 비율">완료율</th>						
	</tr>	
	<c:choose>		
		<c:when test="${processList.size() == 0}">
			<tr>
				<td colspan="9" align="center">검색조회 결과가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${processList}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="process_view_${items.pkey}">
					<td align="center" width="5%">${processList.size() - status.index}</td>
					<td align="center" width="8%">
						<c:choose>
							<c:when test="${items.lecture_type eq 0}">상시교육</c:when>
							<c:otherwise>의무교육</c:otherwise>
						</c:choose>						
					</td>
					<td align="center" width="8%">
						<c:choose>
							<c:when test="${items.team_type eq 1}">물보험본부</c:when>
							<c:when test="${items.team_type eq 4}">인보험본부</c:when>
							<c:otherwise>공통교육</c:otherwise>
						</c:choose>
					</td>					
					<td align="left" width="21%" style="padding-left:5px;">${items.p_title}</td>
					<td align="center" width="15%">${items.apply_sdate_fmt} ~ ${items.apply_edate_fmt}</td>
					<td align="center" width="15%">${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>
					<td align="center" width="7%">${items.apCnt}</td>
					<td align="center" width="7%">${items.ing_cnt}</td>
					<td align="center" width="7%">${items.end_cnt}	</td>
					<td width="7%" style="text-align:right;padding-right:20px;">${items.end_per} %</td>					
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>