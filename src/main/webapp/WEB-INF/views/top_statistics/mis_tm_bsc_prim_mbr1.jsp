<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							<div class="tableStyle2" id="dataTable">
								<table cellpadding="0" cellspacing="0" summary="팀 기본통계 1종">
								<caption>팀 기본통계</caption>
									<thead>
										<tr>
											<td class="td" bgcolor="#EFEFEF" rowspan="4" nowrap>
												<p align="center"><B><font color="black">이름</font></B></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" colspan="10" nowrap>
												<p align="center"><font color="black">공동수행자의 비율 및 금액을 반영한 결과</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="4" nowrap>
												<p align="center"><font color="black">미수금</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" colspan="10" nowrap>
												<p align="center"><font color="black">공동수행자의 비율 및 금액을 반영한 결과</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="4" nowrap>
												<p align="center"><font color="black">미수금</font></p>
											</td>
										</tr>
										<tr>
											<td class="td" bgcolor="#EFEFEF" colspan="10" nowrap>
												<p align="center"><font color="black">농작물,적부등 인보이스 현황</font><font color="red">(당월)</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" colspan="10" nowrap>
												<p align="center"><font color="black">수임대장 + 농작물,적부등 인보이스 현황</font><font color="red">(당월)</font></p>
											</td>
										</tr>
										<tr>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center">평가건</p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">기본료</font>&nbsp;</p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">일비</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" nowrap colspan="2">
												<p align="center"><font color="black">공동수행</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black"><b>소계</b></font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">교통비</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">자문료</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">기타</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black"><b>합계</b></font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">평가건</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">기본료</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">일비</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" colspan="2" nowrap>
												<p align="center"><font color="black">공동수행</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black"><b>소계</b></font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">교통비</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">자문료</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black">기타</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" rowspan="2" nowrap>
												<p align="center"><font color="black"><b>합계</b></font></p>
											</td>
										</tr>
										<tr>
											<td class="td" bgcolor="#EFEFEF" nowrap>
												<p align="center"><font color="black">기본료</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" nowrap>
												<p align="center"><font color="black">일비</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" nowrap>
												<p align="center"><font color="black">기본료</font></p>
											</td>
											<td class="td" bgcolor="#EFEFEF" nowrap>
												<p align="center"><font color="black">일비</font></p>
											</td>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="vo" items="${getMisTmBscMbr}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td>${vo.user_name}</td>
											<td><fmt:formatNumber value="${vo.ea_sum_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_assess_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_time_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.p_price_a_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.p_price_b_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_little_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_traffic_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_question_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_receipt_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_hap_nsc}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${vo.no_settle_nsc}" pattern="#,##0.##"/></font></td>
											<td><fmt:formatNumber value="${vo.ea_sum+vo.ea_sum_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_assess+vo.price_assess_nsc}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_time+vo.price_time_nsc}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.p_price_a+vo.p_price_a_nsc}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.p_price_b+vo.p_price_b_nsc}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_little+vo.price_sum_little_nsc}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_traffic+vo.price_traffic_nsc}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_question+vo.price_question_nsc}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_receipt+vo.price_receipt_nsc}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_hap+vo.price_sum_hap_nsc}" pattern="#,###"/></td>
											<td><font color="red"><fmt:formatNumber value="${vo.no_settle+vo.no_settle_nsc}" pattern="#,###"/></font></td>
												<c:set var="sumEa_sum_nsc" value="${vo.ea_sum_nsc + sumEa_sum_nsc}" />
												<c:set var="sumPrice_assess_nsc" value="${vo.price_assess_nsc + sumPrice_assess_nsc}" />
												<c:set var="sumPrice_time_nsc" value="${vo.price_time_nsc + sumPrice_time_nsc}" />
												<c:set var="sumP_price_a_nsc" value="${vo.p_price_a_nsc + sumP_price_a_nsc}" />
												<c:set var="sumP_price_b_nsc" value="${vo.p_price_b_nsc + sumP_price_b_nsc}" />
												<c:set var="sumPrice_sum_little_nsc" value="${vo.price_sum_little_nsc + sumPrice_sum_little_nsc}" />
												<c:set var="sumPrice_traffic_nsc" value="${vo.price_traffic_nsc + sumPrice_traffic_nsc}" />
												<c:set var="sumPrice_question_nsc" value="${vo.price_question_nsc + sumPrice_question_nsc}" />
												<c:set var="sumPrice_receipt_nsc" value="${vo.price_receipt_nsc + sumPrice_receipt_nsc}" />
												<c:set var="sumPrice_sum_hap_nsc" value="${vo.price_sum_hap_nsc + sumPrice_sum_hap_nsc}" />
												<c:set var="sumNo_settle_nsc" value="${vo.no_settle_nsc + sumNo_settle_nsc}" />
												<c:set var="sumEa_sum" value="${vo.ea_sum+vo.ea_sum_nsc + sumEa_sum}" />
												<c:set var="sumPrice_assess" value="${vo.price_assess+vo.price_assess_nsc + sumPrice_assess}" />
												<c:set var="sumPrice_time" value="${vo.price_time+vo.price_time_nsc + sumPrice_time}" />
												<c:set var="sumP_price_a" value="${vo.p_price_a+vo.p_price_a_nsc + sumP_price_a}" />
												<c:set var="sumP_price_b" value="${vo.p_price_b+vo.p_price_b_nsc + sumP_price_b}" />
												<c:set var="sumPrice_sum_little" value="${vo.price_sum_little+vo.price_sum_little_nsc + sumPrice_sum_little}" />
												<c:set var="sumPrice_traffic" value="${vo.price_traffic+vo.price_traffic_nsc + sumPrice_traffic}" />
												<c:set var="sumPrice_question" value="${vo.price_question+vo.price_question_nsc + sumPrice_question}" />
												<c:set var="sumPrice_receipt" value="${vo.price_receipt+vo.price_receipt_nsc + sumPrice_receipt}" />
												<c:set var="sumPrice_sum_hap" value="${vo.price_sum_hap+vo.price_sum_hap_nsc + sumPrice_sum_hap}" />
												<c:set var="sumNo_settle" value="${vo.no_settle+vo.no_settle_nsc + sumNo_settle}" />
										</tr>
										</c:forEach>
										<tr bgcolor="#E7ECF1">
											<td>합계</td>
											<td><fmt:formatNumber value="${sumEa_sum_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_assess_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_time_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumP_price_a_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumP_price_b_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_little_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_traffic_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_question_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_receipt_nsc}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_hap_nsc}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${sumNo_settle_nsc}" pattern="#,##0.##"/></font></td>
											<td><fmt:formatNumber value="${sumEa_sum}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_assess}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${sumPrice_time}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${sumP_price_a}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${sumP_price_b}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_little}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${sumPrice_traffic}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${sumPrice_question}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${sumPrice_receipt}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_hap}" pattern="#,###"/></td>
											<td><font color="red"><fmt:formatNumber value="${sumNo_settle}" pattern="#,###"/></font></td>
										</tr>
									</tbody>
								</table>
							</div>
