<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="kind1endList" value="${kind1endList}" />
<c:set var="end1List" value="${end1List}" />
<c:set var="kind4regList" value="${kind4regList}" />

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="end_team_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
									<li class="on"><a>${toMonthInt}월 팀별 종결현황</a></li>
							</ul>
						</div>
						<div class="guestcnt2" id="reg_tab" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" width="990" align="center">
								<colgroup>
										<col width="65">
										<col width="130">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
									</colgroup>
									<thead>
	<tr>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center"><b>Type</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center"><b>팀</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">구분</p>
		</td>
		
		<%-- <c:if test="${toMonthInt}" eq 0> --%>
		<form>
		<input type="hidden" var="i" name="month_i">
		<c:forEach var ="i" begin="${toMonthInt}" end="${toMonthInt+11}" step="1" varStatus="status">
		<td class="td" bgcolor="#EFEFEF">
			<c:choose>
				<c:when test="${i > 12}">
					<p id="${i}" align="center">${i-12}월</p>
				</c:when>
				<c:otherwise>
					<p id="${i}" align="center">${i}월</p>
				</c:otherwise>
			</c:choose>
		</td>
		</form>
		</c:forEach>

		<td class="td" bgcolor="#EFEFEF">
			<p align="center"><b>합계</b></p>
		</td>
	</tr>
	</thead>
	<tbody>
	
		<c:set var="monthPlusInt" value="0" />
		<c:forEach var="vo" items="${kind1endList}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<c:if test="${status.index == 0}">
			<td class="td" bgcolor="#F8F8F8" rowspan="${kind1endList.size()}">
				<c:out value="1종" />
			</td>
		</c:if>
		<td>
			<a href="./end_member?team_name=${vo.getTeam_name()}&team_id=${vo.getTeam_id()}&year=${toAccumYear}&month=${toMonthInt+monthPlusInt}&fromdate=${fromdate}&todate=${todate}">
			<c:set var="monthPlusInt" value="${monthPlusInt+1}" />
			<c:out value="${vo.getTeam_name()}" />
		</td>
		<td>
			건수<br>순수 피(Fee)<br>일비<br>교통비<br>자문료+기타<br>총합계
		</td>
		<td>
			<c:out value="${vo.getEnd_rid()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid2()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total2()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid3()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total3()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid4()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total4()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid5()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total5()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid6()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total6()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid7()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total7()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid8()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total8()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid9()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total9()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid10()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total10()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid11()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total11()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_rid12()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total12()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vo.getEnd_sum()}" /><br>
			<fmt:formatNumber value="${vo.getPrice_assess_sum()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_time_sum()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_traffic_sum()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_qr_sum()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vo.getPrice_total_sum()}" pattern="#,##0.##"/>
		</td>
		
		
		<%-- <td>
			<c:out value="${vo.getReg_sum()}" /><br>
			<c:out value="${vo.getEnd_sum()}" />
		</td> --%>
	</c:forEach>
	</tr>
	</tbody>
	
	<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<b>소계</b>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">건수<br>순수 피(Fee)<br>일비<br>교통비<br>자문료+기타<br>총합계
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid2()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total2()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid3()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total3()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid4()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total4()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid5()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total5()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid6()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total6()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid7()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total7()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid8()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total8()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid9()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total9()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid10()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total10()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid11()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total11()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid12()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total12()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end1.getSum_rid_t()}"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_assess_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_time_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_traffic_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_qr_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end1.getSum_total_t()}" pattern="#,##0.##"/>
		</td>
		
		
	</tr>
	<tbody>
		
		<c:set var="monthPlusInt" value="0" />
		<c:forEach var="vot" items="${kind4endList}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<c:if test="${status.index == 0}">
			<td class="td" bgcolor="#F8F8F8" rowspan="${kind4endList.size()}">
				<c:out value="4종" />
			</td>
		</c:if>
		<td>
			<c:out value="${vot.getTeam_name()}" />
		</td>
		<td>
			건수<br>순수 피(Fee)<br>일비<br>교통비<br>자문료+기타<br>총합계
		</td>
		<td>
			<c:out value="${vot.getEnd_rid()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid2()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total2()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid3()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total3()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid4()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total4()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid5()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total5()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid6()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total6()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid7()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total7()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid8()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total8()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid9()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total9()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid10()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total10()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid11()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total11()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_rid12()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total12()}" pattern="#,##0.##"/>
		</td>
		<td>
			<c:out value="${vot.getEnd_sum()}" /><br>
			<fmt:formatNumber value="${vot.getPrice_assess_sum()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_time_sum()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_traffic_sum()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_qr_sum()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${vot.getPrice_total_sum()}" pattern="#,##0.##"/>
		</td>
		</tr>
		</c:forEach>
		<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<b>소계</b>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">건수<br>순수 피(Fee)<br>일비<br>교통비<br>자문료+기타<br>총합계
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid2()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total2()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid3()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total3()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid4()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total4()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid5()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total5()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid6()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total6()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid7()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total7()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid8()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total8()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid9()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total9()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid10()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total10()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid11()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total11()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid12()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total12()}" pattern="#,##0.##"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_end4.getSum_rid_t()}"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_assess_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_time_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_traffic_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_qr_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end4.getSum_total_t()}" pattern="#,##0.##"/>
		</td>
	<tbody>
	<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<p align="center"><b>합계</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">건수<br>순수 피(Fee)<br>일비<br>교통비<br>자문료+기타<br>총합계</p>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid2()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr2()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total2()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid3()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr3()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total3()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid4()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr4()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total4()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid5()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr5()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total5()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid6()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr6()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total6()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid7()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr7()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total7()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid8()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr8()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total8()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid9()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr9()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total9()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid10()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr10()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total10()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid11()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr11()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total11()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid12()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr12()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total12()}" pattern="#,##0.##"/></font>
		</td>
		<td class="td" bgcolor="#EFEFEF"><font color="red">
			<c:out value="${sum_end14.getSum_rid_t()}"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_assess_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_time_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_traffic_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_qr_t()}" pattern="#,##0.##"/><br>
			<fmt:formatNumber value="${sum_end14.getSum_total_t()}" pattern="#,##0.##"/></font>
		</td>
		
		</tr>
		</tbody>
		
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
