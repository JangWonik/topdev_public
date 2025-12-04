<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

							<div class="tableStyle2" id="dataTable">
								<table cellpadding="0" cellspacing="0" summary="팀 기본통계 1종">
								<caption>팀 기본통계</caption>
									<colgroup>
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
									</colgroup>
									<thead>
										<tr align="center" bgcolor="#EFEFEF">
											<td class="td" nowrap>이름</td>
											<td class="td" nowrap>접수번호</td>
											<td class="td" nowrap>종결번호</td>
											<td class="td" nowrap>보험사</td>
											<td class="td" nowrap>건물구분</td>
											<td class="td" nowrap>계약자</td>
											<td class="td" nowrap>수임</td>
											<td class="td" nowrap>종결</td>
											<td class="td" nowrap>종결</td>
										</tr>
										
									</thead>
									<tbody>
										
									<c:forEach var="vo" items="${getMisContractTmMbr2}" varStatus="status">
										<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
											
											<td>
												<c:out value="${inVO.user_name}" />
											</td>
											<td>
												<c:out value="${vo.getSuim_accept_no()}" />
											</td>
											<td>
												<c:out value="${vo.getSuim_close_no()}" />
											</td>
											<td>
												<c:out value="${vo.getPtnr_name()}" />
											</td>
											<td>
											<c:choose>
												<c:when test="${vo.getBd_type() eq 1}">
													일반
												</c:when>
												<c:otherwise>
													공장
												</c:otherwise>
											</c:choose>
											</td>
											<td>
												<c:out value="${vo.getPolicyholder_nm()}" />
											</td>
											<td>
												<c:out value="${vo.getReg_date()}" />
											</td>
											<td>
												<c:out value="${vo.getClose_date()}" />
											</td>
											<td>
												<c:if test="${vo.getReport_1() eq 01}">
													조사완료
												</c:if>
												<c:if test="${vo.getReport_1() eq 02}">
													<font color="red">조사실패</font>
												</c:if>
											</td>
											
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
