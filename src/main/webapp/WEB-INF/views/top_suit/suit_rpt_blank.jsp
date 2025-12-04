<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>탑손해사정(주)</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
	
			$("#backBtn").click(function(){
				history.back(-1);
			});
			
		}); //document.ready()
		
	</script>
</head>

<body>
   	<div style="margin:300px 450px;" align="center">
   		<p>
   			<c:choose>
   				<c:when test="${resultStr eq ''}"><font color="red">정보 없음 </font></c:when>
   				<c:otherwise>${resultStr}</c:otherwise>
   			</c:choose>
   		</p>
   		<br />
		<img src="./resources/ls_img/btn_close.gif"  id = "backBtn" style="cursor:pointer;"/>	
   	</div>
</body>