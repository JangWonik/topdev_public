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
											<th>대중교통비</th>
											<th>유류대</th>
											<th>주차비</th>
											<th>통행료</th>
											<th>숙박비</th>
											<th>회식대</th>
											<th>식대</th>
											<th>업무협의비</th>
											<th>물품구입비</th>
											<th>우편요금</th>
											<th>통신료</th>
											<th>문서발급비</th>
											<th>수도광열비</th>
											<th>합계</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="vo" items="${getTCStmMbr}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<c:if test="${status.index == 0}">
												<td rowspan="${getTCStmMbr.size()}">${vo.team_name}</td>
											</c:if>
											<td><p>${vo.user_name}</p></td>
											<td><fmt:formatNumber value="${vo.cash11 + vo.card11}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash21 + vo.card21}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash31 + vo.card31}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash41 + vo.card41}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash51 + vo.card51}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash61 + vo.card61}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash71 + vo.card71}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash81 + vo.card81}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash91 + vo.card91}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash101 + vo.card101}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash111 + vo.card111}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash121 + vo.card121}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cash131 + vo.card131}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.cashSum + vo.cardSum}" pattern="#,##0.##"/></td>
												<c:set var="sum0_cash11" value="${sum0_cash11 + vo.cash11}" />
												<c:set var="sum0_cash21" value="${sum0_cash21 + vo.cash21}" />
												<c:set var="sum0_cash31" value="${sum0_cash31 + vo.cash31}" />
												<c:set var="sum0_cash41" value="${sum0_cash41 + vo.cash41}" />
												<c:set var="sum0_cash51" value="${sum0_cash51 + vo.cash51}" />
												<c:set var="sum0_cash61" value="${sum0_cash61 + vo.cash61}" />
												<c:set var="sum0_cash71" value="${sum0_cash71 + vo.cash71}" />
												<c:set var="sum0_cash81" value="${sum0_cash81 + vo.cash81}" />
												<c:set var="sum0_cash91" value="${sum0_cash91 + vo.cash91}" />
												<c:set var="sum0_cash101" value="${sum0_cash101 + vo.cash101}" />
												<c:set var="sum0_cash111" value="${sum0_cash111 + vo.cash111}" />
												<c:set var="sum0_cash121" value="${sum0_cash121 + vo.cash121}" />
												<c:set var="sum0_cash131" value="${sum0_cash131 + vo.cash131}" />
												<c:set var="sum0_cashSum" value="${sum0_cashSum + vo.cashSum}" />
												<c:set var="sum0_card11" value="${sum0_card11 + vo.card11}" />
												<c:set var="sum0_card21" value="${sum0_card21 + vo.card21}" />
												<c:set var="sum0_card31" value="${sum0_card31 + vo.card31}" />
												<c:set var="sum0_card41" value="${sum0_card41 + vo.card41}" />
												<c:set var="sum0_card51" value="${sum0_card51 + vo.card51}" />
												<c:set var="sum0_card61" value="${sum0_card61 + vo.card61}" />
												<c:set var="sum0_card71" value="${sum0_card71 + vo.card71}" />
												<c:set var="sum0_card81" value="${sum0_card81 + vo.card81}" />
												<c:set var="sum0_card91" value="${sum0_card91 + vo.card91}" />
												<c:set var="sum0_card101" value="${sum0_card101 + vo.card101}" />
												<c:set var="sum0_card111" value="${sum0_card111 + vo.card111}" />
												<c:set var="sum0_card121" value="${sum0_card121 + vo.card121}" />
												<c:set var="sum0_card131" value="${sum0_card131 + vo.card131}" />
												<c:set var="sum0_cardSum" value="${sum0_cardSum + vo.cardSum}" />
										</tr>
										</c:forEach>
										<tr bgcolor="#E7ECF1">
											<td colspan="2">카드</td>
											<td><fmt:formatNumber value="${sum0_card11}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card21}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card31}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card41}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card51}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card61}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card71}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card81}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card91}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card101}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card111}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card121}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_card131}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cardSum}" pattern="#,##0.##"/></td>
										</tr>
										<tr bgcolor="#E7ECF1">
											<td colspan="2">현금</td>
											<td><fmt:formatNumber value="${sum0_cash11}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash21}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash31}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash41}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash51}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash61}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash71}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash81}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash91}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash101}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash111}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash121}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash131}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cashSum}" pattern="#,##0.##"/></td>
										</tr>
										<tr bgcolor="#E7ECF1">
											<td colspan="2">소계</td>
											<td><fmt:formatNumber value="${sum0_cash11+sum0_card11}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash21+sum0_card21}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash31+sum0_card31}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash41+sum0_card41}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash51+sum0_card51}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash61+sum0_card61}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash71+sum0_card71}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash81+sum0_card81}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash91+sum0_card91}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash101+sum0_card101}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash111+sum0_card111}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash121+sum0_card121}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cash131+sum0_card131}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sum0_cashSum+sum0_cardSum}" pattern="#,##0.##"/></td>
										</tr>
									</tbody>
								</table>
							</div>
