<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%    
    response.setHeader("Content-Disposition", "attachment; filename=2020_vacation_cal.xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>${title_Session}</title>
</head>
<body>
<!-- wrapper -->
<table cellpadding="0" cellspacing="0" width="1060" border="1">
		<tr>
			<td style="text-align:left;padding-left:15px;" colspan="13" bgcolor="#FFFFFF">
				연차 유급 휴가 사용내역 (기준일자 : 2019. 11. 01)을 아래와 같이 안내합니다.
			</td>			
		</tr>
		
		<tr>
			<th rowspan="2">사번</th>
			<th rowspan="2">이름</th>
			<th rowspan="2">입사일자</th>
			<!-- <th colspan="4">2019년 (2019년 01월 01일 ~ 2019년 12월 31일)</th> -->
			<th colspan="4">2018년 (2018년 입사일 ~ 2019년 입사전일)</th>
			<th colspan="6">2019년 (2019년 입사일 ~ 2020년 입사전일)</th>
		</tr>
		
		<tr>																				
			<!-- <th>2019년 1월1일 이후<br/>발생연차</th>
			<th>공휴일<br/>대체사용연차</th>
			<th>휴가신청<br/>사용연차</th>
			<th>2019년<br/>잔여연차</th> -->
			
			<th>2018년<br/>발생연차</th>
			<th>2018년<br/>대체사용연차</th>
			<th>휴가신청<br/>사용연차</th>
			<th>2018년<br/>잔여연차</th>
			
			<th>2019년<br/>이월연차</th>
			<th>2019년 입사일<br/>발생연차</th>
			<th>사용가능<br/>연차 유급휴가</th>
			<th>공휴일 대체<br/>사용연차</th>
			<th>휴가신청<br/>사용연차</th>
			<th>2019년 입사일 이후<br/>잔여연차</th>
		</tr>
	</table>								

	<table cellpadding="0" cellspacing="0" width="1060" border="1">													
		<c:forEach items="${userInfoList}" var="item" varStatus="status">																				
			<tr>
				<td>${item.user_no}</td>
				<td>${item.user_name}</td>
				<td>${item.join_date}</td>										
				<td>${item.n2018Yearset}</td>
				<td>${item.n2018Holiday}</td>
				<td>${item.n2018_vacation_work_use}</td>
				<td>${item.n2018Extraset}</td>
				<td>${item.n2018Overset}</td>
				<td>${item.nYearset}</td>
				<td>${item.nTotalYearset}</td>
				<td>${item.nHoliday}</td>
				<td>${item.n2019_vacation_work_use}</td>
				<td>${item.n2019Extraset}</td>																			
			</tr>									
		</c:forEach>								
	</table>				
</body>
</html>
