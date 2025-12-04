<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="팀 기본통계 1종" id="dataTable">
									<caption>팀 기본통계</caption>
									<colgroup>
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
										<col width="65">
										<col width="65">
										<col width="65">
										<col width="65">
									</colgroup>
									<thead>
									<tr style="bgcolor: #E7ECF1;">
					                    <td class="td" bgcolor="#E7ECF1" rowspan="3">
					                        <p align="center"><B>팀명</B></p>
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
										<td class="td" bgcolor="#E7ECF1" colspan="7">
					         				<p align="center"><b>공동수행자의 비율 및 금액을 반영한 결과<font color="red">(반영안함!)</font></b></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" rowspan="3">
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
										<td class="td" bgcolor="#E7ECF1" colspan="7">
					         				<p align="center"><B>인보이스 현황<font color="red"><B>(당월)</B></font></p>
					                    </td>
					                </tr>
										<tr>
											<th>당월</th>
											<th>년누계</th>
											<th>당월</th>
											<th>년누계</th>
											<th>당월</th>
											<th>년누계</th>
											<th>현재</th>
											<th>30,15</th>
											<th>당월</th>
											<th>년누계</th>
											<th>기본료</th>
											<th>일비</th>
											<th>소계<br />(기본+일)</th>
											<th>교통비</th>
											<th>자문료</th>
											<th>기타</th>
											<th>합계</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="vo" items="${getMisTmBsc4}" varStatus="status">
												<c:set var="reg_m" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="reg_m" value="${reg_m + vo.getReg_m()}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="reg_m" value="${getMisTmBscPrim4.get(status.index).getReg_m()+reg_m}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="reg_m" value="${getMisTmBscPrimContract4.get(status.index).getReg_m()+reg_m}" /></c:if>
												<c:set var="reg_y" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="reg_y" value="${vo.getReg_y()+reg_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="reg_y" value="${getMisTmBscPrim4.get(status.index).getReg_y()+reg_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="reg_y" value="${getMisTmBscPrimContract4.get(status.index).getReg_y()+reg_y}" /></c:if>
												<c:set var="end_m" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="end_m" value="${vo.getEnd_m()+end_m}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="end_m" value="${getMisTmBscPrim4.get(status.index).getEnd_m()+end_m}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="end_m" value="${getMisTmBscPrimContract4.get(status.index).getEnd_m()+end_m}" /></c:if>
												<c:set var="end_y" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="end_y" value="${vo.getEnd_y()+end_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="end_y" value="${getMisTmBscPrim4.get(status.index).getEnd_y()+end_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="end_y" value="${getMisTmBscPrimContract4.get(status.index).getEnd_y()+end_y}" /></c:if>
												<c:set var="proc_m" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="proc_m" value="${vo.getProc_m()+proc_m}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="proc_m" value="${getMisTmBscPrim4.get(status.index).getProc_m()+proc_m}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="proc_m" value="${getMisTmBscPrimContract4.get(status.index).getProc_m()+proc_m}" /></c:if>
												<c:set var="proc_y" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="proc_y" value="${vo.getProc_y()+proc_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="proc_y" value="${getMisTmBscPrim4.get(status.index).getProc_y()+proc_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="proc_y" value="${getMisTmBscPrimContract4.get(status.index).getProc_y()+proc_y}" /></c:if>
												<c:set var="nend_p" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="nend_p" value="${vo.getNend_p()+nend_p}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="nend_p" value="${getMisTmBscPrim4.get(status.index).getNend_p()+nend_p}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="nend_p" value="${getMisTmBscPrimContract4.get(status.index).getNend_p()+nend_p}" /></c:if>
												<c:set var="nend_30r" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="reg_y" value="${vo.getNend_30r()+reg_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="reg_y" value="${getMisTmBscPrim4.get(status.index).getNend_30r()+reg_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="reg_y" value="${getMisTmBscPrimContract4.get(status.index).getNend_30r()+reg_y}" /></c:if>
												<c:set var="endea_m" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="endea_m" value="${vo.getEndea_m()+endea_m}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="endea_m" value="${getMisTmBscPrim4.get(status.index).getEndea_m()+endea_m}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="endea_m" value="${getMisTmBscPrimContract4.get(status.index).getEndea_m()+endea_m}" /></c:if>
												<c:set var="endea_y" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="endea_y" value="${vo.getEndea_y()+endea_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="endea_y" value="${getMisTmBscPrim4.get(status.index).getEndea_y()+endea_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="endea_y" value="${getMisTmBscPrimContract4.get(status.index).getEndea_y()+endea_y}" /></c:if>
												<c:set var="price_assess" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_assess" value="${vo.getPrice_assess()+price_assess}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_assess" value="${getMisTmBscPrim4.get(status.index).getPrice_assess()+price_assess}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_assess" value="${getMisTmBscPrimContract4.get(status.index).getPrice_assess()+price_assess}" /></c:if>
												<c:set var="price_time" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_time" value="${vo.getPrice_time()+price_time}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_time" value="${getMisTmBscPrim4.get(status.index).getPrice_time()+price_time}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_time" value="${getMisTmBscPrimContract4.get(status.index).getPrice_time()+price_time}" /></c:if>
												<c:set var="price_sum_little" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_sum_little" value="${vo.getPrice_sum_little()+price_sum_little}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_sum_little" value="${getMisTmBscPrim4.get(status.index).getPrice_sum_little()+price_sum_little}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_sum_little" value="${getMisTmBscPrimContract4.get(status.index).getPrice_sum_little()+price_sum_little}" /></c:if>
												<c:set var="price_traffic" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_traffic" value="${vo.getPrice_traffic()+price_traffic}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_traffic" value="${getMisTmBscPrim4.get(status.index).getPrice_traffic()+price_traffic}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_traffic" value="${getMisTmBscPrimContract4.get(status.index).getPrice_traffic()+price_traffic}" /></c:if>
												<c:set var="price_sum_little" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_sum_little" value="${vo.getPrice_sum_little()+price_sum_little}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_sum_little" value="${getMisTmBscPrim4.get(status.index).getPrice_sum_little()+price_sum_little}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_sum_little" value="${getMisTmBscPrimContract4.get(status.index).getPrice_sum_little()+price_sum_little}" /></c:if>
												<c:set var="price_traffic" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_traffic" value="${vo.getPrice_traffic()+price_traffic}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_traffic" value="${getMisTmBscPrim4.get(status.index).getPrice_traffic()+price_traffic}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_traffic" value="${getMisTmBscPrimContract4.get(status.index).getPrice_traffic()+price_traffic}" /></c:if>
												<c:set var="price_question" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_question" value="${vo.getPrice_question()+price_question}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_question" value="${getMisTmBscPrim4.get(status.index).getPrice_question()+price_question}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_question" value="${getMisTmBscPrimContract4.get(status.index).getPrice_question()+price_question}" /></c:if>
												<c:set var="price_receipt" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_receipt" value="${vo.getPrice_receipt()+price_receipt}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_receipt" value="${getMisTmBscPrim4.get(status.index).getPrice_receipt()+price_receipt}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_receipt" value="${getMisTmBscPrimContract4.get(status.index).getPrice_receipt()+price_receipt}" /></c:if>
												<c:set var="price_sum_hap" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_sum_hap" value="${vo.getPrice_sum_hap()+price_sum_hap}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_sum_hap" value="${getMisTmBscPrim4.get(status.index).getPrice_sum_hap()+price_sum_hap}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_sum_hap" value="${getMisTmBscPrimContract4.get(status.index).getPrice_sum_hap()+price_sum_hap}" /></c:if>
												<c:set var="no_settle" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="no_settle" value="${vo.getNo_settle()+no_settle}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="no_settle" value="${getMisTmBscPrim4.get(status.index).getNo_settle()+no_settle}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="no_settle" value="${getMisTmBscPrimContract4.get(status.index).getNo_settle()+no_settle}" /></c:if>
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><p><a href="javascript:goMisTmBscMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');"><c:out value="${vo.getTeam_name()}" /></a></p></td>
											<td><fmt:formatNumber value="${reg_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${reg_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${end_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${end_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${proc_m}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${proc_y}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${nend_p}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${nend_30r}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${endea_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${endea_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_assess}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_time}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_sum_little}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_traffic}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_question}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_receipt}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_sum_hap}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${no_settle}" pattern="#,##0.##"/></font></td>
												<c:set var="sumReg_m4" value="${reg_m + sumReg_m4}" />
												<c:set var="sumReg_y4" value="${reg_y + sumReg_y4}" />
												<c:set var="sumEnd_m4" value="${end_m + sumEnd_m4}" />
												<c:set var="sumEnd_y4" value="${end_y + sumEnd_y4}" />
												<c:set var="sumProc_m4" value="${proc_m + sumProc_m4}" />
												<c:set var="sumProc_y4" value="${proc_y + sumProc_y4}" />
												<c:set var="sumNend_p4" value="${nend_p + sumNend_p4}" />
												<c:set var="sumNend_30r4" value="${nend_30r + sumNend_30r4}" />
												<c:set var="sumEndea_m4" value="${endea_m + sumEndea_m4}" />
												<c:set var="sumEndea_y4" value="${endea_y + sumEndea_y4}" />
												<c:set var="sumPrice_assess4" value="${price_assess + sumPrice_assess4}" />
												<c:set var="sumPrice_time4" value="${price_time + sumPrice_time4}" />
												<c:set var="sumPrice_sum_little4" value="${price_sum_little + sumPrice_sum_little4}" />
												<c:set var="sumPrice_traffic4" value="${price_traffic + sumPrice_traffic4}" />
												<c:set var="sumPrice_question4" value="${price_question + sumPrice_question4}" />
												<c:set var="sumPrice_receipt4" value="${price_receipt + sumPrice_receipt4}" />
												<c:set var="sumPrice_sum_hap4" value="${price_sum_hap + sumPrice_sum_hap4}" />
												<c:set var="sumNo_settle4" value="${no_settle + sumNo_settle4}" />
													<c:set var="reg_m" value="0" />
													<c:set var="reg_y" value="0" />
													<c:set var="end_m" value="0" />
													<c:set var="end_y" value="0" />
													<c:set var="proc_m" value="0" />
													<c:set var="proc_y" value="0" />
													<c:set var="nend_p" value="0" />
													<c:set var="nend_30r" value="0" />
													<c:set var="endea_m" value="0" />
													<c:set var="endea_y" value="0" />
													<c:set var="price_assess" value="0" />
													<c:set var="price_time" value="0" />
													<c:set var="price_sum_little" value="0" />
													<c:set var="price_traffic" value="0" />
													<c:set var="price_question" value="0" />
													<c:set var="price_receipt" value="0" />
													<c:set var="price_sum_hap" value="0" />
													<c:set var="no_settle" value="0" />
										</tr>
										</c:forEach>
										<tr bgcolor="#E7ECF1">
											<td>4종 합계</td>
											<td><fmt:formatNumber value="${sumReg_m4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumReg_y4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_m4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_y4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumProc_m4}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${sumProc_y4}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${sumNend_p4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumNend_30r4}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${sumEndea_m4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEndea_y4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_assess4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_time4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_little4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_traffic4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_question4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_receipt4}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_sum_hap4}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${sumNo_settle4}" pattern="#,##0.##"/></font></td>
										</tr>
									</tbody>
								</table>
							</div>
