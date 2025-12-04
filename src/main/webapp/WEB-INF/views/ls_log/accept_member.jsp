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
<c:set var="Accept_MList" value="${Accept_MList}" />
<c:set var="Accept_T4List" value="${Accept_T4List}" />
<c:set var="year" value="${year}" />
<c:set var="month" value="${month}" />
<c:set var="dayListSize" value="${dayListSize}" />
<c:set var="team_name" value="${team_name}" />

				<div class="centercnt_bot2">
					<div class="guest">
						<div>
						<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" align="absmiddle">&nbsp;<font color="red">
						<c:set var="str" value="${fromdate}"></c:set>
						<b>${toAccumYear}년 ${toMonthInt}월</b></font> ${team_name} 개인별 일일 배당현황  &nbsp; <font color="red"><b>(배당건중 반송&취소건은 제외된 건수입니다)</b></font>
						</div>
						<p style="display: inline; float: right;">
						<b><input type=image src="./resources/ls_img/btn_excel.gif" width="60" height="15" border="0" id="btn_excel"></b>
						</p>
						<br>
						<form action="./accept_member_excel" method="POST" id="excelform">
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
			<p align="center"><b>팀</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF" rowspan="2">
			<p align="center"><b>이름</b></p>
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
		<c:forEach var="vo" items="${Accept_MList}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<c:if test="${status.index == 0}">
			<td class="td" bgcolor="#F8F8F8" rowspan="${Accept_MList.size()}">
				<c:out value="${team_name}" />
			</td>
		</c:if>
		<td>
			<a href="./accept_member?team_name=${vo.getTeam_name()}&team_id=${vo.getTeam_id()}&ViewFromDate=${fromdate}&ViewToDate=${todate}">
			<c:out value="${vo.getName()}" />
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
			<c:out value="${accept_sum_M.getSum_rid1()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 29}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid2()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 28}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid3()}"/>
		</td>
		</c:if>
		<c:if test = "${dayListSize > 27}">
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid4()}"/>
		</td>
		</c:if>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid5()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid6()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid7()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid8()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid9()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid10()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid11()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid12()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid13()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid14()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid15()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid16()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid17()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid18()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid19()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid20()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid21()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid22()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid23()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid24()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid25()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid26()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid27()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid28()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid29()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid30()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid31()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid_sum()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid_sum_y()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid_m()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid_y()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${accept_sum_M.getSum_rid_mi()}"/>
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
