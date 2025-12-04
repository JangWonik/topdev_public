<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="monthInt" value="${month}" />
<c:set var="regmemberList" value="${regmemberList}" />
<c:set var="kind4regList" value="${kind4regList}" />


				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="reg_member_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
									<li class="on"><a>${toMonthInt}월 ${team_name} 수임현황</a></li>
							</ul>
						</div>
						<div class="guestcnt2" id="reg_tab" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" width="990" align="center">
								<colgroup>
										<col width="90">
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
										<col width="75">
										<col width="75">
										<col width="75">
									</colgroup>
									<thead>
	<tr>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center"><b>팀</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center"><b>구성원</b></p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">구분</p>
		</td>
		
		<%-- <c:if test="${toMonthInt}" eq 0> --%>
		<form>
		<input type="hidden" var="i" name="month_i">
		<c:forEach var ="i" begin="${month}" end="${month+11}" step="1" varStatus="status">
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
		<c:forEach var="vo" items="${regmemberList}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
		<c:if test="${status.index == 0}">
			<td rowspan="${regmemberList.size()}">
				<c:out value="${vo.getTeam_name()}" />
			</td>
		</c:if>
		<td>
			<c:out value="${vo.getName()}" />
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
