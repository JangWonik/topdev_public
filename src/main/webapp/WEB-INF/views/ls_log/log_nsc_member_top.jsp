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
	    });
	    $("#yearnext").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        $("#yeartxt").text(++imsiyeartxt);
	    });

	    //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
	    $(".monthbtn").click(function(){
	    	var imsimonth = $(this).attr("id");
	    	var imsiMonthStart = imsimonth -1;
	    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
	    	var imsiMonthStartStr = "0"+imsiMonthStart;
	    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
	        	$("#selectorFrom").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
	        	$("#selectorTo").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "15");
	        if(imsimonth == 1){
	        	//alert(($("#yeartxt").text()-1)+"12"+"16");
	        	$("#selectorFrom").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
	        }
		    datef.submit();
	    });//monthbtn.click
	});//$(document).ready
</script>

	<c:set var="fromdate" value="${fromdate}" />
	<c:set var="todate" value="${todate}" />
	<c:set var="toAccumYear" value="${toAccumYear}" />
	<c:set var="toMonthInt" value="${toMonthInt}" />

	<div style="float: left;">
	<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" align="absmiddle">&nbsp;<font color="red">
	<c:set var="str" value="${fromdate}"></c:set>
	<b>${toAccumYear}년 ${toMonthInt}월</b></font> 팀별 평균 통계
	</div>
	<div style="text-align: right;">
	<img id="yearprev" src="./resources/ne_img/icon_prev.gif" align="absmiddle" width="17" height="13" border="0">
	<a id="yeartxt" href="">${toAccumYear}</a>
	<img id="yearnext" src="./resources/ne_img/icon_next.gif" align="absmiddle" width="17" height="13" border="0">

	<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
		<input id="${i}" class="monthbtn" type="button" value="${i}월" />
	</c:forEach>
	</div>
	</br>

	<form name="datef" method="POST" action="./log_nsc_member"> 
	<!-- 달력 From -->
	&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="text" id="selectorFrom" name="viewFromDate" size="10" value="${fromdate}" maxlength="10" />
	<font color="#0066CC">부터&nbsp&nbsp&nbsp</font>
	<!-- 달력 To -->
	<input type="text" id="selectorTo"  name="viewToDate" size="10"  value="${todate}" maxlength="10" /> 
	<font color="#0066CC">까지</font>
	<input type=image src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0" class="btn">
	</form>
	