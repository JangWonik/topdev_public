<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							<div class="tableStyle2" id="dataTable">
								<table cellpadding="0" cellspacing="0" summary="팀 기본통계 1종">
								<caption>팀 기본통계</caption>
									<thead>
										<tr align="center" bgcolor="#EFEFEF">
											<td nowrap rowspan="3"><B>이름</B></td>
											<td nowrap colspan="7">공동수행자의 비율 및 금액을 반영한 결과<B><font color="red">(반영안함!)</font></b></td>
											<td nowrap colspan="7">공동수행자의 비율 및 금액을 반영한 결과<B><font color="red">(반영안함!)</font></b></td>
										</tr>
										<tr align="center" bgcolor="#EFEFEF">
											<td nowrap colspan="7">농작물,적부등 인보이스 현황<font color="red">(당월)</font></td>
											<td nowrap colspan="7">수임대장 + 농작물,적부등 인보이스 현황<font color="red">(당월)</font></td>
										</tr>
										<tr align="center" bgcolor="#EFEFEF">
											<td nowrap>기본료</td>
											<td nowrap>일비</td>
											<td nowrap>소계(기본+일)</td>
											<td nowrap>교통비</td>
											<td nowrap>자문료</td>
											<td nowrap>기타</td>
											<td nowrap>합계</td>
											<td nowrap>기본료</td>
											<td nowrap>일비</td>
											<td nowrap>소계(기본+일)</td>
											<td nowrap>교통비</td>
											<td nowrap>자문료</td>
											<td nowrap>기타</td>
											<td nowrap>합계</td>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="vo" items="${getMisTmBscMbr}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td>${vo.user_name}</td>
											<td><fmt:formatNumber value="${vo.price_assess_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_time_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_little_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_traffic_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_question_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_receipt_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_hap_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_assess+vo.price_assess_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_time+vo.price_time_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_little+vo.price_sum_little_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_traffic+vo.price_traffic_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_question+vo.price_question_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_receipt+vo.price_receipt_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_hap+vo.price_sum_hap_nsc}" pattern="#,##0.##"/></td>
												<c:set var="sumPrice_assess_nsc" value="${vo.price_assess_nsc + sumPrice_assess_nsc}" />
												<c:set var="sumPrice_time_nsc" value="${vo.price_time_nsc + sumPrice_time_nsc}" />
												<c:set var="sumPrice_sum_little_nsc" value="${vo.price_sum_little_nsc + sumPrice_sum_little_nsc}" />
												<c:set var="sumPrice_traffic_nsc" value="${vo.price_traffic_nsc + sumPrice_traffic_nsc}" />
												<c:set var="sumPrice_question_nsc" value="${vo.price_question_nsc + sumPrice_question_nsc}" />
												<c:set var="sumPrice_receipt_nsc" value="${vo.price_receipt_nsc + sumPrice_receipt_nsc}" />
												<c:set var="sumPrice_sum_hap_nsc" value="${vo.price_sum_hap_nsc + sumPrice_sum_hap_nsc}" />
												<c:set var="sumPrice_assess" value="${vo.price_assess+vo.price_assess_nsc + sumPrice_assess}" />
												<c:set var="sumPrice_time" value="${vo.price_time+vo.price_time_nsc + sumPrice_time}" />
												<c:set var="sumPrice_sum_little" value="${vo.price_sum_little+vo.price_sum_little_nsc + sumPrice_sum_little}" />
												<c:set var="sumPrice_traffic" value="${vo.price_traffic+vo.price_traffic_nsc + sumPrice_traffic}" />
												<c:set var="sumPrice_question" value="${vo.price_question+vo.price_question_nsc + sumPrice_question}" />
												<c:set var="sumPrice_receipt" value="${vo.price_receipt+vo.price_receipt_nsc + sumPrice_receipt}" />
												<c:set var="sumPrice_sum_hap" value="${vo.price_sum_hap+vo.price_sum_hap_nsc + sumPrice_sum_hap}" />
										</tr>
										</c:forEach>
										<tr bgcolor="#E7ECF1">
											<td>합계</td>
											<td><fmt:formatNumber value="${sumPrice_assess_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_time_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_little_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_traffic_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_question_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_receipt_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_hap_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_assess}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_time}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_little}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_traffic}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_question}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_receipt}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_hap}" pattern="#,##0.##"/></td>
										</tr>
									</tbody>
								</table>
							</div>
