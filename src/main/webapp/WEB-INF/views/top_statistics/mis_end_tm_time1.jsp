<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
	<div style="width:100%; overflow-x: auto; overflow-y: hidden !important;">
		<div style="width:1882px;" >
			<div style="padding-right: 17px; background: #e7ecf1;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
					<thead>
						<tr>
							<th>Type</th>
							<th style="width: 150px;">센터</th>
							<th style="width: 150px;">부서</th>
							<th>${nowVO.monBefore11.substring(0,7)}</th>
							<th>${nowVO.monBefore10.substring(0,7)}</th>
							<th>${nowVO.monBefore9.substring(0,7)}</th>
							<th>${nowVO.monBefore8.substring(0,7)}</th>
							<th>${nowVO.monBefore7.substring(0,7)}</th>
							<th>${nowVO.monBefore6.substring(0,7)}</th>
							<th>${nowVO.monBefore5.substring(0,7)}</th>
							<th>${nowVO.monBefore4.substring(0,7)}</th>
							<th>${nowVO.monBefore3.substring(0,7)}</th>
							<th>${nowVO.monBefore2.substring(0,7)}</th>
							<th>${nowVO.monBefore1.substring(0,7)}</th>
							<th>${nowVO.monBefore0.substring(0,7)}</th>
							<th>합계</th>
						</tr>
					</thead>
				</table>
			</div>
		    <div style="height:634px; overflow-x: hidden; overflow-y: auto;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">		
					<tbody>
						<c:forEach var="vo" items="${MisEndTmTime1}" varStatus="status">
							<tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
								onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
		                		onclick="goMisEndTmTimeMbr('${srchArg.stdBgnde}','${srchArg.stdEndde}','${vo.team_id}','${vo.team_type}');" >
								<c:if test="${status.index == 0}">
									<td rowspan="${MisEndTmTime1.size() + 1}">1종</td>
								</c:if>
								<td style="width: 150px;">
									${vo.center_name}
								</td>
								<td style="width: 150px;">
									${vo.team_name}
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time12}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time11}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time10}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time9}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time8}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time7}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time6}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time5}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time4}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time3}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time2}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time12+vo.price_time11+vo.price_time10+vo.price_time9+vo.price_time8+vo.price_time7+vo.price_time6+vo.price_time5+vo.price_time4+vo.price_time3+vo.price_time2+vo.price_time}" pattern="#,##0.##"/>
								</td>
							</tr>
								<c:set var="sumPrice_time12" value="${sumPrice_time12 + vo.price_time12}" />
								<c:set var="sumPrice_time11" value="${sumPrice_time11 + vo.price_time11}" />
								<c:set var="sumPrice_time10" value="${sumPrice_time10 + vo.price_time10}" />
								<c:set var="sumPrice_time9" value="${sumPrice_time9 + vo.price_time9}" />
								<c:set var="sumPrice_time8" value="${sumPrice_time8 + vo.price_time8}" />
								<c:set var="sumPrice_time7" value="${sumPrice_time7 + vo.price_time7}" />
								<c:set var="sumPrice_time6" value="${sumPrice_time6 + vo.price_time6}" />
								<c:set var="sumPrice_time5" value="${sumPrice_time5 + vo.price_time5}" />
								<c:set var="sumPrice_time4" value="${sumPrice_time4 + vo.price_time4}" />
								<c:set var="sumPrice_time3" value="${sumPrice_time3 + vo.price_time3}" />
								<c:set var="sumPrice_time2" value="${sumPrice_time2 + vo.price_time2}" />
								<c:set var="sumPrice_time" value="${sumPrice_time + vo.price_time}" />
								<c:set var="sumPrice_time_sum" value="${sumPrice_time_sum + vo.price_time12+vo.price_time11+vo.price_time10+vo.price_time9+vo.price_time8+vo.price_time7+vo.price_time6+vo.price_time5+vo.price_time4+vo.price_time3+vo.price_time2+vo.price_time}" />
							</c:forEach>
						<tr bgcolor="#E7ECF1">
							<td colspan="2">1종 소계</td>
							<td><fmt:formatNumber value="${sumPrice_time12}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time11}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time10}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time9}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time8}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time7}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time6}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time5}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time4}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time3}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time2}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time_sum}" pattern="#,##0.##"/></td>
						</tr>
						<c:forEach var="vo" items="${MisEndTmTime4}" varStatus="status">
							<tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
								onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
			                	onclick="goMisEndTmTimeMbr('${srchArg.stdBgnde}','${srchArg.stdEndde}','${vo.team_id}','${vo.team_type}');" >
								<c:if test="${status.index == 0}">
									<td rowspan="${MisEndTmTime4.size() + 1}">4종</td>
								</c:if>
								<td>
									${vo.center_name}
								</td>
								<td>
									${vo.team_name}
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time12}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time11}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time10}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time9}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time8}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time7}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time6}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time5}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time4}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time3}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time2}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time}" pattern="#,##0.##"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_time12+vo.price_time11+vo.price_time10+vo.price_time9+vo.price_time8+vo.price_time7+vo.price_time6+vo.price_time5+vo.price_time4+vo.price_time3+vo.price_time2+vo.price_time}" pattern="#,##0.##"/>
								</td>
							</tr>
								<c:set var="sumPrice4_time12" value="${sumPrice4_time12 + vo.price_time12}" />
								<c:set var="sumPrice4_time11" value="${sumPrice4_time11 + vo.price_time11}" />
								<c:set var="sumPrice4_time10" value="${sumPrice4_time10 + vo.price_time10}" />
								<c:set var="sumPrice4_time9" value="${sumPrice4_time9 + vo.price_time9}" />
								<c:set var="sumPrice4_time8" value="${sumPrice4_time8 + vo.price_time8}" />
								<c:set var="sumPrice4_time7" value="${sumPrice4_time7 + vo.price_time7}" />
								<c:set var="sumPrice4_time6" value="${sumPrice4_time6 + vo.price_time6}" />
								<c:set var="sumPrice4_time5" value="${sumPrice4_time5 + vo.price_time5}" />
								<c:set var="sumPrice4_time4" value="${sumPrice4_time4 + vo.price_time4}" />
								<c:set var="sumPrice4_time3" value="${sumPrice4_time3 + vo.price_time3}" />
								<c:set var="sumPrice4_time2" value="${sumPrice4_time2 + vo.price_time2}" />
								<c:set var="sumPrice4_time" value="${sumPrice4_time + vo.price_time}" />
								<c:set var="sumPrice4_time_sum" value="${sumPrice4_time_sum + vo.price_time12+vo.price_time11+vo.price_time10+vo.price_time9+vo.price_time8+vo.price_time7+vo.price_time6+vo.price_time5+vo.price_time4+vo.price_time3+vo.price_time2+vo.price_time}" />
							</c:forEach>
						<tr bgcolor="#E7ECF1">
							<td colspan="2">4종 소계</td>
							<td><fmt:formatNumber value="${sumPrice4_time12}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time11}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time10}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time9}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time8}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time7}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time6}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time5}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time4}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time3}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time2}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice4_time_sum}" pattern="#,##0.##"/></td>
						</tr>
						<tr bgcolor="#E7ECF1">
							<td colspan="3">합계</td>
							<td><fmt:formatNumber value="${sumPrice_time12 + sumPrice4_time12}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time11 + sumPrice4_time11}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time10 + sumPrice4_time10}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time9 + sumPrice4_time9}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time8 + sumPrice4_time8}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time7 + sumPrice4_time7}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time6 + sumPrice4_time6}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time5 + sumPrice4_time5}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time4 + sumPrice4_time4}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time3 + sumPrice4_time3}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time2 + sumPrice4_time2}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time + sumPrice4_time}" pattern="#,##0.##"/></td>
							<td><fmt:formatNumber value="${sumPrice_time_sum + sumPrice4_time_sum}" pattern="#,##0.##"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>