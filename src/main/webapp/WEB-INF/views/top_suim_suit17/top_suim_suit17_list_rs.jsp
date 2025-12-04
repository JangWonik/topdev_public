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
		String filename = "흥국화재_적부_결과_"+timeForNaming.format(today);//String형으로 변환
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8").replaceAll("\\+", "_");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
%>
<% response.setHeader("Content-Disposition", "attachment;filename="+filename+".xls"); %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="application/vnd.ms-xls; charset=UTF-8">
	<meta charset="UTF-8">
</head>

<body>

	
	<br /><br />
	<!-- 검색 조건 테이블 -->
	
			<table border="1">
				<thead>
					<tr>
						<th>설계번호</th>
						<th>물건구분명</th>
						<th>실사일자</th>
						<th>실사자명</th>
						<th>실사자휴대전화번호</th>
						<th>책임자명</th>
						<th>건물급수확인사항</th>
						<th>건물급수일치여부</th>
						<th>가입업종확인사항</th>
						<th>가입업종일치여부</th>
						<th>요율업종확인사항</th>
						<th>요율업종일치여부</th>
						<th>소재지우편번호</th>
						<th>소재지주소</th>
						<th>소재지기타주소</th>
						<th>소재지일치여부</th>
						<th>소유자확인사항</th>
						<th>소유자일치여부</th>
						<th>중점요청사항</th>
						<th>중점요청사항일치여부</th>
						<th>구조건물구조조사의견</th>
						<th>구조방화구획조사의견</th>
						<th>구조확인의견</th>
						<th>업종일반층별업종조사의견</th>
						<th>업종일반확인의견</th>
						<th>업종공장공정조사의견</th>
						<th>업종공장생산품조사의견</th>
						<th>업종공장확인의견</th>
						<th>소재지확인의견</th>
					</tr>
				</thead>
				<tbody>
					<!--  -->
					<c:forEach items="${getSuimSuit17ListRs}" var="suit17VO" > <!-- begin="1" end="20" step="1" -->
					<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
					style ="cursor:pointer;">
						<td>${suit17VO.getInfoA()}</td>
						<td>${suit17VO.getInfoM()}</td>
						<td>${suit17VO.getReC()}</td>
						<td>${suit17VO.getUserName()}</td>
						<td>${suit17VO.getHandphone()}</td>
						<td>${suit17VO.getReF()}</td>
						<td>${suit17VO.getReG()}</td>
						<td>${suit17VO.getReH()}</td>
						<td>${suit17VO.getReI()}</td>
						<td>${suit17VO.getReJ()}</td>
						<td>${suit17VO.getReK()}</td>
						<td>${suit17VO.getReL()}</td>
						<td>${suit17VO.getInfoAa()}</td>
						<td>${suit17VO.getInfoAb()}</td>
						<td>${suit17VO.getInfoAc()}</td>
						<td>${suit17VO.getReU()}</td>
						<td>${suit17VO.getReQ()}</td>
						<td>${suit17VO.getReR()}</td>
						<td>${suit17VO.getInfoAe()}</td>
						<td>${suit17VO.getReT()}</td>
						<td>${suit17VO.getReU()}</td>
						<td>${suit17VO.getReV()}</td>
						<td>${suit17VO.getReW()}</td>
						<td>${suit17VO.getReX()}</td>
						<td>${suit17VO.getReY()}</td>
						<td>${suit17VO.getReZ()}</td>
						<td>${suit17VO.getReAa()}</td>
						<td>${suit17VO.getReAb()}</td>
						<td>${suit17VO.getReAc()}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>

</body>

</html>
