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
				//window.location.assign("./myCostInsList?cost_class_no="+tmpSelNo);				
			
		    	var imsimonth = $(this).attr("id");
		    	var imsiMonthStart = imsimonth -1;
		    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
		    	var imsiMonthStartStr = "0"+imsiMonthStart;
		    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
		        	$("#selectFrom").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
		        	$("#selectTo").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "16");
		        if(imsimonth == 1){
		        	//alert(($("#yeartxt").text()-1)+"12"+"16");
		        	$("#selectFrom").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
	        }
		    datef.submit();
	    });//monthbtn.click
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
		
		//목록으로 버튼
		$("#listBtn").click(function(){
			location.href="topCostList";
		});
	});
</script>

	<c:set var="fromdate" value="${fromdate}" />
	<c:set var="todate" value="${todate}" />
	<c:set var="toAccumYear" value="${toAccumYear}" />
	<c:set var="toMonthInt" value="${toMonthInt}" />
	<c:set var="toAccumMonth" value="${toAccumMonth}" />
	
	<div style="float: left;">
		<b>${toAccumYear}년 ${toMonth}월 ${team_name} 경비내역</b>
	</div>
	<div style="text-align: right;">
		<input type="button" id="listBtn" value="목록으로" />
		<img id="yearprev" src="./resources/ne_img/icon_prev.gif" align="absmiddle" width="17" height="13" border="0">
		<a id="yeartxt" href="">${toAccumYear}</a>
		<img id="yearnext" src="./resources/ne_img/icon_next.gif" align="absmiddle" width="17" height="13" border="0">
		<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
			<input id="${i}" class="monthbtn" type="button" value="${i}월" />
		</c:forEach>
	</div>

	<form name="datef" method="GET" action="./topCostTeam"> 
	<!-- 달력 From -->
	<input type="hidden" id="selectFrom" name="viewFromDate" size="10" value="${fromdate}" maxlength="10" />
	<!-- 달력 To -->
	<input type="hidden" id="selectTo" name="viewToDate" size="10"  value="${todate}" maxlength="10" />
	<input type="hidden" id="team_id" name="team_id" size="10"  value="${team_id}" maxlength="10" />
	<input type="hidden" id="team_name" name="team_name" size="10"  value="${team_name}" maxlength="10" />
	</form>
	