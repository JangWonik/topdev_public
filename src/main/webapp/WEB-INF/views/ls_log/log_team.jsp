<%@ page language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%-- <%@ page language="java" contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="utf-8"%> --%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	DecimalFormat df = new DecimalFormat("###,###");

%>


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
								<li class="on"><a>${toAccumYear}년 ${toMonthInt}월 팀별 평균 통계</a></li>
							</ul>
						</div>
						<div class="guestcnt2" id="tab" style="display:block;">
							<div class="tableStyle2" >
								<table cellpadding="0" cellspacing="0">
									<%-- <caption>팀&개인 기본통계 1종</caption> --%>
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
										
											<c:if test="${typeF ne '4'}">
											<td class="td" rowspan="${kind1List.size() + 1}" >1종</td>
											</c:if>
											<c:forEach var="vo" items="${kind1List}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><p><a href="./log_member?team_id=${vo.getTeam_id()}&team_name=${vo.getTeam_name()}"><c:out value="${vo.getTeam_name()}" /></a></p></td>
											<td><fmt:formatNumber value="${vo.getReg_m()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getReg_y()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getEnd_m()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getEnd_y()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getProc_m()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.getProc_y()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.getNend_p()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getNend_30r()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vo.getEndea_m()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getEndea_y()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_assess()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_time()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_sum1()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_traffic()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_question()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_receipt()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.getPrice_sum2()}" pattern="#,##0.##"/></td>
											<td class="td"><font color="red"><fmt:formatNumber value="${vo.getPrice_total()}" pattern="#,##0.##"/></font></td>
										</tr>
										</c:forEach>
										
									
									</tbody>
									<tbody>
										<c:if test="${typeF ne '1'}">
											<td class="td" rowspan="${kind4List.size()}">4종</td>
										</c:if>
											<c:forEach var="vot" items="${kind4List}" varStatus="status">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><p><a href="./log_member?team_id=${vot.getTeam_id()}&team_name=${vot.getTeam_name()}"><c:out value="${vot.getTeam_name()}" /></a></p></td>
											<td><fmt:formatNumber value="${vot.getReg_m()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getReg_y()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getEnd_m()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getEnd_y()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getProc_m()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vot.getProc_y()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vot.getNend_p()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getNend_30r()}" pattern="#,##0.##"/>%</td>
											<td><fmt:formatNumber value="${vot.getEndea_m()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getEndea_y()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getPrice_assess()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getPrice_time()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getPrice_sum1()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getPrice_traffic()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getPrice_question()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getPrice_receipt()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${vot.getPrice_sum2()}" pattern="#,##0.##"/></td>
											<td class="td"><font color="red"><fmt:formatNumber value="${vot.getPrice_total()}" pattern="#,##0.##"/></font></td>
										</tr>
									</c:forEach>
									
									<%-- </c:if> --%>
									
									</tbody>
									<tbody>
									<c:if test="${typeF eq 'all'}">
										<tr bgcolor="#E7ECF1">
										<td class="td" colspan="2"><b>합 계</b></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_reg_m()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_reg_y()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_end_m()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_end_y()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_proc_m()}" pattern="#,##0.##"/>%</font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_proc_y()}" pattern="#,##0.##"/>%</font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_nend_p()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_nend_30r()}" pattern="#,##0.##"/>%</font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_endea_m()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_endea_y()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_price_assess()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_price_time()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_price_sum1()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_price_traffic()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_price_question()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_price_receipt()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_price_sum2()}" pattern="#,##0.##"/></font></td>
										<td><font color="red"><fmt:formatNumber value="${sumobj.getSum_price_total()}" pattern="#,##0.##"/></font></td>										
										</tr>
										</c:if>
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