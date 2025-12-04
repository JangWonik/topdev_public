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
												<c:set var="reg_m" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="reg_m" value="${vo.getReg_m()+reg_m}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="reg_m" value="${0+reg_m}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="reg_m" value="${getMisTmBscMbrPrimContract.get(status.index).getReg_m()+reg_m}" /></c:if>
												<c:set var="reg_y" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="reg_y" value="${vo.getReg_y()+reg_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="reg_y" value="${getMisTmBscMbrPrim.get(status.index).getReg_y()+reg_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="reg_y" value="${getMisTmBscMbrPrimContract.get(status.index).getReg_y()+reg_y}" /></c:if>
												<c:set var="end_m" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="end_m" value="${vo.getEnd_m()+end_m}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="end_m" value="${getMisTmBscMbrPrim.get(status.index).getEnd_m()+end_m}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="end_m" value="${getMisTmBscMbrPrimContract.get(status.index).getEnd_m()+end_m}" /></c:if>
												<c:set var="end_y" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="end_y" value="${vo.getEnd_y()+end_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="end_y" value="${getMisTmBscMbrPrim.get(status.index).getEnd_y()+end_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="end_y" value="${getMisTmBscMbrPrimContract.get(status.index).getEnd_y()+end_y}" /></c:if>
												<c:set var="proc_m" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="proc_m" value="${vo.getProc_m()+proc_m}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="proc_m" value="${getMisTmBscMbrPrim.get(status.index).getProc_m()+proc_m}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="proc_m" value="${getMisTmBscMbrPrimContract.get(status.index).getProc_m()+proc_m}" /></c:if>
												<c:set var="proc_y" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="proc_y" value="${vo.getProc_y()+proc_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="proc_y" value="${getMisTmBscMbrPrim.get(status.index).getProc_y()+proc_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="proc_y" value="${getMisTmBscMbrPrimContract.get(status.index).getProc_y()+proc_y}" /></c:if>
												<c:set var="nend_p" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="nend_p" value="${vo.getNend_p()+nend_p}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="nend_p" value="${getMisTmBscMbrPrim.get(status.index).getNend_p()+nend_p}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="nend_p" value="${getMisTmBscMbrPrimContract.get(status.index).getNend_p()+nend_p}" /></c:if>
												<c:set var="nend_30r" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="reg_y" value="${vo.getNend_30r()+reg_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="reg_y" value="${getMisTmBscMbrPrim.get(status.index).getNend_30r()+reg_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="reg_y" value="${getMisTmBscMbrPrimContract.get(status.index).getNend_30r()+reg_y}" /></c:if>
												<c:set var="endea_m" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="endea_m" value="${vo.getEndea_m()+endea_m}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="endea_m" value="${getMisTmBscMbrPrim.get(status.index).getEndea_m()+endea_m}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="endea_m" value="${getMisTmBscMbrPrimContract.get(status.index).getEndea_m()+endea_m}" /></c:if>
												<c:set var="endea_y" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="endea_y" value="${vo.getEndea_y()+endea_y}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="endea_y" value="${getMisTmBscMbrPrim.get(status.index).getEndea_y()+endea_y}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="endea_y" value="${getMisTmBscMbrPrimContract.get(status.index).getEndea_y()+endea_y}" /></c:if>
												<c:set var="ea_sum" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="ea_sum" value="${vo.getEa_sum()+ea_sum}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="ea_sum" value="${getMisTmBscMbrPrim.get(status.index).getEa_sum()+ea_sum}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="ea_sum" value="${getMisTmBscMbrPrimContract.get(status.index).getEa_sum()+ea_sum}" /></c:if>
												<c:set var="report_ea" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="report_ea" value="${vo.getReport_ea()+report_ea}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="report_ea" value="${getMisTmBscMbrPrim.get(status.index).getReport_ea()+report_ea}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="report_ea" value="${getMisTmBscMbrPrimContract.get(status.index).getReport_ea()+report_ea}" /></c:if>
												<c:set var="price_assess" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_assess" value="${vo.getPrice_assess()+price_assess}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_assess" value="${getMisTmBscMbrPrim.get(status.index).getPrice_assess()+price_assess}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_assess" value="${getMisTmBscMbrPrimContract.get(status.index).getPrice_assess()+price_assess}" /></c:if>
												<c:set var="price_time" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_time" value="${vo.getPrice_time()+price_time}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_time" value="${getMisTmBscMbrPrim.get(status.index).getPrice_time()+price_time}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_time" value="${getMisTmBscMbrPrimContract.get(status.index).getPrice_time()+price_time}" /></c:if>
												<c:set var="p_price_a" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="p_price_a" value="${vo.getP_price_a()+p_price_a}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="p_price_a" value="${getMisTmBscMbrPrim.get(status.index).getP_price_a()+p_price_a}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="p_price_a" value="${getMisTmBscMbrPrimContract.get(status.index).getP_price_a()+p_price_a}" /></c:if>
												<c:set var="p_price_b" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="p_price_b" value="${vo.getP_price_b()+p_price_b}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="p_price_b" value="${getMisTmBscMbrPrim.get(status.index).getP_price_b()+p_price_b}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="p_price_b" value="${getMisTmBscMbrPrimContract.get(status.index).getP_price_b()+p_price_b}" /></c:if>
												<c:set var="price_sum_little" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_sum_little" value="${vo.getPrice_sum_little()+price_sum_little}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_sum_little" value="${getMisTmBscMbrPrim.get(status.index).getPrice_sum_little()+price_sum_little}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_sum_little" value="${getMisTmBscMbrPrimContract.get(status.index).getPrice_sum_little()+price_sum_little}" /></c:if>
												<c:set var="price_traffic" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_traffic" value="${vo.getPrice_traffic()+price_traffic}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_traffic" value="${getMisTmBscMbrPrim.get(status.index).getPrice_traffic()+price_traffic}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_traffic" value="${getMisTmBscMbrPrimContract.get(status.index).getPrice_traffic()+price_traffic}" /></c:if>
												<c:set var="price_question" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_question" value="${vo.getPrice_question()+price_question}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_question" value="${getMisTmBscMbrPrim.get(status.index).getPrice_question()+price_question}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_question" value="${getMisTmBscMbrPrimContract.get(status.index).getPrice_question()+price_question}" /></c:if>
												<c:set var="price_receipt" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_receipt" value="${vo.getPrice_receipt()+price_receipt}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_receipt" value="${getMisTmBscMbrPrim.get(status.index).getPrice_receipt()+price_receipt}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_receipt" value="${getMisTmBscMbrPrimContract.get(status.index).getPrice_receipt()+price_receipt}" /></c:if>
												<c:set var="price_sum_hap" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="price_sum_hap" value="${vo.getPrice_sum_hap()+price_sum_hap}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="price_sum_hap" value="${getMisTmBscMbrPrim.get(status.index).getPrice_sum_hap()+price_sum_hap}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="price_sum_hap" value="${getMisTmBscMbrPrimContract.get(status.index).getPrice_sum_hap()+price_sum_hap}" /></c:if>
												<c:set var="no_settle" value="0" />
													<c:if test="${inVO.basicYN == 'Y'}"><c:set var="no_settle" value="${vo.getNo_settle()+no_settle}" /></c:if>
													<c:if test="${inVO.primYN == 'Y'}"><c:set var="no_settle" value="${getMisTmBscMbrPrim.get(status.index).getNo_settle()+no_settle}" /></c:if>
													<c:if test="${inVO.primContractYN == 'Y'}"><c:set var="no_settle" value="${getMisTmBscMbrPrimContract.get(status.index).getNo_settle()+no_settle}" /></c:if>
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><a href="javascript:goMisTmBscMbr2('${vo.user_no}','${vo.user_name}');"><c:out value="${vo.user_name}" /></a></td>
											<td><fmt:formatNumber value="${reg_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${reg_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${end_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${end_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${proc_m}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${proc_y}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${nend_p}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${nend_30r}" pattern="#,##0.##"/>%</td>
<%-- 											<td><fmt:formatNumber value="${endea_m}" pattern="#,##0.##"/></td> --%>
<%-- 											<td><fmt:formatNumber value="${endea_y}" pattern="#,##0.##"/></td> --%>
											<td><fmt:formatNumber value="${ea_sum}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${report_ea}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_assess}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_time}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${p_price_a}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${p_price_b}" pattern="#,##0.##"/></td>				
											<td><fmt:formatNumber value="${price_sum_little}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_traffic}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_question}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_receipt}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${price_sum_hap}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${no_settle}" pattern="#,##0.##"/></font></td>
												<c:set var="sumReg_m" value="${reg_m + sumReg_m}" />
												<c:set var="sumReg_y" value="${reg_y + sumReg_y}" />
												<c:set var="sumEnd_m" value="${end_m + sumEnd_m}" />
												<c:set var="sumEnd_y" value="${end_y + sumEnd_y}" />
												<c:set var="sumProc_m" value="${proc_m + sumProc_m}" />
												<c:set var="sumProc_y" value="${proc_y + sumProc_y}" />
												<c:set var="sumNend_p" value="${nend_p + sumNend_p}" />
												<c:set var="sumNend_30r" value="${nend_30r + sumNend_30r}" />
												<c:set var="sumEndea_m" value="${endea_m + sumEndea_m}" />
												<c:set var="sumEndea_y" value="${endea_y + sumEndea_y}" />
												<c:set var="sumEa_sum" value="${ea_sum + sumEa_sum}" />
												<c:set var="sumReport_ea" value="${report_ea + sumReport_ea}" />
												<c:set var="sumPrice_assess" value="${p_price_a + sumPrice_assess}" />
												<c:set var="sumPrice_time" value="${price_time + sumPrice_time}" />
												<c:set var="sumP_price_a" value="${endea_m + sumP_price_a}" />
												<c:set var="sumP_price_b" value="${endea_y + sumP_price_b}" />
												<c:set var="sumPrice_sum_little" value="${price_sum_little + sumPrice_sum_little}" />
												<c:set var="sumPrice_traffic" value="${price_traffic + sumPrice_traffic}" />
												<c:set var="sumPrice_question" value="${price_question + sumPrice_question}" />
												<c:set var="sumPrice_receipt" value="${price_receipt + sumPrice_receipt}" />
												<c:set var="sumPrice_sum_hap" value="${price_sum_hap + sumPrice_sum_hap}" />
												<c:set var="sumNo_settle" value="${no_settle + sumNo_settle}" />
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
													<c:set var="ea_sum" value="0" />
													<c:set var="report_ea" value="0" />
													<c:set var="price_assess" value="0" />
													<c:set var="price_time" value="0" />
													<c:set var="p_price_a" value="0" />
													<c:set var="p_price_b" value="0" />
													<c:set var="price_sum_little" value="0" />
													<c:set var="price_traffic" value="0" />
													<c:set var="price_question" value="0" />
													<c:set var="price_receipt" value="0" />
													<c:set var="price_sum_hap" value="0" />
													<c:set var="no_settle" value="0" />
										</tr>
									</c:forEach>
										<tr>
											<td bgcolor="#E7ECF1">합계</td>
											<td><fmt:formatNumber value="${sumReg_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumReg_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_m}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumEnd_y}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumProc_m}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${sumProc_y}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${sumNend_p}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumNend_30r}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${sumEa_sum}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumReport_ea}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_assess}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_time}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumP_price_a}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumP_price_b}" pattern="#,##0.##"/></td>				
											<td><fmt:formatNumber value="${sumSum_little}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_traffic}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_question}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumPrice_receipt}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumSum_hap}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${sumNo_settle}" pattern="#,##0.##"/></td>
										</tr>
									</tbody>	
									<!-- 개인별 조회 결과 끝 -->			
								</table>
							</div>
