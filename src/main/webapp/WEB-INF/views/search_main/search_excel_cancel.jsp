<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
</head>

<body>

	<h4>${fileName}</h4>
	<table border="1">
		<thead>
			<tr>
				<th bgcolor="#dceb8a">번호</th>
				<th bgcolor="#dceb8a">접수번호</th>
				<th bgcolor="#dceb8a">수임구분</th>
				<th bgcolor="#dceb8a">위임취소<br style="mso-data-placement: same-cell" />구분</th>
				<th bgcolor="#dceb8a">위임취소<br style="mso-data-placement: same-cell"/>신청자</th>
				<th bgcolor="#dceb8a">위임취소<br style="mso-data-placement: same-cell"/>결재자</th>
				<th bgcolor="#dceb8a" width="500">위임취소 사유</th>
				<th bgcolor="#dceb8a" width="100">수임등록일</th>
				<th bgcolor="#dceb8a" width="100">위임취소<br style="mso-data-placement: same-cell"/>신청일</th>
				<th bgcolor="#dceb8a" width="100">위임취소<br style="mso-data-placement: same-cell"/>결재일</th>
			</tr>
		</thead>
		<tbody>	
			<c:forEach items="${cancelList}" var="cList" varStatus="cStatus">
				<tr>
					<td align="center">${cStatus.count}</td>
					<td align="center">${cList.suimAcceptNo}</td>
					<td align="center">${cList.processGubunVal}</td>
					<td align="center">${cList.cancelGubunVal}</td>
					<td align="center">${cList.userNm}</td>
					<td align="center">${cList.agreeUserNm}</td>
					<td>${cList.cancelReason}</td>
					<td align="center">${cList.suimRegDate}</td>
					<td align="center">${cList.cancelRegDate}</td>
					<td align="center">${cList.cancelAgreeDate}</td>						
				</tr>
			</c:forEach>
		</tbody>
	</table>

</body>

</html>
