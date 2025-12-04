<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String filename = "입_퇴사확인";
    filename = java.net.URLEncoder.encode(filename,"UTF-8");
    response.setHeader("Content-Disposition", "attachment;filename="+filename+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>입_퇴사확인</title>
</head>
<body>
<div class="guestcnt4" style="display:block;height:750px;">
	<div class="tableStyle2">
		<table border="1">									
			<tr>
				<th width="50px;">순번</th>
				<th width="120px;">센터명</th>
				<th width="120px;">팀명</th>
				<th width="80px;">직위</th>
				<th width="80px;">직책</th>
				<th width="80px;">이름</th>
				<th width="80px;">아이디</th>
				<th width="80px;">주민번호</th>
				<th width="80px;">입사일</th>
				<th width="80px;">퇴사일</th>
				<th width="80px;">현재상태</th>
				<th width="80px;">휴직유무</th>
				<th width="100px;">경조금 갹출 동의</th>					
			</tr>
		</table>
		<div id="subList" style="overflow:auto;width:100%; height:660px;">
			<table border="1">	
				<c:choose>		
					<c:when test="${memberList.size() == 0}">
						<tr>
							<td colspan="10" align="center">검색결과가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="items" items="${memberList}" varStatus="status">
							<c:set var="idx" value="${memberList.size() - status.index}"/>
							<tr id="info_view_${idx}">
								<td width="50px;">${idx}</td>
								<td width="120px;">${items.center_name}</td>
								<td width="120px;">${items.team_name}</td>
								<td width="80px;">${items.work_level_name}</td>
								<td width="80px;">${items.work_type_name}</td>
								<td width="80px;">${items.user_name}</td>
								<td width="80px;">${items.user_id}</td>
								<td width="80px;">${items.jumin_no1}-${items.jumin_no2}</td>
								<td width="80px;">${items.join_date_fmt}</td>
								<td width="80px;">${items.out_date_fmt}</td>
								<td width="80px;">${items.user_state_name}</td>
								<td width="80px;">
									<c:choose>
										<c:when test="${items.leave_cnt > 0}"><font color="green">유 (${items.leave_cnt}회)</font></c:when>
										<c:otherwise>무</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${items.exp_agree eq 1}"><font color="blue">동의</font></c:when>
										<c:when test="${items.exp_agree eq 2}"><font color="red">미동의</font></c:when>
										<c:otherwise>해당없음</c:otherwise>
									</c:choose>
								</td>
							</tr>								
						</c:forEach>			
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>
</div>
</body>