<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
$(document).ready(function(){
	/***** 엑셀다운로드 *****/
	$("#btn_excel").click(function(){
		//엑셀의 경우 ajax는 사용 불가.. 반드시 submit이나 href로 화면제어를 줘야함
		var data = $("#reg_tab").html();
		$("#hidtab").attr('value',data);
		//alert(data);
		$("#excelform").submit();
	});
});
</script>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="kind1regmonthList" value="${kind1regmonthList}" />
<c:set var="ig1List" value="${ig1List}" />
<c:set var="Accept_T1List" value="${Accept_T1List}" />
<c:set var="Accept_T4List" value="${Accept_T4List}" />
<c:set var="year" value="${year}" />
<c:set var="month" value="${month}" />
<c:set var="dayListSize" value="${dayListSize}" />

				<div class="centercnt_bot2">
					<div class="guest">
						<div>
						<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" align="absmiddle">&nbsp;<font color="red">
						<c:set var="str" value="${fromdate}"></c:set>
						<b>${toAccumYear}년 ${toMonthInt}월</b></font> 팀별 일일 배당현황  &nbsp; <font color="red"><b>(배당건중 반송&취소건은 제외된 건수입니다)</b></font>
						</div>
						<p style="display: inline; float: right;">
						<b><input type=image src="./resources/ls_img/btn_excel.gif" width="60" height="15" border="0" id="btn_excel"></b>
						</p>
						<br>
						<form action="./accept_team_excel" method="POST" id="excelform">
							<input type="hidden" name="hidtab" id="hidtab" />
						</form>
						<div class="guestcnt2" id="reg_tab" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" width="990" align="center">
								<colgroup>
										<col width="50">
										<col width="120">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
										<col width="40">
									</colgroup>
									<thead>
	<tr>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>Type</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>팀</b></p>
		</td>
		
		
		<c:set var="dateInt" value="${dateInt}" />
		<%-- <c:if test="${toMonthInt}" eq 0> --%>
		<c:forEach var ="i" begin="${dateInt+1}" end="${dateInt+(dayListSize)}" step="1" varStatus="status">
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<c:choose>
				<c:when test="${i > dayListSize}">
					<p id="${i}" align="center">${i-dayListSize}</p>
				</c:when>
				<c:otherwise>
					<p id="${i}" align="center">${i}</p>
				</c:otherwise>
			</c:choose>
		</td>
		</c:forEach>

		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>합계</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>연간수임누계</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<p align="center"><b>종결</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>미결</b></p>
		</td>
	</tr>
	<tr>
		<td class="td" bgcolor="#EFEFEF">
			당월
		</td>
		<td class="td" bgcolor="#EFEFEF">
			연간
		</td>
	</tr>
	</thead>
	<tbody>
		<c:forEach var="vo" items="${Accept_T1List}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<c:if test="${status.index == 0}">
			<td class="td" bgcolor="#F8F8F8" rowspan="${Accept_T1List.size()}">
				<c:out value="1종" />
			</td>
		</c:if>
		<td>
			<a href="./accept_member?team_name=${vo.getTeam_name()}&team_id=${vo.getTeam_id()}&ViewFromDate=${fromdate}&ViewToDate=${todate}">
			<c:out value="${vo.getTeam_name()}" />
		</td>
		<c:if test = "${dayListSize > 30}">
		<td>
			<c:out value="${vo.getRid1()}" />
		</td>
		</c:if>
		<c:if test = "${dayListSize > 29}">
		<td>
			<c:out value="${vo.getRid2()}" />
		</td>
		</c:if>
		<c:if test = "${dayListSize > 28}">
		<td>
			<c:out value="${vo.getRid3()}" />
		</td>
		</c:if>
		<c:if test = "${dayListSize > 27}">
		<td>
			<c:out value="${vo.getRid4()}" />
		</td>
		</c:if>
		<td>
			<c:out value="${vo.getRid5()}" />
		</td>
		<td>
			<c:out value="${vo.getRid6()}" />
		</td>
		<td>
			<c:out value="${vo.getRid7()}" />
		</td>
		<td>
			<c:out value="${vo.getRid8()}" />
		</td>
		<td>
			<c:out value="${vo.getRid9()}" />
		</td>
		<td>
			<c:out value="${vo.getRid10()}" />
		</td>
		<td>
			<c:out value="${vo.getRid11()}" />
		</td>
		<td>
			<c:out value="${vo.getRid12()}" />
		</td>
		<td>
			<c:out value="${vo.getRid13()}" />
		</td>
		<td>
			<c:out value="${vo.getRid14()}" />
		</td>
		<td>
			<c:out value="${vo.getRid15()}" />
		</td>
		<td>
			<c:out value="${vo.getRid16()}" />
		</td>
		<td>
			<c:out value="${vo.getRid17()}" />
		</td>
		<td>
			<c:out value="${vo.getRid18()}" />
		</td>
		<td>
			<c:out value="${vo.getRid19()}" />
		</td>
		<td>
			<c:out value="${vo.getRid20()}" />
		</td>
		<td>
			<c:out value="${vo.getRid21()}" />
		</td>
		<td>
			<c:out value="${vo.getRid22()}" />
		</td>
		<td>
			<c:out value="${vo.getRid23()}" />
		</td>
		<td>
			<c:out value="${vo.getRid24()}" />
		</td>
		<td>
			<c:out value="${vo.getRid25()}" />
		</td>
		<td>
			<c:out value="${vo.getRid26()}" />
		</td>
		<td>
			<c:out value="${vo.getRid27()}" />
		</td>
		<td>
			<c:out value="${vo.getRid28()}" />
		</td>
		<td>
			<c:out value="${vo.getRid29()}" />
		</td>
		<td>
			<c:out value="${vo.getRid30()}" />
		</td>
		<td>
			<c:out value="${vo.getRid31()}" />
		</td>
		<td>
			<c:out value="${vo.getRid_sum()}" />
		</td>
		<td>
			<c:out value="${vo.getRid_sum_y()}" />
		</td>
		<td>
			<c:out value="${vo.getRid_m()}" />
		</td>
		<td>
			<c:out value="${vo.getRid_y()}" />
		</td>
		<td>
			<c:out value="${vo.getRid_mi()}" />
		</td>
	</tr>
		</c:forEach>
	</tbody>
	<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<b>소계</b>
		</td>
		<c:if test = "${dayListSize > 30}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid1()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 29}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid2()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 28}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid3()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 27}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid4()}"/>
		</td>
		</c:if>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid5()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid6()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid7()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid8()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid9()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid10()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid11()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid12()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid13()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid14()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid15()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid16()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid17()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid18()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid19()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid20()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid21()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid22()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid23()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid24()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid25()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid26()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid27()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid28()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid29()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid30()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid31()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid_sum()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid_sum_y()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid_m()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid_y()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum1.getSum_rid_mi()}"/>
		</td>
		
	</tr>
	<tr>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>Type</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>팀</b></p>
		</td>
		
		
		<c:set var="dateInt" value="${dateInt}" />
		<%-- <c:if test="${toMonthInt}" eq 0> --%>
		<c:forEach var ="i" begin="${dateInt+1}" end="${dateInt+(dayListSize)}" step="1" varStatus="status">
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<c:choose>
				<c:when test="${i > dayListSize}">
					<p id="${i}" align="center">${i-dayListSize}</p>
				</c:when>
				<c:otherwise>
					<p id="${i}" align="center">${i}</p>
				</c:otherwise>
			</c:choose>
		</td>
		</c:forEach>

		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>합계</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>연간수임누계</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<p align="center"><b>종결</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>미결</b></p>
		</td>
	</tr>
	<tr>
		<td class="td" bgcolor="#EFEFEF">
			당월
		</td>
		<td class="td" bgcolor="#EFEFEF">
			연간
		</td>
	</tr>
	<tbody>
		<c:forEach var="vot" items="${Accept_T4List}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<c:if test="${status.index == 0}">
			<td class="td" bgcolor="#F8F8F8" rowspan="${Accept_T4List.size()}">
				<c:out value="4종" />
			</td>
		</c:if>
		<td>
			<c:out value="${vot.getTeam_name()}" />
		</td>
		<c:if test = "${dayListSize > 30}">
		<td>
			<c:out value="${vot.getRid1()}" />
		</td>
		</c:if>
		<c:if test = "${dayListSize > 29}">
		<td>
			<c:out value="${vot.getRid2()}" />
		</td>
		</c:if>
		<c:if test = "${dayListSize > 28}">
		<td>
			<c:out value="${vot.getRid3()}" />
		</td>
		</c:if>
		<c:if test = "${dayListSize > 27}">
		<td>
			<c:out value="${vot.getRid4()}" />
		</td>
		</c:if>
		<td>
			<c:out value="${vot.getRid5()}" />
		</td>
		<td>
			<c:out value="${vot.getRid6()}" />
		</td>
		<td>
			<c:out value="${vot.getRid7()}" />
		</td>
		<td>
			<c:out value="${vot.getRid8()}" />
		</td>
		<td>
			<c:out value="${vot.getRid9()}" />
		</td>
		<td>
			<c:out value="${vot.getRid10()}" />
		</td>
		<td>
			<c:out value="${vot.getRid11()}" />
		</td>
		<td>
			<c:out value="${vot.getRid12()}" />
		</td>
		<td>
			<c:out value="${vot.getRid13()}" />
		</td>
		<td>
			<c:out value="${vot.getRid14()}" />
		</td>
		<td>
			<c:out value="${vot.getRid15()}" />
		</td>
		<td>
			<c:out value="${vot.getRid16()}" />
		</td>
		<td>
			<c:out value="${vot.getRid17()}" />
		</td>
		<td>
			<c:out value="${vot.getRid18()}" />
		</td>
		<td>
			<c:out value="${vot.getRid19()}" />
		</td>
		<td>
			<c:out value="${vot.getRid20()}" />
		</td>
		<td>
			<c:out value="${vot.getRid21()}" />
		</td>
		<td>
			<c:out value="${vot.getRid22()}" />
		</td>
		<td>
			<c:out value="${vot.getRid23()}" />
		</td>
		<td>
			<c:out value="${vot.getRid24()}" />
		</td>
		<td>
			<c:out value="${vot.getRid25()}" />
		</td>
		<td>
			<c:out value="${vot.getRid26()}" />
		</td>
		<td>
			<c:out value="${vot.getRid27()}" />
		</td>
		<td>
			<c:out value="${vot.getRid28()}" />
		</td>
		<td>
			<c:out value="${vot.getRid29()}" />
		</td>
		<td>
			<c:out value="${vot.getRid30()}" />
		</td>
		<td>
			<c:out value="${vot.getRid31()}" />
		</td>
		<td>
			<c:out value="${vot.getRid_sum()}" />
		</td>
		<td>
			<c:out value="${vot.getRid_sum_y()}" />
		</td>
		<td>
			<c:out value="${vot.getRid_m()}" />
		</td>
		<td>
			<c:out value="${vot.getRid_y()}" />
		</td>
		<td>
			<c:out value="${vot.getRid_mi()}" />
		</td>
	</tr>
		</c:forEach>
	</tbody>
	<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<b>소계</b>
		</td>
		<c:if test = "${dayListSize > 30}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid1()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 29}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid2()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 28}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid3()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 27}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid4()}"/>
		</td>
		</c:if>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid5()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid6()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid7()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid8()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid9()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid10()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid11()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid12()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid13()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid14()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid15()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid16()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid17()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid18()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid19()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid20()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid21()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid22()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid23()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid24()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid25()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid26()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid27()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid28()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid29()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid30()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid31()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid_sum()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid_sum_y()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid_m()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid_y()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum4.getSum_rid_mi()}"/>
		</td>
		
	</tr>
	<tbody>
	<tr>
		<td class="td" bgcolor="#F8F8F8" colspan="2">
			<p align="center"><b>합계</b></p>
		</td class="td" bgcolor="#F8F8F8">
		<c:if test = "${dayListSize > 30}">
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid1()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 29}">
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid2()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 28}">
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid3()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 27}">
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid4()}"/>
		</td>
		</c:if>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid5()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid6()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid7()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid8()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid9()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid10()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid11()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid12()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid13()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid14()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid15()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid16()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid17()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid18()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid19()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid20()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid21()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid22()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid23()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid24()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid25()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid26()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid27()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid28()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid29()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid30()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid31()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid_sum()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid_sum_y()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid_m()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid_y()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${accept_sum14.getSum_rid_mi()}"/>
		</td>	
	</tr>
		
		
		</table>
							</div>
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
					</div>
				</div>
