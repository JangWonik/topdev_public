<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=Suit12RptSearch.xls"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

	<h1>Suit12RptSearch.xls</h1>
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
										<colgroup>
											<col width="5%"/>
											<col width="5%"/>
											<col width="10%"/>
											<col width="10%"/>
											<col width="10%"/>
											<col width="9%"/>
											<col width="5%"/>
											<col width="5%"/>
											<col width="15%"/>
											<col width="8%"/>
											<col width="8%"/>
										</colgroup>
									<thead>
										<tr>
											<th>no.</th>
											<th>Lock</th>
											<th>접수번호</th>
											<th>종결번호</th>
											<th>보험사</th>
											<th>처리팀</th>
											<th>담당자</th>
											<th>물건구분</th>
											<th>계약자</th>
											<th>수임</th>
											<th>종결</th>
										</tr>
									</thead>
									<tbody>
										<!--  -->
										<c:forEach items="${suimSuit12List}" var="suit12VO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimSuit12Dtl('${suit12VO.suimRptNo}', '${suit17VO.delDate}')">
											<!-- no -->
											<td>${suimSuit12List.size() - status.index}</td>
											<!-- lock -->
											<td>
												<c:choose>
													<c:when test="${suit12VO.lockFlag eq 1}">
														보고서 잠금
													</c:when>
													<c:when test="${suit12VO.lockFlag eq 0}">
														보고서 열람가능
													</c:when>
												</c:choose>
											</td>
											<!-- 접수번호 -->
											<td>${suit12VO.suimAcceptNo}</td>
											<!-- 종결번호 -->
											<td>
												<c:choose>
													<c:when test="${suit12VO.suimCloseNo != ''}">${suit12VO.suimCloseNo}</c:when>
													<c:otherwise><font color="red">미결</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 보험사 -->
											<td>${suit12VO.ptnrNick}</td>
											<!-- 처리팀 -->
											<td>
												<c:if test="${not empty suit12VO.teamMark}">
													<span class="mark_alarm">${suit12VO.teamMark}</span>
												</c:if>
											</td>
											<!-- 담당자 -->
											<td>${suit12VO.userName}</td>
											<!-- 건물 -->
											<td>
											<c:choose>
												<c:when test="${suit12VO.bdType eq 1}">일반</c:when>
												<c:otherwise>공장</c:otherwise>
											</c:choose>
											</td>
											<!-- 계약자 -->
											<td>
												<c:choose>
													<c:when test="${suit12VO.policyholderNm != ''}">
														${suit12VO.policyholderNm}
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<!-- 수임 -->
											<td>${suit12VO.regDateFmt}</td>
											<!-- 종결 -->
											<td>
<%-- 												<p <c:if test="${suit12VO.suimRptState  eq 3}">title="${suit12VO.suim_cancelDate_fmt}"</c:if> > --%>
													<c:choose>
														<c:when test="${suit12VO.delDate < 0}"><font color="red">삭제</font></c:when>
														<c:when test="${suit12VO.suimRptState  eq 1}">결재</c:when>
														<c:when test="${suit12VO.suimRptState  eq 11}">반려</c:when>
														<c:when test="${suit12VO.suimRptState  eq 2}">${suit12VO.closeDateFmt}</c:when>
														<c:when test="${suit12VO.suimRptState  eq 3}">반송</c:when>
														<c:when test="${suit12VO.suimRptState  eq 4}">소송</c:when>
														<c:when test="${suit12VO.pastDate > 15}"><font color="fuchsia">${suit12VO.pastDate}일</font></c:when>
														<c:otherwise>${suit12VO.pastDate}일</c:otherwise>
													</c:choose>
<!-- 												</p> -->
											</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
			</table>
	<!-- //검색 결과 테이블 -->

</body>

</html>
