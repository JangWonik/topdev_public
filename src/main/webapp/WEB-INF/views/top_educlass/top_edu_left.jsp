<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style>
	
	::-webkit-scrollbar {
		display:none;
	} 
	.tableStyle3 td {letter-spacing: 0;}
	</style>
</head>

<body>	
	<!-- left_cnt -->
	<div class="left_cnt">
		<div style="text-align:left;padding:20px 0 0 20px;">		
		<img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
			<b>교육 분류</b>
		</div>
		<c:forEach items="${categoryListForSearch}" var="categoryVo">
		<div class="topinfo">
			<p style="padding-left:40px;font-weight:bold;cursor:pointer;" onclick="javascript:selEcu('${categoryVo.col_cd}');"> ${categoryVo.col_val} 교육</p>
		</div>
		</c:forEach>
	</div>
</body>
</html>
