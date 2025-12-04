<%@ page language="java" contentType="vnd.ms-xls; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat,java.io.UnsupportedEncodingException"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<%
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMdd");
		String filename = "전산권한결재요청처리내역_"+timeForNaming.format(today);//String형으로 변환
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8").replaceAll("\\+", "_");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
%>
<% response.setHeader("Content-Disposition", "attachment;filename="+filename+".xls"); %>							
<table border="1">								
		<tr>
			<th>번호</th>
			<th>상태</th>
			<th>구분</th>
			<th>제목</th>
			<th>권한부여내용</th>											
			<th>요청부서</th>
			<th>요청자</th>
			<th>요청일</th>
			<th>접수자</th>
			<th>접수일</th>
			<th>결재(반려)자</th>
			<th>결재(반려)일</th>
			<th>완료일</th>			
		</tr>									
		<c:forEach items="${boardListAuth}" var="boardList" varStatus="status">
			<tr>
					<!--번호-->
					<td align="center">${boardListAuth.size() - status.index}</td>
					<!--상태-->
					<td align="center">${boardList.solve_state_nm}</td>
					<!--구분-->
					<td align="center">${boardList.accept_classify_nm}</td>
					<!--제목-->
					<td>${boardList.title}</td>
					<!--권한부여내용-->
					<td>${boardList.auth_memo}</td>													
					<!--요청부서-->
					<td>${boardList.team_name}</td>
					<!--요청자-->
					<td align="center">${boardList.user_nm}</td>
					<!--작성일-->
					<td>${boardList.reg_date_fmt}</td>
					<!--접수자-->
					<td align="center">${boardList.drafter_nm}</td>
					<!--접수일-->
					<td>${boardList.accept_date_fmt}</td>
					<!--결재(반려)자-->
					<td align="center">${boardList.approval_nm}</td>
					<!--결재(반려)일-->
					<td>${boardList.approval_date_fmt}</td>
					<!--완료일-->
					<td>${boardList.solve_date_fmt}</td>					
			</tr>
		</c:forEach>									
</table>							