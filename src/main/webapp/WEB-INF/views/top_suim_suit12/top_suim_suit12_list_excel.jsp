<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=InvoiceList.xls"); %>

<%@ page language="java" contentType="vnd.ms-xls; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="application/vnd.ms-xls; charset=UTF-8">
	<meta charset="UTF-8">
</head>

<body>

	<h1>적부(한화) suimSuit12List.xls</h1>
	<br /><br />
	<!-- 검색 조건 테이블 -->
	<h2>검색 조건 테이블</h2>
			<table border="1">
				<thead>
					<tr>
						<th>no.</th>
						<th>Lock</th>
						<th>접수번호</th>
						<th>종결번호</th>
						<th>증권번호</th>
						<th>설계번호</th>
						<th>소재지주소</th>
						<th>영위업종명</th>
						<th>보험사</th>
						<th>처리팀</th>
						<th>담당자</th>
						<th>건물</th>
						<th>계약자</th>
						<th>수임</th>
						<th>종결</th>
					</tr>
				</thead>
				<tbody>
					<!--  -->
					<c:forEach items="${getSuimSuit12ListExcel}" var="suit12VO" > <!-- begin="1" end="20" step="1" -->
					<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
					style ="cursor:pointer;" onclick="popSuimSuit12Dtl('${suit12VO.suimRptNo}')">
						<!-- no -->
						<td>${suit12VO.ROWNUM}</td>
						<!-- lock -->
						<td>
							<c:choose>
								<c:when test="${suit12VO.ridLock eq 1}">
									lock
								</c:when>
								<c:when test="${suit12VO.ridLock eq 0}">
									unlock
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
						
						<td>${suit12VO.rqPlyNo}</td>
						<td>${suit12VO.rqPlNo}</td>
						<!-- 소재지주소 -->
						<td>${suit12VO.rqBld_CtnAdr}</td>
						<!-- 영위업종명 -->
						<td>${suit12VO.rqBld_MngmBnNm}</td>
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
									<c:choose>
										<c:when test="${fn:length(suit12VO.policyholderNm) > 8}">
											${fn:substring(suit12VO.policyholderNm,0,8)}...
										</c:when>
										<c:otherwise>${suit12VO.policyholderNm}</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</td>
						<!-- 수임 -->
						<td>${suit12VO.regDateFmt}</td>
						<!-- 종결 -->
						<td>
							<%-- <p <c:if test="${suit12VO.suimRptState  eq 3}">title="${suit12VO.suim_cancel_date_fmt}"</c:if> > --%>
								<c:choose>
									<c:when test="${suit12VO.suimRptState  eq 1}">결재</c:when>
									<c:when test="${suit12VO.suimRptState  eq 11}">반려</c:when>
									<c:when test="${suit12VO.suimRptState  eq 2}">${suit12VO.closeDateFmt}</c:when>
									<c:when test="${suit12VO.suimRptState  eq 3}">반송</c:when>
									<c:when test="${suit12VO.suimRptState  eq 4}">소송</c:when>
									<c:when test="${suit12VO.pastDate > 15}"><font color="fuchsia">${suit12VO.pastDate}일</font></c:when>
									<c:otherwise>${suit12VO.pastDate}일</c:otherwise>
								</c:choose>
							<!-- </p> -->
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>

</body>

</html>
