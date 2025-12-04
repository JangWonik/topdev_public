<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							<div class="tableStyle2" id="dataTable">
								<table cellpadding="0" cellspacing="0" summary="팀&개인 기본통계">
									<caption>팀&개인 기본통계</caption>
									<colgroup>
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
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">						
									</colgroup>
									<thead>
										<!-- 항목 시작 -->
										<tr style="bgcolor: #E7ECF1; text-align: center;" >						                  
						                    <td class="td" bgcolor="#E7ECF1" rowspan="4">
						                        <p align="center"><B>이름</B></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="2">
						                        <p align="center"><B>수임현황</B></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="2">
						                        <p align="center"><B>종결현황</B></p>
						                    </td>
											<td class="td" colspan="2" bgcolor="#E7ECF1" rowspan="2">
						                        <p align="center"><b>처리율(%)</b></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="2">
						           			    <p align="center"><B>미결현황</B></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="2">
						              	        <p align="center"><B>종결평가</B></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="9">
						         				<p align="center"><b>공동수행자의 비율 및 금액을 반영한 결과</b></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" rowspan="4">
						           				<p align="center"><B>미수금</B></p>
						                    </td>
						                </tr>
						                <tr>
											<td class="td" bgcolor="#E7ECF1" colspan="2">
						           			    <p align="center"><B>절대건수</B></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="2">
						         				<p align="center"><B>절대건수</B></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="2">
						          				<p align="center"><B>절대건수</B></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="2">
						           				<p align="center"><B>평가건수</B></p>
						                    </td>
											<td class="td" bgcolor="#E7ECF1" colspan="9">
						         				<p align="center"><B>인보이스 현황<font color="red">(당월)</font></B></p>
						                    </td>
						                </tr>
										<tr align="center">											
											<td class="td" bgcolor="#E7ECF1" rowspan="2">당월</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">년누계</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">당월</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">년누계</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">당월</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">년누계</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">현재</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">30,15</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">당월</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">공동적용</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">기본료</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">일비</td>
											<td class="td" bgcolor="#E7ECF1" colspan="2" align="center">공동수행</td>									
											<td class="td" bgcolor="#E7ECF1" rowspan="2"><b>소계</b></td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">교통비</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">자문료</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">기타</td>
											<td class="td" bgcolor="#E7ECF1" rowspan="2">합계</td>
										</tr>
										<tr>
											<td class="td" bgcolor="#E7ECF1">기본료</td>
											<td class="td" bgcolor="#E7ECF1">일비</td>
										</tr>
										<!-- 항목 끝 -->
									</thead>
									<!-- 개인별 조회 결과 시작 -->
									<tbody>
									<c:forEach var="vo" items="${getMisTmBscMbr}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><a href="javascript:goMisTmBscMbr2('${vo.user_no}','${vo.user_name}');"><c:out value="${vo.user_name}" /></a></td>
											<td><fmt:formatNumber value="${vo.reg_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.reg_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.end_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.proc_m}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.proc_y}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.nend_p}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.nend_30r}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.ea_sum}" pattern="#,##0.###"/></td>
											<td><fmt:formatNumber value="${vo.report_ea}" pattern="#,##0.###"/></td>
											<td><fmt:formatNumber value="${vo.price_assess}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_time}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.p_price_a}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.p_price_b}" pattern="#,###"/></td>				
											<td><fmt:formatNumber value="${vo.price_sum_little}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_traffic}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_question}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_receipt}" pattern="#,###"/></td>
											<td><fmt:formatNumber value="${vo.price_sum_hap}" pattern="#,###"/></td>
											<td><font color="red"><fmt:formatNumber value="${vo.no_settle}" pattern="#,###"/></font></td>
											<c:set var="sumReg_m" value="${vo.reg_m + sumReg_m}" />
											<c:set var="sumReg_y" value="${vo.reg_y + sumReg_y}" />
											<c:set var="sumEnd_m" value="${vo.end_m + sumEnd_m}" />
											<c:set var="sumEnd_y" value="${vo.end_y + sumEnd_y}" />
											<c:set var="sumProc_m" value="${vo.proc_m + sumProc_m}" />
											<c:set var="sumProc_y" value="${vo.proc_y + sumProc_y}" />
											<c:set var="sumNend_p" value="${vo.nend_p + sumNend_p}" />
											<c:set var="sumNend_30" value="${vo.nend_30 + sumNend_30}" />
											<c:set var="sumNend_30r" value="${vo.nend_30r + sumNend_30r}" />
											<c:set var="sumEa_sum" value="${vo.ea_sum + sumEa_sum}" />
											<c:set var="sumReport_ea" value="${vo.report_ea + sumReport_ea}" />
											<c:set var="sumPrice_assess" value="${vo.price_assess + sumPrice_assess}" />
											<c:set var="sumPrice_time" value="${vo.price_time + sumPrice_time}" />
											<c:set var="sumP_price_a" value="${vo.p_price_a + sumP_price_a}" />
											<c:set var="sumP_price_b" value="${vo.p_price_b + sumP_price_b}" />
											<c:set var="sumPrice_sum_little" value="${vo.price_sum_little + sumPrice_sum_little}" />
											<c:set var="sumPrice_traffic" value="${vo.price_traffic + sumPrice_traffic}" />
											<c:set var="sumPrice_question" value="${vo.price_question + sumPrice_question}" />
											<c:set var="sumPrice_receipt" value="${vo.price_receipt + sumPrice_receipt}" />
											<c:set var="sumPrice_sum_hap" value="${vo.price_sum_hap + sumPrice_sum_hap}" />
											<c:set var="sumNo_settle" value="${vo.no_settle + sumNo_settle}" />
										</tr>
									</c:forEach>
										<tr bgcolor="#E7ECF1">
											<td>합계</td>
											<td><fmt:formatNumber value="${sumReg_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumReg_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_y}" pattern="#,##0.##"/></td>
											
<%-- 										<td><fmt:formatNumber value="${sumProc_m}" pattern="#,##0.##"/>%</td> --%>
<%-- 										<td><fmt:formatNumber value="${sumProc_y}" pattern="#,##0.##"/>%</td> --%>
											<td>
												<c:choose>
													<c:when test="${sumEnd_m != 0}">
														<fmt:formatNumber value="${sumEnd_m/sumReg_m*100}" pattern="#,##0.##"/>%
													</c:when>
													<c:otherwise>
														0%
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${sumEnd_y != 0}">
														<fmt:formatNumber value="${sumEnd_y/sumReg_y*100}" pattern="#,##0.##"/>%
													</c:when>
													<c:otherwise>
														0%
													</c:otherwise>
												</c:choose>
											</td>
											
											<td><fmt:formatNumber value="${sumNend_p}" pattern="#,##0.##"/></td>
											
<%-- 										<td><fmt:formatNumber value="${sumNend_30r}" pattern="#,##0.##"/>%</td> --%>
											<td>
												<c:choose>
													<c:when test="${sumNend_30 != 0}">
														<fmt:formatNumber value="${sumNend_30/sumNend_p*100}" pattern="#,##0.##"/>%
													</c:when>
													<c:otherwise>
														0%
													</c:otherwise>
												</c:choose>
											</td>
											
											<td><fmt:formatNumber value="${sumEa_sum}" pattern="#,##0.###"/></td>
											<td><fmt:formatNumber value="${sumReport_ea}" pattern="#,##0.###"/></td>
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
									<!-- 개인별 조회 결과 끝 -->			
								</table>
							</div>
