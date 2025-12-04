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
						<c:forEach var="vo" items="${MisEndTmAssess1}" varStatus="status">
							<tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
								onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
			                	onclick="goMisEndTmAssessMbr('${srchArg.stdBgnde}','${srchArg.stdEndde}','${vo.team_id}','${vo.team_type}');" >
								<c:if test="${status.index == 0}">
									<td rowspan="${MisEndTmAssess1.size() + 1}">1종</td>
								</c:if>
								<td style="width: 150px;">
									${vo.center_name}
								</td>
								<td style="width: 150px;">
									${vo.team_name}
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess12}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess11}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess10}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess9}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess8}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess7}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess6}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess5}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess4}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess3}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess2}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" pattern="#,##0"/>
								</td>
							</tr>
								<c:set var="sumPrice_assess12" value="${sumPrice_assess12 + vo.price_assess12}" />
								<c:set var="sumPrice_assess11" value="${sumPrice_assess11 + vo.price_assess11}" />
								<c:set var="sumPrice_assess10" value="${sumPrice_assess10 + vo.price_assess10}" />
								<c:set var="sumPrice_assess9" value="${sumPrice_assess9 + vo.price_assess9}" />
								<c:set var="sumPrice_assess8" value="${sumPrice_assess8 + vo.price_assess8}" />
								<c:set var="sumPrice_assess7" value="${sumPrice_assess7 + vo.price_assess7}" />
								<c:set var="sumPrice_assess6" value="${sumPrice_assess6 + vo.price_assess6}" />
								<c:set var="sumPrice_assess5" value="${sumPrice_assess5 + vo.price_assess5}" />
								<c:set var="sumPrice_assess4" value="${sumPrice_assess4 + vo.price_assess4}" />
								<c:set var="sumPrice_assess3" value="${sumPrice_assess3 + vo.price_assess3}" />
								<c:set var="sumPrice_assess2" value="${sumPrice_assess2 + vo.price_assess2}" />
								<c:set var="sumPrice_assess" value="${sumPrice_assess + vo.price_assess}" />
								<c:set var="sumPrice_assess_sum" value="${sumPrice_assess_sum + vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" />
							</c:forEach>
						<tr bgcolor="#E7ECF1">
							<td colspan="2">1종 소계</td>
							<td><fmt:formatNumber value="${sumPrice_assess12}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess11}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess10}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess9}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess8}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess7}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess6}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess5}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess4}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess3}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess2}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess_sum}" pattern="#,##0"/></td>
						</tr>
						<c:forEach var="vo" items="${MisEndTmAssess4}" varStatus="status">
							<tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
								onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
			                	onclick="goMisEndTmAssessMbr('${srchArg.stdBgnde}','${srchArg.stdEndde}','${vo.team_id}','${vo.team_type}');" >
			                	
								<c:if test="${status.index == 0}">
									<td rowspan="${MisEndTmAssess4.size() + 1}">4종</td>
								</c:if>
								<td>${vo.center_name}</td>
								<td>${vo.team_name}</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess12}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess11}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess10}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess9}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess8}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess7}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess6}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess5}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess4}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess3}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess2}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess}" pattern="#,##0"/><br>
								</td>
								<td>
									<fmt:formatNumber value="${vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" pattern="#,##0"/>
								</td>
							</tr>
								<c:set var="sumPrice4_assess12" value="${sumPrice4_assess12 + vo.price_assess12}" />
								<c:set var="sumPrice4_assess11" value="${sumPrice4_assess11 + vo.price_assess11}" />
								<c:set var="sumPrice4_assess10" value="${sumPrice4_assess10 + vo.price_assess10}" />
								<c:set var="sumPrice4_assess9" value="${sumPrice4_assess9 + vo.price_assess9}" />
								<c:set var="sumPrice4_assess8" value="${sumPrice4_assess8 + vo.price_assess8}" />
								<c:set var="sumPrice4_assess7" value="${sumPrice4_assess7 + vo.price_assess7}" />
								<c:set var="sumPrice4_assess6" value="${sumPrice4_assess6 + vo.price_assess6}" />
								<c:set var="sumPrice4_assess5" value="${sumPrice4_assess5 + vo.price_assess5}" />
								<c:set var="sumPrice4_assess4" value="${sumPrice4_assess4 + vo.price_assess4}" />
								<c:set var="sumPrice4_assess3" value="${sumPrice4_assess3 + vo.price_assess3}" />
								<c:set var="sumPrice4_assess2" value="${sumPrice4_assess2 + vo.price_assess2}" />
								<c:set var="sumPrice4_assess" value="${sumPrice4_assess + vo.price_assess}" />
								<c:set var="sumPrice4_assess_sum" value="${sumPrice4_assess_sum + vo.price_assess12+vo.price_assess11+vo.price_assess10+vo.price_assess9+vo.price_assess8+vo.price_assess7+vo.price_assess6+vo.price_assess5+vo.price_assess4+vo.price_assess3+vo.price_assess2+vo.price_assess}" />
							</c:forEach>
						<tr bgcolor="#E7ECF1">
							<td colspan="2">4종 소계</td>
							<td><fmt:formatNumber value="${sumPrice4_assess12}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess11}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess10}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess9}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess8}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess7}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess6}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess5}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess4}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess3}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess2}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice4_assess_sum}" pattern="#,##0"/></td>
						</tr>
						<tr bgcolor="#E7ECF1">
							<td colspan="3">합계</td>
							<td><fmt:formatNumber value="${sumPrice_assess12 + sumPrice4_assess12}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess11 + sumPrice4_assess11}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess10 + sumPrice4_assess10}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess9 + sumPrice4_assess9}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess8 + sumPrice4_assess8}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess7 + sumPrice4_assess7}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess6 + sumPrice4_assess6}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess5 + sumPrice4_assess5}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess4 + sumPrice4_assess4}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess3 + sumPrice4_assess3}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess2 + sumPrice4_assess2}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess + sumPrice4_assess}" pattern="#,##0"/></td>
							<td><fmt:formatNumber value="${sumPrice_assess_sum + sumPrice4_assess_sum}" pattern="#,##0"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
