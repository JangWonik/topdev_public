<%@ page language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.text.*" %>
<% DecimalFormat df = new DecimalFormat("###,###"); %>


<c:set var="kind1List" value="${kind1List}" />
<c:set var="kind4List" value="${kind4List}" />

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="search_state_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a>${toAccumYear} 보고서 현황</a></li>
							</ul>
						</div>
						
						<c:if test="${tid eq '0' && pid eq '0'}">
						<div class="guestcnt2" id="tab" style="display:block;">
							<div class="tableStyle2" >
								<table cellpadding="0" cellspacing="0">
									<%-- <caption>팀&개인 기본통계 1종</caption> --%>
									<colgroup>
										<col width="16%">
										<col width="16%">
										<col width="16%">
										<col width="20%">
										<col width="16%">
										<col width="16%">
										
									</colgroup>
									<thead>
									<tr style="bgcolor: #E7ECF1;">
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>접수</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>결재</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>종결</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>취소&반송</B></p>
					                    </td>
										<td class="td"bgcolor="#E7ECF1">
					                        <p align="center"><b>소송</b></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					           			    <p align="center"><B>미결</B></p>
					                    </td>
					                </tr>
									</thead>
									<tbody>
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><fmt:formatNumber value="${rpt_List.rpt_reg}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${rpt_List.rpt_sub}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${rpt_List.rpt_end}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${rpt_List.rpt_cancel_return}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${rpt_List.rpt_law}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${rpt_List.rpt_notend}" pattern="#,##0.##"/></font></td>
										</tr>
									</tbody>
								</table>
							</div>
							</div>
							</c:if>
							
							<c:if test="${tid ne '0' && pid eq '0'}">
							<div class="guestcnt2" id="tab" style="display:block;">
							<div class="tableStyle2" >
								<table cellpadding="0" cellspacing="0">
									<%-- <caption>팀&개인 기본통계 1종</caption> --%>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
									<tr style="bgcolor: #E7ECF1;">
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>그룹</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>보험사</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>접수</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>결재</B></p>
					                    </td>
										<td class="td"bgcolor="#E7ECF1">
					                        <p align="center"><b>종결</b></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					           			    <p align="center"><B>취소&반송</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>소송</B></p>
					                    </td>
										<td class="td"bgcolor="#E7ECF1">
					                        <p align="center"><b>미결</b></p>
					                    </td>
					                </tr>
									</thead>
									<tbody>
									<c:forEach items="${selPtnrRptList}" var="selPtnrRptVo" varStatus="ptnrStatus">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
										
											<c:choose>
												<c:when test="${ptnrStatus.first}">
													<td rowspan="${selPtnrRptVo.cnt}">
														${selPtnrRptVo.highest_ptnr_name}
													</td>
													<c:set var="beforeOrder" value="${selPtnrRptVo.ptnr_group_order}" /> 
												</c:when>
												
												<c:otherwise>
													<c:if test="${beforeOrder ne selPtnrRptVo.ptnr_group_order}">
														<td rowspan="${selPtnrRptVo.cnt}">
															${selPtnrRptVo.highest_ptnr_name}
														</td>
													</c:if>
													<c:set var="beforeOrder" value="${selPtnrRptVo.ptnr_group_order}" /> 										
												</c:otherwise>
											</c:choose>	
										
										
											
	<%-- <td><c:out value="${selPtnrRptVo.getTop_ptnr_nick()}"/></td> --%>
											<td><c:out value="${selPtnrRptVo.getPtnr_nick()}"/></td>
											<td><fmt:formatNumber value="${selPtnrRptVo.getRpt_reg()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selPtnrRptVo.getRpt_sub()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selPtnrRptVo.getRpt_end()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selPtnrRptVo.getRpt_cancel_return()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selPtnrRptVo.getRpt_law()}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${selPtnrRptVo.getRpt_notend()}" pattern="#,##0.##"/></font></td>
											<%-- <td><font color="red"><fmt:formatNumber value="" pattern="#,##0.##"/></font></td> --%>
										</tr>
									</c:forEach>	
									</tbody>
								</table>
							</div>
						</div>
						</c:if>
						
						<c:if test="${tid ne '0' && pid ne '0'}">
						<div class="guestcnt2" id="tab" style="display:block;">
							<div class="tableStyle2" >
								<table cellpadding="0" cellspacing="0">
									<%-- <caption>팀&개인 기본통계 1종</caption> --%>
									<colgroup>
										<col width="12%">
										<col width="13%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="15%">
										<col width="12%">
										<col width="12%">
										
									</colgroup>
									<thead>
									<tr style="bgcolor: #E7ECF1;">
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>팀</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>보험사</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>접수</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>결재</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>종결</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>취소&반송</B></p>
					                    </td>
										<td class="td"bgcolor="#E7ECF1">
					                        <p align="center"><b>소송</b></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					           			    <p align="center"><B>미결</B></p>
					                    </td>
					                </tr>
									</thead>
									<tbody>
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											<td><c:out value="${selTeamPtnrRptList.team_name}"/></td>
											<td><c:out value="${selTeamPtnrRptList.ptnr_nick}"/></td>
											<td><fmt:formatNumber value="${selTeamPtnrRptList.rpt_reg}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selTeamPtnrRptList.rpt_sub}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selTeamPtnrRptList.rpt_end}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selTeamPtnrRptList.rpt_cancel_return}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selTeamPtnrRptList.rpt_law}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${selTeamPtnrRptList.rpt_notend}" pattern="#,##0.##"/></font></td>
										</tr>
									</tbody>
								</table>
							</div>
							</div>
							</c:if>
							
							<c:if test="${tid eq '0' && pid ne '0'}">
							<div class="guestcnt2" id="tab" style="display:block;">
							<div class="tableStyle2" >
								<table cellpadding="0" cellspacing="0">
									<%-- <caption>팀&개인 기본통계 1종</caption> --%>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
									<tr style="bgcolor: #E7ECF1;">
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>그룹</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>팀명</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>접수</B></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>결재</B></p>
					                    </td>
										<td class="td"bgcolor="#E7ECF1">
					                        <p align="center"><b>종결</b></p>
					                    </td>
										<td class="td" bgcolor="#E7ECF1">
					           			    <p align="center"><B>취소&반송</B></p>
					                    </td>
					                    <td class="td" bgcolor="#E7ECF1">
					                        <p align="center"><B>소송</B></p>
					                    </td>
										<td class="td"bgcolor="#E7ECF1">
					                        <p align="center"><b>미결</b></p>
					                    </td>
					                </tr>
									</thead>
									<tbody>
									<c:forEach items="${selTeamRptList}" var="selTeamRptVo" varStatus="tmStatus">
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
											
											<c:choose>
												<c:when test="${tmStatus.first}">
													<td rowspan="${selTeamRptVo.cnt}">
														${selTeamRptVo.highest_team_name}
													</td>
													<c:set var="beforeOrder" value="${selTeamRptVo.team_group_order}" /> 
												</c:when>
												
												<c:otherwise>
													<c:if test="${beforeOrder ne selTeamRptVo.team_group_order}">
														<td rowspan="${selTeamRptVo.cnt}">
															${selTeamRptVo.highest_team_name}
														</td>
													</c:if>
													<c:set var="beforeOrder" value="${selTeamRptVo.team_group_order}" /> 										
												</c:otherwise>
											</c:choose>											
											
											
											<td><c:out value="${selTeamRptVo.getTeam_name()}"/></td>
											<td><fmt:formatNumber value="${selTeamRptVo.getRpt_reg()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selTeamRptVo.getRpt_sub()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selTeamRptVo.getRpt_end()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selTeamRptVo.getRpt_cancel_return()}" pattern="#,##0.##"/></td>
											<td><fmt:formatNumber value="${selTeamRptVo.getRpt_law()}" pattern="#,##0.##"/></td>
											<td><font color="red"><fmt:formatNumber value="${selTeamRptVo.getRpt_notend()}" pattern="#,##0.##"/></font></td>
											<%-- <td><font color="red"><fmt:formatNumber value="" pattern="#,##0.##"/></font></td> --%>
										</tr>
									</c:forEach>	
									</tbody>
								</table>
							</div>
						</div>
						</c:if>
						
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