<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	        	$("#selectorTo").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "16");
	        if(imsimonth == 1){
	        	//alert(($("#yeartxt").text()-1)+"12"+"16");
	        	$("#selectorFrom").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
	        }
		    datef.submit();
	    });//monthbtn.click
	});//$(document).ready
	
	function chgteam(){
		   //alert(form1.select1.value);
		   formD.selectVal.value=formD.teamF.value;
		}
	
	$(document).ready(function(){
		/***** 엑셀다운로드 *****/
		$("#btn_excel").click(function(){
			//엑셀의 경우 ajax는 사용 불가.. 반드시 submit이나 href로 화면제어를 줘야함
			var data = $("#tab_member").html();
			$("#hidtab").attr('value',data);
			//alert(data);
			$("#excelform").submit();
		});
	});

</script>

	<c:set var="fromdate" value="${fromdate}" />
	<c:set var="todate" value="${todate}" />
	<c:set var="toAccumYear" value="${toAccumYear}" />
	<c:set var="toMonthInt" value="${toMonthInt}" />
	<c:set var="team_id" value="${team_id}" />
	<c:set var="team_name" value="${team_name}" />

	<div style="float: left;">
		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" align="absmiddle">&nbsp;<font color="red">
			<c:set var="str" value="${fromdate}"></c:set>
				<b>${toAccumYear}년 ${toMonthInt}월</b></font>&nbsp;
				${team_name}
				<%-- <b>
				<choose>
					<when test="selectVal == null">
						${team_name}
					</when>
					<otherwise>
						${selectVal}
					</otherwise>
				</choose>
				
				</b> --%>  개인별 통계
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

	<form name="datef" id="formD" method="POST" action="./log_member?team_id=${team_id}&team_name=${team_name}">
	<input type="hidden" id="team_id" value="${team_id}">
	<%-- <input type="text" name="qwe" value="${team_id}"> --%>
		<!-- 달력 From -->
		&nbsp&nbsp&nbsp&nbsp&nbsp
		<input type="text" id="selectorFrom" name="viewFromDate" size="10" value="${fromdate}" maxlength="10" />
		<font color="#0066CC">부터&nbsp&nbsp&nbsp</font>
		<!-- 달력 To -->
		<input type="text" id="selectorTo"  name="viewToDate" size="10"  value="${todate}" maxlength="10" /> 
		<font color="#0066CC">까지</font>
		&nbsp&nbsp&nbsp
		 <%-- <input type="checkbox" name = "baseF"  value = "ok" <c:if test="${baseF eq 'ok' || baseF eq ''}">checked='checked'</c:if>>기본통계</input>
		| 
		<input type="checkbox" name = "nscF"  value = "ok" <c:if test="${nscF eq 'ok'}">checked='checked'</c:if> >농작물</input>		
		
		| <input type="checkbox" name = "contractF" value = "ok" <c:if test="${contractF eq 'ok'}">checked='checked'</c:if> >적부</input>
		| 	 --%>  
		<select name="team_id" id="teamF" onChange="chgteam();">
					<option value = "">-전체팀-</option>
			<c:forEach var="vo" items="${MteamList}" varStatus="status">
					<option value = "${vo.getTeam_id()}" <c:if test="${selectVal == vo.getTeam_id()}"> selected='selected'</c:if>><c:out value="${vo.getTeam_name()}"/></option>		
			</c:forEach>
			  </select>
			  <input type="hidden" name="selectVal" value="${selectVal}">
		 <script language='javascript'>document.datef.team_id.value="${selectVal}";</script>		&nbsp&nbsp
		<input type=image src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0" class="btn">
	</form>
	<p style="display: inline; float: right;">
	<b><input type=image src="./resources/ls_img/btn_excel.gif" width="70" height="17" border="0" id="btn_excel"></b>
	</p>
	<br>
	<form action="./log_member_excel" method="POST" id="excelform">
		<input type="hidden" name="hidtab" id="hidtab" />
	</form>
	