<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							<div class="tableStyle2" id="dataTable">
								<table cellpadding="0" cellspacing="0" summary="팀 기본통계 1종">
									<caption>팀 기본통계</caption>
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
											<th>팀명</th>
											<th>이름</th>
											<th>유류대</th>
											<th>통행료</th>
											<th>대중교통비</th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th>합계</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="vo" items="${getTCStmMbrClaim}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<c:if test="${status.index == 0}">
												<td rowspan="${getTCStmMbrClaim.size()}">${vo.team_name}</td>
											</c:if>
											<td><p>${vo.user_name}</p></td>
											<td><fmt:formatNumber value="${vo.cash11 + vo.card11}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash21 + vo.card21}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash31 + vo.card31}" pattern="#,##0.##"/></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td><fmt:formatNumber value="${vo.cashSum + vo.cardSum}" pattern="#,##0.##"/></td>
												<c:set var="sum0_cash11" value="${sum0_cash11 + vo.cash11}" />
												<c:set var="sum0_cash21" value="${sum0_cash21 + vo.cash21}" />
												<c:set var="sum0_cash31" value="${sum0_cash31 + vo.cash31}" />
												<c:set var="sum0_cashSum" value="${sum0_cashSum + vo.cashSum}" />
												<c:set var="sum0_card11" value="${sum0_card11 + vo.card11}" />
												<c:set var="sum0_card21" value="${sum0_card21 + vo.card21}" />
												<c:set var="sum0_card31" value="${sum0_card31 + vo.card31}" />
												<c:set var="sum0_cardSum" value="${sum0_cardSum + vo.cardSum}" />
										</tr>
										</c:forEach>
										<tr bgcolor="#E7ECF1">
											<td colspan="2">카드</td>
											<td><fmt:formatNumber value="${sum0_card11}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card21}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card31}" pattern="#,##0.##"/></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td><fmt:formatNumber value="${sum0_cardSum}" pattern="#,##0.##"/></td>
										</tr>
										<tr bgcolor="#E7ECF1">
											<td colspan="2">현금</td>
											<td><fmt:formatNumber value="${sum0_cash11}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash21}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash31}" pattern="#,##0.##"/></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td><fmt:formatNumber value="${sum0_cashSum}" pattern="#,##0.##"/></td>
										</tr>
										<tr bgcolor="#E7ECF1">
											<td colspan="2">소계</td>
											<td><fmt:formatNumber value="${sum0_cash11+sum0_card11}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash21+sum0_card21}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash31+sum0_card31}" pattern="#,##0.##"/></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td><fmt:formatNumber value="${sum0_cashSum+sum0_cardSum}" pattern="#,##0.##"/></td>
										</tr>
									</tbody>
								</table>
							</div>
