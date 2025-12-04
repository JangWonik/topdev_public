<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="Reg_M1List" value="${Reg_M1List}" />
<c:set var="ig1List" value="${ig1List}" />
<c:set var="Reg_M4List" value="${Reg_M4List}" />
<c:set var="year" value="${year}" />
<c:set var="month" value="${month}" />
<c:set var="dayListSize" value="${dayListSize}" />

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="reg_ig_month_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
									<li class="on"><a><c:if test="${month < 10}">0${month}</c:if>월 보험사별 현황</a></li>
							</ul>
						</div>
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
		
		<c:forEach var ="i" begin="16" end="${16+(dayListSize-1)}" step="1" varStatus="status">
		<td class="td" bgcolor="#EFEFEF">
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

		<td class="td" bgcolor="#EFEFEF">
			<p align="center"><b>합계</b></p>
		</td>
	</tr>
	</thead>
	<tbody>
	<c:set var="vo2" value="${End_M1List}" />
		<c:forEach var="vo" items="${Reg_M1List}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
					<c:if test="${status.index == 0}">
						<td class="td" bgcolor="#F8F8F8" rowspan="${Reg_M1List.size()}">
 							<c:out value="1종" />
						</td>
 					</c:if>
		<td>
			<c:out value="${vo.getIg_nick()}" />
		</td>
		<td>
			수임<br>종결
		</td>
		<td>
			<c:out value="${vo.getRid1()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd1()}" />
		</td>
		<td>
			<c:out value="${vo.getRid2()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd2()}" />
		</td>
		<td>
			<c:out value="${vo.getRid3()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd3()}" />
		</td>
		<td>
			<c:out value="${vo.getRid4()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd4()}" />
		</td>
		<td>
			<c:out value="${vo.getRid5()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd5()}" />
		</td>
		<td>
			<c:out value="${vo.getRid6()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd6()}" />
		</td>
		<td>
			<c:out value="${vo.getRid7()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd7()}" />
		</td>
		<td>
			<c:out value="${vo.getRid8()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd8()}" />
		</td>
		<td>
			<c:out value="${vo.getRid9()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd9()}" />
		</td>
		<td>
			<c:out value="${vo.getRid10()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd10()}" />
		</td>
		<td>
			<c:out value="${vo.getRid11()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd11()}" />
		</td>
		<td>
			<c:out value="${vo.getRid12()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd12()}" />
		</td>
		<td>
			<c:out value="${vo.getRid13()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd13()}" />
		</td>
		<td>
			<c:out value="${vo.getRid14()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd14()}" />
		</td>
		<td>
			<c:out value="${vo.getRid15()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd15()}" />
		</td>
		<td>
			<c:out value="${vo.getRid16()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd16()}" />
		</td>
		<td>
			<c:out value="${vo.getRid17()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd17()}" />
		</td>
		<td>
			<c:out value="${vo.getRid18()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd18()}" />
		</td>
		<td>
			<c:out value="${vo.getRid19()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd19()}" />
		</td>
		<td>
			<c:out value="${vo.getRid20()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd20()}" />
		</td>
		<td>
			<c:out value="${vo.getRid21()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd21()}" />
		</td>
		<td>
			<c:out value="${vo.getRid22()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd22()}" />
		</td>
		<td>
			<c:out value="${vo.getRid23()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd23()}" />
		</td>
		<td>
			<c:out value="${vo.getRid24()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd24()}" />
		</td>
		<td>
			<c:out value="${vo.getRid25()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd25()}" />
		</td>
		<td>
			<c:out value="${vo.getRid26()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd26()}" />
		</td>
		<td>
			<c:out value="${vo.getRid27()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd27()}" />
		</td>
		<td>
			<c:out value="${vo.getRid28()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd28()}" />
		</td>
		<td>
			<c:out value="${vo.getRid29()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd29()}" />
		</td>
		<td>
			<c:out value="${vo.getRid30()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd30()}" />
		</td>
		<td>
			<c:out value="${vo.getRid31()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd31()}" />
		</td>
		<td>
			<c:out value="${vo.getRid_sum()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd_sum()}" />
		</td>

	</tr>
		</c:forEach>
	</tbody>
	<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<b>소계</b>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">수임<br>종결</p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid1()}"/><br>
			<c:out value="${regend_sum1.getSum_end1()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid2()}"/><br>
			<c:out value="${regend_sum1.getSum_end2()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid3()}"/><br>
			<c:out value="${regend_sum1.getSum_end3()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid4()}"/><br>
			<c:out value="${regend_sum1.getSum_end4()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid5()}"/><br>
			<c:out value="${regend_sum1.getSum_end5()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid6()}"/><br>
			<c:out value="${regend_sum1.getSum_end6()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid7()}"/><br>
			<c:out value="${regend_sum1.getSum_end7()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid8()}"/><br>
			<c:out value="${regend_sum1.getSum_end8()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid9()}"/><br>
			<c:out value="${regend_sum1.getSum_end9()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid10()}"/><br>
			<c:out value="${regend_sum1.getSum_end10()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid11()}"/><br>
			<c:out value="${regend_sum1.getSum_end11()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid12()}"/><br>
			<c:out value="${regend_sum1.getSum_end12()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid13()}"/><br>
			<c:out value="${regend_sum1.getSum_end13()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid14()}"/><br>
			<c:out value="${regend_sum1.getSum_end14()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid15()}"/><br>
			<c:out value="${regend_sum1.getSum_end15()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid16()}"/><br>
			<c:out value="${regend_sum1.getSum_end16()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid17()}"/><br>
			<c:out value="${regend_sum1.getSum_end17()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid18()}"/><br>
			<c:out value="${regend_sum1.getSum_end18()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid19()}"/><br>
			<c:out value="${regend_sum1.getSum_end19()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid20()}"/><br>
			<c:out value="${regend_sum1.getSum_end20()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid21()}"/><br>
			<c:out value="${regend_sum1.getSum_end21()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid22()}"/><br>
			<c:out value="${regend_sum1.getSum_end22()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid23()}"/><br>
			<c:out value="${regend_sum1.getSum_end23()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid24()}"/><br>
			<c:out value="${regend_sum1.getSum_end24()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid25()}"/><br>
			<c:out value="${regend_sum1.getSum_end25()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid26()}"/><br>
			<c:out value="${regend_sum1.getSum_end26()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid27()}"/><br>
			<c:out value="${regend_sum1.getSum_end27()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid28()}"/><br>
			<c:out value="${regend_sum1.getSum_end28()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid29()}"/><br>
			<c:out value="${regend_sum1.getSum_end29()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid30()}"/><br>
			<c:out value="${regend_sum1.getSum_end30()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid31()}"/><br>
			<c:out value="${regend_sum1.getSum_end31()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum1.getSum_rid_sum()}"/><br>
			<c:out value="${regend_sum1.getSum_end_sum()}"/>
		</td>
	</tr>
	<tbody>
	<c:set var="vo2" value="${End_M4List}" />
		<c:forEach var="vo" items="${Reg_M4List}" varStatus="status">
	<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
					<c:if test="${status.index == 0}">
						<td class="td" bgcolor="#F8F8F8" rowspan="${Reg_M4List.size()}">
 							<c:out value="4종" />
						</td>
 					</c:if>
		<td>
			<c:out value="${vo.getIg_nick()}" />
		</td>
		<td>
			수임<br>종결
		</td>
		<td>
			<c:out value="${vo.getRid1()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd1()}" />
		</td>
		<td>
			<c:out value="${vo.getRid2()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd2()}" />
		</td>
		<td>
			<c:out value="${vo.getRid3()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd3()}" />
		</td>
		<td>
			<c:out value="${vo.getRid4()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd4()}" />
		</td>
		<td>
			<c:out value="${vo.getRid5()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd5()}" />
		</td>
		<td>
			<c:out value="${vo.getRid6()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd6()}" />
		</td>
		<td>
			<c:out value="${vo.getRid7()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd7()}" />
		</td>
		<td>
			<c:out value="${vo.getRid8()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd8()}" />
		</td>
		<td>
			<c:out value="${vo.getRid9()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd9()}" />
		</td>
		<td>
			<c:out value="${vo.getRid10()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd10()}" />
		</td>
		<td>
			<c:out value="${vo.getRid11()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd11()}" />
		</td>
		<td>
			<c:out value="${vo.getRid12()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd12()}" />
		</td>
		<td>
			<c:out value="${vo.getRid13()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd13()}" />
		</td>
		<td>
			<c:out value="${vo.getRid14()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd14()}" />
		</td>
		<td>
			<c:out value="${vo.getRid15()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd15()}" />
		</td>
		<td>
			<c:out value="${vo.getRid16()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd16()}" />
		</td>
		<td>
			<c:out value="${vo.getRid17()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd17()}" />
		</td>
		<td>
			<c:out value="${vo.getRid18()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd18()}" />
		</td>
		<td>
			<c:out value="${vo.getRid19()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd19()}" />
		</td>
		<td>
			<c:out value="${vo.getRid20()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd20()}" />
		</td>
		<td>
			<c:out value="${vo.getRid21()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd21()}" />
		</td>
		<td>
			<c:out value="${vo.getRid22()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd22()}" />
		</td>
		<td>
			<c:out value="${vo.getRid23()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd23()}" />
		</td>
		<td>
			<c:out value="${vo.getRid24()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd24()}" />
		</td>
		<td>
			<c:out value="${vo.getRid25()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd25()}" />
		</td>
		<td>
			<c:out value="${vo.getRid26()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd26()}" />
		</td>
		<td>
			<c:out value="${vo.getRid27()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd27()}" />
		</td>
		<td>
			<c:out value="${vo.getRid28()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd28()}" />
		</td>
		<td>
			<c:out value="${vo.getRid29()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd29()}" />
		</td>
		<td>
			<c:out value="${vo.getRid30()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd30()}" />
		</td>
		<td>
			<c:out value="${vo.getRid31()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd31()}" />
		</td>
		<td>
			<c:out value="${vo.getRid_sum()}" /><br>
			<c:out value="${vo2.get(status.index).getEnd_sum()}" />
		</td>

	</tr>
		</c:forEach>
	</tbody>
	<tr>
		<td class="td" bgcolor="#EFEFEF" colspan="2">
			<b>소계</b>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<p align="center">수임<br>종결</p>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid1()}"/><br>
			<c:out value="${regend_sum4.getSum_end1()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid2()}"/><br>
			<c:out value="${regend_sum4.getSum_end2()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid3()}"/><br>
			<c:out value="${regend_sum4.getSum_end3()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid4()}"/><br>
			<c:out value="${regend_sum4.getSum_end4()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid5()}"/><br>
			<c:out value="${regend_sum4.getSum_end5()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid6()}"/><br>
			<c:out value="${regend_sum4.getSum_end6()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid7()}"/><br>
			<c:out value="${regend_sum4.getSum_end7()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid8()}"/><br>
			<c:out value="${regend_sum4.getSum_end8()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid9()}"/><br>
			<c:out value="${regend_sum4.getSum_end9()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid10()}"/><br>
			<c:out value="${regend_sum4.getSum_end10()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid11()}"/><br>
			<c:out value="${regend_sum4.getSum_end11()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid12()}"/><br>
			<c:out value="${regend_sum4.getSum_end12()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid13()}"/><br>
			<c:out value="${regend_sum4.getSum_end13()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid14()}"/><br>
			<c:out value="${regend_sum4.getSum_end14()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid15()}"/><br>
			<c:out value="${regend_sum4.getSum_end15()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid16()}"/><br>
			<c:out value="${regend_sum4.getSum_end16()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid17()}"/><br>
			<c:out value="${regend_sum4.getSum_end17()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid18()}"/><br>
			<c:out value="${regend_sum4.getSum_end18()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid19()}"/><br>
			<c:out value="${regend_sum4.getSum_end19()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid20()}"/><br>
			<c:out value="${regend_sum4.getSum_end20()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid21()}"/><br>
			<c:out value="${regend_sum4.getSum_end21()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid22()}"/><br>
			<c:out value="${regend_sum4.getSum_end22()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid23()}"/><br>
			<c:out value="${regend_sum4.getSum_end23()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid24()}"/><br>
			<c:out value="${regend_sum4.getSum_end24()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid25()}"/><br>
			<c:out value="${regend_sum4.getSum_end25()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid26()}"/><br>
			<c:out value="${regend_sum4.getSum_end26()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid27()}"/><br>
			<c:out value="${regend_sum4.getSum_end27()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid28()}"/><br>
			<c:out value="${regend_sum4.getSum_end28()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid29()}"/><br>
			<c:out value="${regend_sum4.getSum_end29()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid30()}"/><br>
			<c:out value="${regend_sum4.getSum_end30()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid31()}"/><br>
			<c:out value="${regend_sum4.getSum_end31()}"/>
		</td>
		<td class="td" bgcolor="#EFEFEF">
			<c:out value="${regend_sum4.getSum_rid_sum()}"/><br>
			<c:out value="${regend_sum4.getSum_end_sum()}"/>
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
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid1()}"/><br>
			<c:out value="${regend_sum14.getSum_end1()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid2()}"/><br>
			<c:out value="${regend_sum14.getSum_end2()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid3()}"/><br>
			<c:out value="${regend_sum14.getSum_end3()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid4()}"/><br>
			<c:out value="${regend_sum14.getSum_end4()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid5()}"/><br>
			<c:out value="${regend_sum14.getSum_end5()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid6()}"/><br>
			<c:out value="${regend_sum14.getSum_end6()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid7()}"/><br>
			<c:out value="${regend_sum14.getSum_end7()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid8()}"/><br>
			<c:out value="${regend_sum14.getSum_end8()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid9()}"/><br>
			<c:out value="${regend_sum14.getSum_end9()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid10()}"/><br>
			<c:out value="${regend_sum14.getSum_end10()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid11()}"/><br>
			<c:out value="${regend_sum14.getSum_end11()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid12()}"/><br>
			<c:out value="${regend_sum14.getSum_end12()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid13()}"/><br>
			<c:out value="${regend_sum14.getSum_end13()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid14()}"/><br>
			<c:out value="${regend_sum14.getSum_end14()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid15()}"/><br>
			<c:out value="${regend_sum14.getSum_end15()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid16()}"/><br>
			<c:out value="${regend_sum14.getSum_end16()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid17()}"/><br>
			<c:out value="${regend_sum14.getSum_end17()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid18()}"/><br>
			<c:out value="${regend_sum14.getSum_end18()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid19()}"/><br>
			<c:out value="${regend_sum14.getSum_end19()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid20()}"/><br>
			<c:out value="${regend_sum14.getSum_end20()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid21()}"/><br>
			<c:out value="${regend_sum14.getSum_end21()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid22()}"/><br>
			<c:out value="${regend_sum14.getSum_end22()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid23()}"/><br>
			<c:out value="${regend_sum14.getSum_end23()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid24()}"/><br>
			<c:out value="${regend_sum14.getSum_end24()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid25()}"/><br>
			<c:out value="${regend_sum14.getSum_end25()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid26()}"/><br>
			<c:out value="${regend_sum14.getSum_end26()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid27()}"/><br>
			<c:out value="${regend_sum14.getSum_end27()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid28()}"/><br>
			<c:out value="${regend_sum14.getSum_end28()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid29()}"/><br>
			<c:out value="${regend_sum14.getSum_end29()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid30()}"/><br>
			<c:out value="${regend_sum14.getSum_end30()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid31()}"/><br>
			<c:out value="${regend_sum14.getSum_end31()}"/>
		</td>
		<td class="td" bgcolor="#F8F8F8">
			<c:out value="${regend_sum14.getSum_rid_sum()}"/><br>
			<c:out value="${regend_sum14.getSum_end_sum()}"/>
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
