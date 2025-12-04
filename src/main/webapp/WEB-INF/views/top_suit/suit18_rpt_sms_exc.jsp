<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page import = "java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
 
<script src="./resources/jquery/jquery.min_1_12.js"></script>
</head>
<style type="text/css">p,td{font-size:9pt;}</style>
<table border=1>
	<tr align="center" bgcolor="#cccccc">
		<td>증권번호</td>
		<td>계약자전화번호</td>
		<td>보낸내용</td>
		<td>상태</td>
		<td>모집인전화번호</td>
		<td>보낸내용</td>
		<td>보낸시간</td>
		<td>담당자이름</td>
		<td>담당자 전화번호</td>
	</tr>
	<c:forEach items="${suimSuit_18List }" var="suimSuit_18Vo">
		<tr>
			<td style='mso-number-format:\@;'>${suimSuit_18Vo.plcyNo}</td>
			<td style='mso-number-format:\@;'>${suimSuit_18Vo.conHndPhoneNo}</td>
			<td>
				<c:if test="${suimSuit_18Vo.conCnt2 > 0}">
					${suimSuit_18Vo.msg2}
				</c:if>
			</td>
			<td>
				<c:choose>
					<c:when test="${suimSuit_18Vo.conCnt2 >0 }">
						${suimSuit_18Vo.sDate2 }
					</c:when>
					<c:otherwise>
						실패
					</c:otherwise>
				</c:choose>
			</td>
			<td style='mso-number-format:\@;'>${suimSuit_18Vo.clerkHndPhoneNo}</td>
			<td>
				<c:if test="${suimSuit_18Vo.conCnt1 > 0}">
					${suimSuit_18Vo.msg1}
				</c:if>
			</td>
			<td>
				<c:choose>
					<c:when test="${suimSuit_18Vo.conCnt1 >0 }">
						${suimSuit_18Vo.sDate1 }
					</c:when>
					<c:otherwise>
						실패
					</c:otherwise>
				</c:choose>
			</td>
			<td>${suimSuit_18Vo.userName}</td>
			<td>${suimSuit_18Vo.handphone}</td>
		</tr>
	
	</c:forEach>
</table>
</html>