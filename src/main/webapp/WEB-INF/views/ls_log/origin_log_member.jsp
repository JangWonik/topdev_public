<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kind1List" value="${kind1List}" />
<c:set var="kind4List" value="${kind4List}" />

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="log_team_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a>${toAccumYear}년 ${toMonthInt}월 재물팀 팀별 평균 통계</a></li>
							</ul>
						</div>
						<div class="guestcnt2" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="팀&개인 기본통계 1종">
									<caption>팀&개인 기본통계 1종</caption>
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
									<tr style="bgcolor: #E7ECF1; text-align: center;">
					                    <!-- <td class="td" bgcolor="#E7ECF1" rowspan="3">
					                        <p align="center"><B>Type</B></p>
					                    </td> -->
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
					         				<p align="center"><b>공동수행자의 비율 및 금액을 
					         				   반영한 결과</b></p>
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
											<!-- <th>팀명</th> -->
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
											<!-- <th>미수금</th> -->
										</tr>
										<tr>
											<td class="td" bgcolor="#E7ECF1">기본료</td>
											<td class="td" bgcolor="#E7ECF1">일비</td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<!-- <td class="td" rowspan="23">1종</td> -->
<c:forEach var="vo" items="${kind1List}" varStatus="status">
											<%-- <td><c:out value="${vo.getTeam_type()}" /></td> --%>
											<td><c:out value="${vo.getTeam_name()}" /></td>
											<td><c:out value="${vo.getReg_m()}" /></td>
											<td><c:out value="${vo.getReg_y()}" /></td>
											<td><c:out value="${vo.getEnd_m()}" /></td>
											<td><c:out value="${vo.getEnd_y()}" /></td>
											<td><c:out value="${vo.getProc_m()}" />%</td>
											<td><c:out value="${vo.getProc_y()}" />%</td>
											<td><c:out value="${vo.getNend_p()}" /></td>
											<td><c:out value="${vo.getNend_30r()}" />%</td>
											<td><c:out value="${vo.getEndea_m()}" /></td>
											<td><c:out value="${vo.getEndea_y()}" /></td>
											<td><c:out value="${vo.getPrice_assess()}" /></td>
											<td><c:out value="${vo.getPrice_time()}" /></td>
											<td>-</td>
											<td>-</td>					
											<td><c:out value="${vo.getPrice_sum1()}" /></td>
											<td><c:out value="${vo.getPrice_traffic()}" /></td>
											<td><c:out value="${vo.getPrice_question()}" /></td>
											<td><c:out value="${vo.getPrice_receipt()}" /></td>
											<td><c:out value="${vo.getPrice_sum2()}" /></td>
											<td class="td" color="red"><c:out value="${vo.getPrice_total()}" /></td>
										</tr>
</c:forEach>
									</tbody>
									<tbody>
										<tr>
											<td class="td" rowspan="24">4종</td>
<c:forEach var="vot" items="${kind4List}" varStatus="status">
											<%-- <td><c:out value="${vo.getTeam_type()}" /></td> --%>
											<td><c:out value="${vot.getTeam_name()}" /></td>
											<td><c:out value="${vot.getReg_m()}" /></td>
											<td><c:out value="${vot.getReg_y()}" /></td>
											<td><c:out value="${vot.getEnd_m()}" /></td>
											<td><c:out value="${vot.getEnd_y()}" /></td>
											<td><c:out value="${vot.getProc_m()}" />%</td>
											<td><c:out value="${vot.getProc_y()}" />%</td>
											<td><c:out value="${vot.getNend_p()}" /></td>
											<td><c:out value="${vot.getNend_30r()}" />%</td>
											<td><c:out value="${vot.getEndea_m()}" /></td>
											<td><c:out value="${vot.getEndea_y()}" /></td>
											<td><c:out value="${vot.getPrice_assess()}" /></td>
											<td><c:out value="${vot.getPrice_time()}" /></td>
											<td><c:out value="${vot.getPrice_sum1()}" /></td>
											<td><c:out value="${vot.getPrice_traffic()}" /></td>
											<td><c:out value="${vot.getPrice_question()}" /></td>
											<td><c:out value="${vot.getPrice_receipt()}" /></td>
											<td><c:out value="${vot.getPrice_sum2()}" /></td>
											<td class="td" color="red"><c:out value="${vot.getPrice_total()}" /></td>
										</tr>
</c:forEach>
									</tbody>
									<tbody>
										<tr bgcolor="#E7ECF1">
										<td class="td" colspan="2"><b>합 계</b></td>
										<td><c:out value="${sumobj.getSum_reg_m()}"/></td>
										<td><c:out value="${sumobj.getSum_reg_y()}"/></td>
										<td><c:out value="${sumobj.getSum_end_m()}"/></td>
										<td><c:out value="${sumobj.getSum_end_y()}"/></td>
										<td><c:out value="${sumobj.getSum_proc_m()}"/>%</td>
										<td><c:out value="${sumobj.getSum_proc_y()}"/>5</td>
										<td><c:out value="${sumobj.getSum_nend_p()}"/></td>
										<td><c:out value="${sumobj.getSum_nend_30r()}"/>%</td>
										<td><c:out value="${sumobj.getSum_endea_m()}"/></td>
										<td><c:out value="${sumobj.getSum_endea_y()}"/></td>
										<td><c:out value="${sumobj.getSum_price_assess()}"/></td>
										<td><c:out value="${sumobj.getSum_price_time()}"/></td>
										<td><c:out value="${sumobj.getSum_price_sum1()}"/></td>
										<td><c:out value="${sumobj.getSum_price_traffic()}"/></td>
										<td><c:out value="${sumobj.getSum_price_question()}"/></td>
										<td><c:out value="${sumobj.getSum_price_receipt()}"/></td>
										<td><c:out value="${sumobj.getSum_price_sum2()}"/></td>
										<td><c:out value="${sumobj.getSum_price_total()}"/></td>										
										</tr>
									</tbody>
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
