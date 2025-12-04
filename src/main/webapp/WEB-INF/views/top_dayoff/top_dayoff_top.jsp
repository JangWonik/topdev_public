<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 
*********************************************************
* Program ID           : // 영문 프로그램 이름 (파일 이름 가능)

* Program Name       : // 국문 프로그램 이름 (파일 이름 가능)
* Description           : // 간략한 설명
* Author                  : // 개발자 이름
* Date                     : // 최초 작성일
*********************************************************
 -->
 
<script>
	$(document).ready(function(){
	    $("#yearprev").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        $("#yeartxt").text(--imsiyeartxt);
	        $("#toServerYear").val(imsiyeartxt);
	        datef.submit();
	    });
	    $("#yearnext").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        $("#yeartxt").text(++imsiyeartxt);
	        $("#toServerYear").val(imsiyeartxt);
		    datef.submit();
	    });
	    
	});//$(document).ready
	
	$(document).ready(function(){
		/***** 엑셀다운로드 *****/
		$("#btn_excel").click(function(){
			//엑셀의 경우 ajax는 사용 불가.. 반드시 submit이나 href로 화면제어를 줘야함
			var data = $("#tab_log_ig").html();
			$("#hidtab").attr('value',data);
			//alert(data);
			$("#excelform").submit();
		});
	});
</script>

	<c:set var="fromdate" value="${fromdate}" />
	<c:set var="todate" value="${todate}" />
	<c:set var="yearInt" value="${yearInt}" />
	<c:set var="toMonthInt" value="${toMonthInt}" />

	<div style="text-align: right;">
		<img id="yearprev" src="./resources/ne_img/icon_prev.gif" align="absmiddle" width="17" height="13" border="0">
		<a id="yeartxt" href="">${toServerYear}</a>
		<img id="yearnext" src="./resources/ne_img/icon_next.gif" align="absmiddle" width="17" height="13" border="0">
	</div>

	<form name="datef" method="GET" action="./topDayoffList"> 
		<input type="hidden" id="toServerYear" name="toServerYear" />
	</form>
	