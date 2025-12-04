<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=Suit18RptSearch.xls"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

	<h1>Suit18RptSearch.xls</h1>
	<br /><br />
	<!-- 검색 조건 테이블 -->
	<h2>검색 조건 테이블</h2>
			<table border="1">
				<tbody>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>진행현황</b></td>
						<td width="16%">
							<c:choose>
								<c:when test="${searchVO.stateSearch == '9999'}">전체</c:when>
								<c:when test="${searchVO.stateSearch == '0'}">미결</c:when>
								<c:when test="${searchVO.stateSearch == '1'}">결재</c:when>
								<c:when test="${searchVO.stateSearch == '11'}">반려</c:when>
								<c:when test="${searchVO.stateSearch == '2'}">종결</c:when>
								<c:when test="${searchVO.stateSearch == '3'}">위임취소</c:when>
							</c:choose>
							ㆍ 조사자 미배당
								<c:choose>
									<c:when test="${searchVO.noUserSearch == 'on'}"> O </c:when>
									<c:otherwise> X </c:otherwise>
								</c:choose>
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>접수일</b></td>
						<td width="18%">
							<c:if test="${searchVO.regDateFromSearch != '' || searchVO.regDateToSearch != ''}">
								${searchVO.regDateFromSearch} ~ &nbsp;${searchVO.regDateToSearch}
							</c:if>
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>위임취소일</b></td>
						<td width="18%">
							<c:if test="${searchVO.cancelDateFromSearch != '' || searchVO.cancelDateToSearch != ''}">
								${searchVO.cancelDateFromSearch} ~ &nbsp;${searchVO.cancelDateToSearch}
							</c:if>
						</td>
					</tr>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>조사팀</b></td>
						<td width="16%">
							<c:choose>
								<c:when test="${searchVO.tmSearch == 0}">전체</c:when>
								<c:otherwise>
									<c:forEach items="${teamList}" var = "teamVo">
										<c:if test="${searchVO.tmSearch == teamVo.team_id}">${teamVo.team_name}</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>조사 담당자</b></td>
						<td width="16%">
							${searchVO.userNmSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>상신일</b></td>
						<td width="18%">
							<c:if test="${searchVO.aprvDateFromSearch != '' || searchVO.aprvDateToSearch != ''}">
								${searchVO.aprvDateFromSearch} ~ &nbsp;${searchVO.aprvDateToSearch}
							</c:if>
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>종결일</b></td>
						<td width="18%">
							<c:if test="${searchVO.closeDateFromSearch != '' || searchVO.closeDateToSearch != ''}">
								${searchVO.closeDateFromSearch} ~ &nbsp;${searchVO.closeDateToSearch}
							</c:if>
						</td>
					</tr>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>보험사</b></td>
						<td width="16%">
							<c:choose>
								<c:when test="${searchVO.ptnrSearch == 0}">전체</c:when>
								<c:otherwise>
									<c:forEach items="${ptnrList}" var = "ptnrVo">
										<c:if test="${searchVO.ptnrSearch == ptnrVo.ptnr_id}">${ptnrVo.ptnr_nick}</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="18%">
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>보험종목명</b></td>
						<td width="18%">
							${searchVO.insuNmSearch}
						</td>
					</tr>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>계약자</b></td>
						<td width="16%">
							${searchVO.policyhNmSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
					</tr>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>증권번호</b></td>
						<td width="16%">
							${searchVO.policyNoSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
					</tr>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>접수번호</b></td>
						<td width="16%">
							${searchVO.acceptNoSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b></b></td>
						<td width="16%">
						</td>
						<td colspan="2" style="text-align:right;">
						</td>
					</tr>
				</tbody>
			</table>
	<!-- //검색 조건 테이블 -->
	<br /><br />
	<!-- 검색 결과 테이블 -->
	<h2>검색 결과 테이블</h2>
			<table border="1">
									<thead >
										<tr > <!-- #E7ECF1 -->
											<th  rowspan="2" width="2%" >no.</th>
											<th  rowspan="2" width="2%">Lock</th>
											<th  rowspan="2" width="5%">접수번호</th>
											<th  rowspan="2" width="5%">종결번호</th>
											<th  rowspan="2" width="4%">보험사</th>
											<th  rowspan="2" width="5%">처리팀</th>
											<th  rowspan="2" width="4%">담당자</th>
											<th  rowspan="2" width="2%">건물구분</th>
											<th  rowspan="2" width="5%">계약자</th>
											<th  colspan="2" width="4%">SMS</th>
											<th  rowspan="2" width="4%">수임</th>
											<th  rowspan="2" width="4%">종결</th>
										</tr>
										<tr>
											<th>모집인</th>
											<th>계약자</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${suitList18}" var="suitVO" varStatus="status" > 
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;" onclick="popSuit18Dtl('${suitVO.suimRptNo}', '${suitVO.delDate}');">
											<!-- no -->
											<td>${suitList18.size() - status.index}</td>
											<!-- lock -->
											<td>
												<c:choose>
													<c:when test="${suitVO.lockFlag eq 1}">
														보고서 잠금
													</c:when>
													<c:when test="${suitVO.lockFlag eq 0}">
														보고서 열람가능
													</c:when>
												</c:choose>
											</td>
											<!-- suim_accept_no -->
											<td title="${suitVO.suimAcceptNo}">
												${suitVO.suimAcceptNo}
											</td>
											<!-- suim_close_no -->
											<td title="${suitVO.suimCloseNo}" >
												<c:choose>
													<c:when test="${suitVO.suimCloseNo != ''}">${suitVO.suimCloseNo}</c:when>
													<c:otherwise><font color="red">미결</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 보험사 -->
											<td title="${suitVO.ptnrName}" >${suitVO.ptnrNick}</td>
											<!-- 처리팀 -->
											<td title="${suitVO.teamName}" >
												<c:if test="${not empty suitVO.teamMark}">
													<span class="mark_alarm">${suitVO.teamMark}</span>
												</c:if>
											</td>
											<!-- 담당자 -->
											<td title="${suitVO.userName}" >
												<c:choose>
													<c:when test="${suitVO.userNo > 0}">
														${suitVO.userName}
													</c:when>
													<c:otherwise><font color="red">미배당</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 건물 -->
											<td title="${suitVO.bdType}" >
												<c:choose>
													<c:when test="${suitVO.bdType eq '1'}">일반</c:when>
													<c:otherwise>
														공장
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 계약자 -->
											<td title="${suitVO.policyholderNm}">
												<c:choose>
													<c:when test="${suitVO.policyholderNm != ''}">
														${suitVO.policyholderNm}
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${suitVO.suimRptState >1 }">
														-
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${suitVO.conCnt1 > 0}">
																발송
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${suitVO.clerkHndPhoneNo ne '' 
															and (
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '010') or 
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '011') or 
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '016') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '017') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '018') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '019')
															)
															}">
																		<font color='#CC3300'>미발송</font>
																	</c:when>
																	<c:otherwise>
																		<font color='#cccccc'>해당無</font>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${suitVO.suimRptState >1 }">
														-
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${suitVO.conCnt2 > 0}">
																발송
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${suitVO.conHndPhoneNo ne '' 
															and (
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '010') or 
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '011') or 
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '016') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '017') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '018') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '019')
															)
															}">
																		<font color='#CC3300'>미발송</font>
																	</c:when>
																	<c:otherwise>
																		<font color='#cccccc'>해당無</font>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											
											<td>
												${suitVO.regDate}
											</td>
											<td>
												<p <c:if test="${suitVO.suimRptState  eq 3}">title="${suitVO.suimCancelDateFmt}"</c:if> >
													<c:choose>
														<c:when test="${suitVO.delDate < 0}"><font color="red"><b>삭제</b></font></c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${suitVO.suimRptState  eq 1}"><font color="#0066ff">결재</font></c:when>
																<c:when test="${suitVO.suimRptState  eq 11}"><font color="#CC3300">반려</font></c:when>
																<c:when test="${suitVO.suimRptState  eq 2}">${suitVO.closeDate}</c:when>
																<c:when test="${suitVO.suimRptState  eq 3}">반송</c:when>
																<c:when test="${suitVO.suimRptState  eq 4}">소송</c:when>
																<c:when test="${suitVO.pastDateOld > 15}"><font color="fuchsia">${suitVO.pastDateOld}일</font></c:when>
																<c:otherwise>${suitVO.pastDateOld}일</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</p>
											</td>
										</tr>
										</c:forEach>
									</tbody>
			</table>
	<!-- //검색 결과 테이블 -->

</body>

</html>
