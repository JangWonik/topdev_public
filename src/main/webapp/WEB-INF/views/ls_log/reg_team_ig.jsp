<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="kind1regList" value="${kind1regList}" />
<c:set var="kind4regList" value="${kind4regList}" />

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="reg_team_ig_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
									<li class="on"><a>${toMonthInt}월 보험사별 수임현황</a></li>
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
			<p align="center"><b>보험사</b></p>
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
		<td class="td" bgcolor="#F8F8F8" rowspan="27">
			<b>1종</b>
		</td>
		<c:set var="monthPlusInt" value="0" />
		<c:forEach var="vo" items="${kind1regList}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<td>
			<c:out value="${vo.getIg_nick()}" />
		</td>
		<td>
			수임<br>종결
		</td>
		<td>
			<c:out value="${vo.getReg_rid()}" /><br>
			<c:out value="${vo.getEnd_rid()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid2()}" /><br>
			<c:out value="${vo.getEnd_rid2()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid3()}" /><br>
			<c:out value="${vo.getEnd_rid3()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid4()}" /><br>
			<c:out value="${vo.getEnd_rid4()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid5()}" /><br>
			<c:out value="${vo.getEnd_rid5()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid6()}" /><br>
			<c:out value="${vo.getEnd_rid6()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid7()}" /><br>
			<c:out value="${vo.getEnd_rid7()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid8()}" /><br>
			<c:out value="${vo.getEnd_rid8()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid9()}" /><br>
			<c:out value="${vo.getEnd_rid9()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid10()}" /><br>
			<c:out value="${vo.getEnd_rid10()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid11()}" /><br>
			<c:out value="${vo.getEnd_rid11()}" />
		</td>
		<td>
			<c:out value="${vo.getReg_rid12()}" /><br>
			<c:out value="${vo.getEnd_rid12()}" />
		</td>
		
		<td>
			<c:out value="${vo.getReg_sum()}" /><br>
			<c:out value="${vo.getEnd_sum()}" />
		</td>
	</c:forEach>
	</tr>
	</tbody>
	<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<b>소계</b>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">수임<br>종결</p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg()}"/><br>
			<c:out value="${sum_end.getSum_end()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg2()}"/><br>
			<c:out value="${sum_end.getSum_end2()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg3()}"/><br>
			<c:out value="${sum_end.getSum_end3()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg4()}"/><br>
			<c:out value="${sum_end.getSum_end4()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg5()}"/><br>
			<c:out value="${sum_end.getSum_end5()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg6()}"/><br>
			<c:out value="${sum_end.getSum_end6()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg7()}"/><br>
			<c:out value="${sum_end.getSum_end7()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg8()}"/><br>
			<c:out value="${sum_end.getSum_end8()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg9()}"/><br>
			<c:out value="${sum_end.getSum_end9()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg10()}"/><br>
			<c:out value="${sum_end.getSum_end10()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg11()}"/><br>
			<c:out value="${sum_end.getSum_end11()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg12()}"/><br>
			<c:out value="${sum_end.getSum_end12()}"/>
		</td>	
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg.getSum_reg_sum()}"/><br>
			<c:out value="${sum_end.getSum_end_sum()}"/>
		</td>
		
	</tr>
	<tbody>
	<tbody>
		<td class="td" bgcolor="#F8F8F8" rowspan="27">
			<b>4종</b>
		</td>
		<c:forEach var="vot" items="${kind4regList}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<td>
			<c:out value="${vot.getIg_nick()}" />
		</td>
		<td>
			수임<br>종결
		</td>
		<td>
			<c:out value="${vot.getReg_rid()}" /><br>
			<c:out value="${vot.getEnd_rid()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid2()}" /><br>
			<c:out value="${vot.getEnd_rid2()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid3()}" /><br>
			<c:out value="${vot.getEnd_rid3()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid4()}" /><br>
			<c:out value="${vot.getEnd_rid4()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid5()}" /><br>
			<c:out value="${vot.getEnd_rid5()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid6()}" /><br>
			<c:out value="${vot.getEnd_rid6()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid7()}" /><br>
			<c:out value="${vot.getEnd_rid7()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid8()}" /><br>
			<c:out value="${vot.getEnd_rid8()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid9()}" /><br>
			<c:out value="${vot.getEnd_rid9()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid10()}" /><br>
			<c:out value="${vot.getEnd_rid10()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid11()}" /><br>
			<c:out value="${vot.getEnd_rid11()}" />
		</td>
		<td>
			<c:out value="${vot.getReg_rid12()}" /><br>
			<c:out value="${vot.getEnd_rid12()}" />
		</td>
		
		<td>
			<c:out value="${vot.getReg_sum()}" /><br>
			<c:out value="${vot.getEnd_sum()}" />
		</td>
	</c:forEach>
	</tr>
	</tbody>
	<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<b>소계</b>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">수임<br>종결</p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg()}"/><br>
			<c:out value="${sum_end4.getSum_end()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg2()}"/><br>
			<c:out value="${sum_end4.getSum_end2()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg3()}"/><br>
			<c:out value="${sum_end4.getSum_end3()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg4()}"/><br>
			<c:out value="${sum_end4.getSum_end4()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg5()}"/><br>
			<c:out value="${sum_end4.getSum_end5()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg6()}"/><br>
			<c:out value="${sum_end4.getSum_end6()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg7()}"/><br>
			<c:out value="${sum_end4.getSum_end7()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg8()}"/><br>
			<c:out value="${sum_end4.getSum_end8()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg9()}"/><br>
			<c:out value="${sum_end4.getSum_end9()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg10()}"/><br>
			<c:out value="${sum_end4.getSum_end10()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg11()}"/><br>
			<c:out value="${sum_end4.getSum_end11()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg12()}"/><br>
			<c:out value="${sum_end4.getSum_end12()}"/>
		</td>	
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${sum_reg4.getSum_reg_sum4()}"/><br>
			<c:out value="${sum_end4.getSum_end_sum4()}"/>
		</td>
		
	</tr>
	<tbody>
	<tr>
		<td class="td" bgcolor="#F8F8F8" colspan="2">
			<p align="center"><b>합계</b></p>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<p align="center">수임<br>종결</p>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg()}"/><br>
			<c:out value="${sum_end14.getSum_total_end()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg2()}"/><br>
			<c:out value="${sum_end14.getSum_total_end2()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg3()}"/><br>
			<c:out value="${sum_end14.getSum_total_end3()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg4()}"/><br>
			<c:out value="${sum_end14.getSum_total_end4()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg5()}"/><br>
			<c:out value="${sum_end14.getSum_total_end5()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg6()}"/><br>
			<c:out value="${sum_end14.getSum_total_end6()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg7()}"/><br>
			<c:out value="${sum_end14.getSum_total_end7()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg8()}"/><br>
			<c:out value="${sum_end14.getSum_total_end8()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg9()}"/><br>
			<c:out value="${sum_end14.getSum_total_end9()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg10()}"/><br>
			<c:out value="${sum_end14.getSum_total_end10()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg11()}"/><br>
			<c:out value="${sum_end14.getSum_total_end11()}"/></font>
		</td>
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_total_reg12()}"/><br>
			<c:out value="${sum_end14.getSum_total_end12()}"/></font>
		</td>	
		<td class="td" bgcolor="#F8F8F8"><font color="red">
			<c:out value="${sum_reg14.getSum_reg_sum14()}"/><br>
			<c:out value="${sum_end14.getSum_end_sum14()}"/></font>
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
