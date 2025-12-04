<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
// 	    	$("#tid").val();
// 	    	$("#pid").val();
// 	    	$("#selectorFrom").val;
// 	    	$("#selectorTo").val;
// 	    	var imsimonth = $(this).attr("id");
// 	    	var imsiMonthStart = imsimonth -1;
// 	    	var imsiMonthStartStr = "0"+imsiMonthStart;
// 	    	if(imsimonth.length < 2) {
// 	    		imsimonth = "0"+imsimonth;
// 	    	}
	    	/* if(imsiMonthStartStr.length > 2) {
	    		imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
	        	$("#selectorFrom").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
	        	$("#selectorTo").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "15");
	    	}
	        if(imsimonth == 1){
	        	$("#selectorFrom").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
	        	$("#selectorTo").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "15");
	        } */
 		    datef.submit();
	        
	    });//monthbtn.click
	});//$(document).ready
	
	
	function chgtype(){
		   //alert(form1.select1.value);
		   formF.typeF.value=formF.typeFsel.value;
		}
	
	$(document).ready(function(){
		/***** 엑셀다운로드 *****/
		$("#btn_excel").click(function(){
			//엑셀의 경우 ajax는 사용 불가.. 반드시 submit이나 href로 화면제어를 줘야함
			var data = $("#tab").html();
			$("#hidtab").attr('value',data);
			//alert(data);
			$("#excelform").submit();
		});
	});
	
	
	
	
</script>
<body>
	<c:set var="fromdate" value="${fromdate}" />
	<c:set var="todate" value="${todate}" />
	<c:set var="toAccumYear" value="${toAccumYear}" />
	<c:set var="toMonthInt" value="${toMonthInt}" />
	<c:set var="typeF" value="${typeF}"/>

	<div style="float: left;">
		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" align="absmiddle">&nbsp;<font color="red">
		<c:set var="str" value="${fromdate}"></c:set>
		<b>${toAccumYear}년 ${toMonthInt}월</b></font> 팀별 평균 통계
	</div>
	<%-- <div style="text-align: right;">
	<img id="yearprev" src="./resources/ne_img/icon_prev.gif" align="absmiddle" width="17" height="13" border="0">
		<a id="yeartxt" href="">${toAccumYear}</a>
		<img id="yearnext" src="./resources/ne_img/icon_next.gif" align="absmiddle" width="17" height="13" border="0">
	
		<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
			<input id="${i}" class="monthbtn" type="button" value="${i}월" />
		</c:forEach>
	</div> --%>
	<br>
	<br>
	<form name="datef" method="POST" action="./search_state">
	<div class="tableStyle3">
		<table>
			<!-- 달력 From -->
			<tr>
			<td>통계범위</td>
				<td>
					<input type="text" id="selectorFrom" name="viewFromDate" size="10" value="${fromdate}" maxlength="10" />
					<font color="#0066CC">부터&nbsp&nbsp&nbsp</font>
					<!-- 달력 To -->
					<input type="text" id="selectorTo"  name="viewToDate" size="10" value="${todate}"  maxlength="10" /> 
					<font color="#0066CC">까지</font>
				</td>
			</tr>
			<tr>
				<td>조사팀</td>
				<td>
					<select id="tid" name="tid">
						<option value="0" selected>전체 팀</option>
						<c:forEach items="${teamList}" var = "teamVo">
						<option value="${teamVo.team_id}" <c:if test="${teamVo.team_id == tid}">selected</c:if>>
							<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
							<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
							${teamVo.team_name}
						</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>보험사</td>
				<td>
					<select id="pid" name="pid">
						<option value="0" selected>보험사 미지정</option>
							<c:forEach items="${ptnrList}" var = "ptnrVo">
								<option value="${ptnrVo.ptnr_id}" <c:if test="${ptnrVo.ptnr_id == pid}">selected</c:if>>
								<c:if test="${ptnrVo.ptnr_level eq 1}">&nbsp;&nbsp;└</c:if>
								${ptnrVo.ptnr_nick}
								</option>
							</c:forEach>
					</select>
				</td>
			</tr>
		</table>
	</div>
	</form>
	<input type=image src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0" class="monthbtn">
</body>
</html>