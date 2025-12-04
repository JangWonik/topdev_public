<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kmemberList" value="${kmemberList}" />

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="log_nsc_member_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						
						<div class="guestcnt2" style="display:block;">
							<div class="tableStyle2">
								<!-- <table cellpadding="0" cellspacing="0" summary="팀&개인 기본통계 1종"> -->
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
									<table cellpadding="0" cellspacing="0" width="990" align="center">
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
									
									
									<!-- 개인별 조회 결과 시작 -->
									<tbody>
									<c:forEach var="vo" items="${kmemberList}" varStatus="status">
										<tr>
											<td>
												<a href="./log_member2?team_name=${vo.getTeam_name()}&name=${vo.getName()}&user_id=${vo.getUser_id()}">
													<c:out value="${vo.getName()}" />
												</a>
											</td>
											<td><c:out value="${vo.getReg_m()}" /></td>
											<td><c:out value="${vo.getReg_m()}" /></td>
											<td><c:out value="${vo.getReg_m()}" /></td>
											<td><c:out value="${vo.getReg_y()}" /></td>
											<td><c:out value="${vo.getEnd_m()}" /></td>
											<td><c:out value="${vo.getEnd_y()}" /></td>
											<td><c:out value="${vo.getProc_m()}" /></td>
											<td><c:out value="${vo.getProc_y()}" /></td>
											<td><c:out value="${vo.getNend_p()}" /></td>
											<td><c:out value="${vo.getNend_30r()}" /></td>
											<td><c:out value="${vo.getEa_sum()}" /></td>
											<td><c:out value="${vo.getReport_ea()}" /></td>
											<td><c:out value="${vo.getPrice_assess()}" /></td>
											<td><c:out value="${vo.getPrice_time()}" /></td>
											<td><c:out value="${vo.getP_price_a()}" /></td>
											<td><c:out value="${vo.getP_price_b()}" /></td>				
											<td><c:out value="${vo.getSum_little()}" /></td>
											<td><c:out value="${vo.getPrice_traffic()}" /></td>
											<td><c:out value="${vo.getPrice_question()}" /></td>
											<td><c:out value="${vo.getPrice_receipt()}" /></td>
											<td><c:out value="${vo.getSum_hap()}" /></td>
											<td><c:out value="${vo.getNo_settle()}" /></td>
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
