<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kind1List" value="${kind1List}" />
<c:set var="kind4List" value="${kind4List}" />

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="log_nsc_team_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a>${toAccumYear}년 ${toMonthInt}월 팀별 평균 통계</a></li>
							</ul>
						</div>
						<div class="guestcnt2" style="display:block;">
							<div class="tableStyle2">
							<table cellpadding="0" cellspacing="0" width="98%" align="center">
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
										<col width="80">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="80">
										
									</colgroup>
	<tr align="center" bgcolor="#EFEFEF">
		<td class="td" nowrap rowspan="3"><B>Type</B></td>
		<td class="td" nowrap rowspan="3"><B>팀</B></td>
		<td class="td" nowrap rowspan="3"><B>조사자</B></td>
		<td class="td" nowrap colspan="7">공동수행자의 비율 및 금액을 반영한 결과<B><font color="red">(반영안함!)</font></b></td>
		<td class="td" nowrap rowspan="3">미수금</td>
		<td class="td" nowrap colspan="7">공동수행자의 비율 및 금액을 반영한 결과<B><font color="red">(반영안함!)</font></b></td>
		<td class="td" nowrap rowspan="3">미수금 총합계</td>
	</tr>
	<tr align="center" bgcolor="#EFEFEF">
		<td class="td" nowrap colspan="7">농작물,적부등 인보이스 현황<font color="red">(당월)</font></td>
		<td class="td" nowrap colspan="7">수임대장 + 농작물,적부등 인보이스 현황<font color="red">(당월)</font></td>
	</tr>
	
	<tr align="center" bgcolor="#EFEFEF">
		<td class="td" nowrap>기본료</td>
		<td class="td" nowrap>일비</td>
		<td class="td" nowrap>소계(기본+일)</td>
		<td class="td" nowrap>교통비</td>
		<td class="td" nowrap>자문료</td>
		<td class="td" nowrap>기타</td>
		<td class="td" nowrap>합계</td>
		<td class="td" nowrap>기본료</td>
		<td class="td" nowrap>일비</td>
		<td class="td" nowrap>소계(기본+일)</td>
		<td class="td" nowrap>교통비</td>
		<td class="td" nowrap>자문료</td>
		<td class="td" nowrap>기타</td>
		<td class="td" nowrap>합계</td>
	</tr>
	<c:set var="gubun" value="0"></c:set>
	<tbody>
	<tr align="right" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
		<td class="td" nowrap bgcolor="#F8F8F8" rowspan="${nkind1List.size()}" >1종</td>	
	<c:forEach var="vo" items="${nkind1List}" varStatus="status">
		<td class="td" align="center">
			<p><a href="./log_nsc_member?team_id=${vo.getTeam_id()}&team_name=${vo.getTeam_name()}"><c:out value="${vo.getTeam_name()}" /></a></p>
		</td>
		<!-- <td class="td" nowrap align="center">
			<p></p>
		</td> -->	
		<td><c:out value="${vo.getUnit_cn()}"/></td>
		<td><c:out value="${vo.getNsc_price_assess()}"/></td>
		<td><c:out value="${vo.getNsc_price_time()}"/></td>
		<td><c:out value="${vo.getNsc_price_sum1()}"/></td>
		<td><c:out value="${vo.getNsc_price_traffic()}"/></td>
		<td><c:out value="${vo.getNsc_price_question()}"/></td>
		<td><c:out value="${vo.getNsc_price_receipt()}"/></td>
		<td><c:out value="${vo.getNsc_price_sum2()}"/></td>
		<td><font color="#FF0066"><c:out value="${vo.getNsc_price_total()}"/></font></td>
		<td><c:out value="${vo.getPrice_assess()}"/></td>
		<td><c:out value="${vo.getPrice_time()}"/></td>
		<td><c:out value="${vo.getPrice_sum1()}"/></td>
		<td><c:out value="${vo.getPrice_traffic()}"/></td>
		<td><c:out value="${vo.getPrice_question()}"/></td>
		<td><c:out value="${vo.getPrice_receipt()}"/></td>
		<td><c:out value="${vo.getPrice_sum2()}"/></td>
		<td><font color="#FF0066"><c:out value="${vo.getPrice_total()}"/></font></td>
	</tr>
	</c:forEach>
	</tbody>
	<tbody>
	<tr align="right" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
		<td class="td" bgcolor="#F8F8F8" rowspan="${nkind4List.size()}">4종</td>
		<c:forEach var="vo" items="${nkind4List}" varStatus="status">
		<td class="td" align="center"><c:out value="${vo.getTeam_name()}"/></td>
		<td><c:out value="${vo.getUnit_cn()}"/></td>
		<td><c:out value="${vo.getNsc_price_assess()}"/></td>
		<td><c:out value="${vo.getNsc_price_time()}"/></td>
		<td><c:out value="${vo.getNsc_price_sum1()}"/></td>
		<td><c:out value="${vo.getNsc_price_traffic()}"/></td>
		<td><c:out value="${vo.getNsc_price_question()}"/></td>
		<td><c:out value="${vo.getNsc_price_receipt()}"/></td>
		<td><c:out value="${vo.getNsc_price_sum2()}"/></td>
		<td><font color="#FF0066"><c:out value="${vo.getNsc_price_total()}"/></font></td>
		<td><c:out value="${vo.getPrice_assess()}"/></td>
		<td><c:out value="${vo.getPrice_time()}"/></td>
		<td><c:out value="${vo.getPrice_sum1()}"/></td>
		<td><c:out value="${vo.getPrice_traffic()}"/></td>
		<td><c:out value="${vo.getPrice_question()}"/></td>
		<td><c:out value="${vo.getPrice_receipt()}"/></td>
		<td><c:out value="${vo.getPrice_sum2()}"/></td>
		<td><font color="#FF0066"><c:out value="${vo.getPrice_total()}"/></font></td>
	</tr>
	</c:forEach>
	</tbody>
	
	<tr align="right" bgcolor="#F8F8F8">
		<td class="td" colspan="2"><b>합 계</b></td>
		<td>-</td>
		<td><c:out value="${sumobj.getSum_nsc_price_assess()}"/></td>
		<td><c:out value="${sumobj.getSum_nsc_price_time()}"/></td>
		<td><c:out value="${sumobj.getSum_nsc_price_sum1()}"/></td>
		<td><c:out value="${sumobj.getSum_nsc_price_traffic()}"/></td>
		<td><c:out value="${sumobj.getSum_nsc_price_question()}"/></td>
		<td><c:out value="${sumobj.getSum_nsc_price_receipt()}"/></td>
		<td><c:out value="${sumobj.getSum_nsc_price_sum2()}"/></td>
		<td><font color="#FF0066"><c:out value="${sumobj.getSum_nsc_price_total()}"/></font></td>
		<td><c:out value="${sumobj.getSum_price_assess()}"/></td>
		<td><c:out value="${sumobj.getSum_price_time()}"/></td>
		<td><c:out value="${sumobj.getSum_price_sum1()}"/></td>
		<td><c:out value="${sumobj.getSum_price_traffic()}"/></td>
		<td><c:out value="${sumobj.getSum_price_question()}"/></td>
		<td><c:out value="${sumobj.getSum_price_receipt()}"/></td>
		<td><c:out value="${sumobj.getSum_price_sum2()}"/></td>
		<td><font color="#FF0066"><c:out value="${sumobj.getSum_price_total()}"/></font></td>
										
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