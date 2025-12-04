<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="monthInt" value="${month}" />
<c:set var="ReusltIgTList4" value="${ReusltIgTList4}" />
<c:set var="R_Ig_T4List" value="${R_Ig_T4List}" />


				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="result_ig_member_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
									<li class="on"><a>${toMonthInt}월 팀별 처리내용</a></li>
							</ul>
						</div>
						<div class="guestcnt2" id="reg_tab" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" width="990" align="center">
								<colgroup>
										<col width="60">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
									</colgroup>
									<thead>
	<tr>
		<td class="td" bgcolor="#EFEFEF"><p><b>구성원</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>유지/지급</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>유지/삭감</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>유지/면책</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>해지/지급</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>해지/삭감</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>해지/면책</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>무담보/지급</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>무담보/삭감</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>무담보/면책</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>합계</b></p></td>		
	</tr>
	</thead>
	<tbody>

		<c:forEach var="vo" items="${R_Ig_M4List}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<td>
			<a href="./result_ig_member?ig_nick=${vo.getIg_nick()}&ig_id=${vo.getIg_id()}&team_id=${vo.getTeam_id()}&Team_name=${vo.getTeam_name()}&ViewFromDate=${fromdate}&ViewToDate=${todate}">
			<c:out value="${vo.getName()}" />
		</td>
		<td>
			<c:out value="${vo.getReport_result1()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result2()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result3()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result4()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result5()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result6()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result7()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result8()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result9()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getReport_result_sum()}" /><br>
		</td>
	</c:forEach>
	</tr>
	</tbody>
	
	<tbody>
	<tr>
		<td class="td" bgcolor="#F8F8F8" >
			<p align="center"><b>합계</b></p>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result1()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result2()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result3()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result4()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result5()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result6()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result7()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result8()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result9()}"/><br>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${ResultIgSumMVO.getSum_report_result_sum()}"/><br>
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
