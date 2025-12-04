<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="kmemberList" value="${kmemberList}" />

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="log_member_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						
						<div class="guestcnt2" id="tab_member" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="팀&개인 기본통계 1종">
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
						         				<p align="center"><B>인보이스 현황<font color="red"><B>(당월)</B></font></p>
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
									<c:set var="team_id" value="${team_id}" />
									<!-- 개인별 조회 결과 시작 -->
									<tbody>
									<c:forEach var="vo" items="${kmemberList}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td>
												<a href="./log_member2?team_name=${vo.getTeam_name()}&team_id=${team_id}&name=${vo.getName()}&user_id=${vo.getUser_id()}">
													<c:out value="${vo.getName()}" />
												</a>
											</td>
											<td><fmt:formatNumber value="${vo.getReg_m()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReg_y()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getEnd_m()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getEnd_y()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getProc_m()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.getProc_y()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.getNend_p()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getNend_30r()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.getEa_sum()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReport_ea()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_assess()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_time()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_a()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getP_price_b()}" pattern="#,##0.##"/></td>				
											<td><fmt:formatNumber value="${vo.getSum_little()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_traffic()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_question()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_receipt()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getSum_hap()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getNo_settle()}" pattern="#,##0.##"/></td>
										</tr>
									</c:forEach>
									</tbody>	
									<!-- 개인별 조회 결과 끝 -->			
								</table>
							</div>
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
					</div>
				</div>
