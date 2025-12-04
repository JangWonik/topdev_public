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
									<thead>
										<tr align="center" bgcolor="#EFEFEF">
											<td class="td" nowrap rowspan="3"><B>이름</B></td>
											<td class="td" nowrap rowspan="2" colspan="2"><B>수임현황</B></td>
											<td class="td" nowrap colspan="6">종결현황</td>
											<td class="td" nowrap rowspan="3">미결현황</td>
											<td class="td" nowrap colspan="5">지급</td>
										</tr>
										<tr align="center" bgcolor="#EFEFEF">
											<td class="td" nowrap colspan="2">조사 완료</td>
											<td class="td" nowrap colspan="2">조사 실패</td>
											<td class="td" nowrap colspan="2">합계</td>
											<td class="td" nowrap colspan="2">심사후</td>
											<td class="td" nowrap colspan="2">심사전</td>
											<td class="td" nowrap rowspan="2">합계</td>
										</tr>
										<tr align="center" bgcolor="#EFEFEF">
											<td class="td" nowrap>당월</td>
											<td class="td" nowrap>년누계</td>
											<td class="td" nowrap>당월</td>
											<td class="td" nowrap>년누계</td>
											<td class="td" nowrap>당월</td>
											<td class="td" nowrap>년누계</td>
											<td class="td" nowrap>당월</td>
											<td class="td" nowrap>년누계</td>
											<td class="td" nowrap>일반</td>
											<td class="td" nowrap>공장</td>
											<td class="td" nowrap>일반</td>
											<td class="td" nowrap>공장</td>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="vo" items="${getMisSuitability17TmMbr}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><p><a href="javascript:goMisSuitability17TmMbr2('${vo.team_id}','${vo.team_name}','${vo.team_type}','${vo.user_no}','${vo.user_name}');">${vo.user_name}</a></p></td>
											<td><fmt:formatNumber value="${vo.reg_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.reg_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_m_fail}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_y_fail}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_sum_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_sum_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_mi}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_a}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_b}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_c}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_d}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.price_sum}" pattern="#,##0.##"/></td>
											
												<c:set var="sumReg_m1" value="${vo.reg_m + sumReg_m1}" />
												<c:set var="sumReg_y1" value="${vo.reg_y + sumReg_y1}" />
												<c:set var="sumEnd_m1" value="${vo.end_m + sumEnd_m1}" />
												<c:set var="sumEnd_y1" value="${vo.end_y + sumEnd_y1}" />
												<c:set var="sumEnd_m_fail1" value="${vo.end_m_fail + sumEnd_m_fail1}" />
												<c:set var="sumEnd_y_fail1" value="${vo.end_y_fail + sumEnd_y_fail1}" />
												<c:set var="sumEnd_sum_m1" value="${vo.end_sum_m + sumEnd_sum_m1}" />
												<c:set var="sumEnd_sum_y1" value="${vo.end_sum_y + sumEnd_sum_y1}" />
												<c:set var="sumEnd_mi1" value="${vo.end_mi + sumEnd_mi1}" />
												<c:set var="sumPrice_a1" value="${vo.price_a + sumPrice_a1}" />
												<c:set var="sumPrice_b1" value="${vo.price_b + sumPrice_b1}" />
												<c:set var="sumPrice_c1" value="${vo.price_c + sumPrice_c1}" />
												<c:set var="sumPrice_d1" value="${vo.price_d + sumPrice_d1}" />
												<c:set var="sumPrice_sum1" value="${vo.price_sum + sumPrice_sum1}" />
										</tr>
										</c:forEach>
										<tr bgcolor="#E7ECF1">
											<td><b>합계</b></td>
											<td><fmt:formatNumber value="${sumReg_m1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumReg_y1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_m1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_y1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_m_fail1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_y_fail1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_sum_m1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_sum_y1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_mi1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_a1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_b1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_c1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_d1}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum1}" pattern="#,##0.##"/></td>
										</tr>
									</tbody>
								</table>
							</div>
