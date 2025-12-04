<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kind1List" value="${kind1List}" />
<c:set var="kind4List" value="${kind4List}" />
<c:set var="gubun" value="1"></c:set>
<c:set var="gubun" value="2"></c:set>

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="log_ig_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a>${toAccumYear}년 ${toMonthInt}월 팀별 평균 통계</a></li>
							</ul>
						</div>
						<div class="guestcnt2" id="tab_log_ig" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="팀&개인 기본통계 1종">
									<colgroup>
										<col width="65">
										<col width="100">
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
					                        <p align="center"><B>Type</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1" rowspan="3">
					                        <p align="center"><B>보험사</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					                        <p align="center"><B>수임현황</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					                        <p align="center"><B>종결현황</B></p>
					                    </td>										
										<td class="td" bgcolor="#E7ECF1">
					           			    <p align="center"><B>미결현황</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					              	        <p align="center"><B>종결평가</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="7">
					         				<p align="center"><b>공동수행자의 비율 및 금액을 
					         				   반영한 결과<font color="red">(반영안함!)</font></b></p>
					                    </td>										
					                </tr>
					                <tr>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					           			    <p align="center"><B>절대건수</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1" colspan="2">
					         				<p align="center"><B>절대건수</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
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
											<!-- <th>팀명</th> -->
											<th>당월</th>
											<th>년누계</th>
											<th>당월</th>
											<th>년누계</th>											
											<th>현재</th>
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
										<tr>
											<td class="td" rowspan="${kind1List.size()}">1종</td>
									<c:forEach var="vo" items="${kind1List}" varStatus="status">									
											<td><c:out value="${vo.getIg_nick()}" /></td>
											<td><c:out value="${vo.getReg_m()}" /></td>
											<td><c:out value="${vo.getReg_y()}" /></td>
											<td><c:out value="${vo.getEnd_m()}" /></td>
											<td><c:out value="${vo.getEnd_y()}" /></td>
											<td><c:out value="${vo.getNend_p()}" /></td>
											<td><c:out value="${vo.getEndea_m()}" /></td>
											<td><c:out value="${vo.getEndea_y()}" /></td>
											<td><c:out value="${vo.getPrice_assess()}" /></td>
											<td><c:out value="${vo.getPrice_time()}" /></td>
											<td><c:out value="${vo.getPrice_sum1()}" /></td>
											<td><c:out value="${vo.getPrice_traffic()}" /></td>
											<td><c:out value="${vo.getPrice_question()}" /></td>
											<td><c:out value="${vo.getPrice_receipt()}" /></td>
											<td class="td"><font color="red"><c:out value="${vo.getPrice_sum2()}" /></font></td>										
										</tr>
									</c:forEach>
										
										<tr>																
											<td class="td" rowspan="${kind4List.size()}">4종</td>
								<c:forEach var="vot" items="${kind4List}" varStatus="status">							
											<td><c:out value="${vot.getIg_nick()}" /></td>
											<td><c:out value="${vot.getReg_m()}" /></td>
											<td><c:out value="${vot.getReg_y()}" /></td>
											<td><c:out value="${vot.getEnd_m()}" /></td>
											<td><c:out value="${vot.getEnd_y()}" /></td>
											<td><c:out value="${vot.getNend_p()}" /></td>
											<td><c:out value="${vot.getEndea_m()}" /></td>
											<td><c:out value="${vot.getEndea_y()}" /></td>
											<td><c:out value="${vot.getPrice_assess()}" /></td>
											<td><c:out value="${vot.getPrice_time()}" /></td>
											<td><c:out value="${vot.getPrice_sum1()}" /></td>
											<td><c:out value="${vot.getPrice_traffic()}" /></td>
											<td><c:out value="${vot.getPrice_question()}" /></td>
											<td><c:out value="${vot.getPrice_receipt()}" /></td>																		
											<td class="td"><font color="red"><c:out value="${vot.getPrice_sum2()}" /></font></td>
										</tr>
								</c:forEach>
									</tbody>
									<tbody>
										<tr bgcolor="#E7ECF1">
										<td class="td" colspan="2"><b>합 계</b></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_reg_m()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_reg_y()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_end_m()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_end_y()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_nend_p()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_endea_m()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_endea_y()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_price_assess()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_price_time()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_price_sum1()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_price_traffic()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_price_question()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_price_receipt()}"/></font></td>
										<td class="td"><font color="red"><c:out value="${sumobj.getSum_price_sum2()}"/></font></td>										
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
