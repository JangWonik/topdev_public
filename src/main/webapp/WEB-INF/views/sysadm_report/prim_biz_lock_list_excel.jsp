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

	<h1>보고서 락 관리 primBizLockList.xls</h1>
	<br /><br />
	<!-- 검색 조건 테이블 -->
	<h2>검색 조건 테이블</h2>
			<table border="1">
									<thead>
										<tr>
											<th width="4%">no.</th>
											<th width="2%">-</th>
											<th width="6%">구분</th>
											<th width="6%">접수번호</th>
											<th width="6%">종결번호</th>
											<th width="6%">보험사</th>
											<th width="8%">보험팀</th>
											<th width="5%">보험담당</th>
											<th width="8%">처리팀</th>
											<th width="5%">담당자</th>
											<th width="8%">계약자</th>
											<th width="8%">피보험자</th>
											<th width="8%">피해자</th>
											<th width="5%">사고</th>
											<th width="5%">수임</th>
											<th width="5%">종결</th>
										</tr>
									</thead>
									<tbody>
										<!--  -->
										<c:forEach items="${rptPrimLocListExcel}" var="suimVO" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimDtl('${suimVO.suim_rpt_no}')">
											<!-- no -->
											<td>${suimVO.ROWNUM}</td>
											<!-- lock -->
											<td>
												<c:choose>
													<c:when test="${suimVO.lock_flag eq 1}">
													Lock
														<!-- <img src="./resources/ne_img/icon_lock.png" width="20px" height="20px" alt="보고서 잠금" /> -->
													</c:when>
													<c:when test="${suimVO.lock_flag eq 0}">
													Unlock
														<!-- <img src="./resources/ne_img/icon_unlock.png" width="20px" height="20px" alt="보고서 열람가능" /> -->
													</c:when>
												</c:choose>
											</td>
											<!-- 구분 -->
											<td title="${suimVO.suim_rpt_type1_nm}" >${suimVO.suim_rpt_type1_nm}</td>
											<!-- 접수번호 -->
											<td title="${suimVO.suim_accept_no}" >
												${suimVO.suim_accept_no}
												<c:if test="${suimVO.memo_cnt > 0}"><font color="#0066CC">[${suimVO.memo_cnt}]</font></c:if>
												<c:if test="${suimVO.file_cnt > 0}"><img src="./resources/ls_img/icon_disket.gif" width="10" height="10" border="0"></c:if>
											</td>
											<!-- 종결번호 -->
											<td title="${suimVO.suim_close_no}" >
												<c:choose>
													<c:when test="${suimVO.suim_close_no != ''}">${suimVO.suim_close_no}</c:when>
													<c:otherwise><font color="red">미결</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 보험사 -->
											<td title="${suimVO.ptnr_name}" >${suimVO.ptnr_nick}</td>
											<!-- 보험팀 -->
											<td title="${suimVO.ptnr_dept_nm}" >
												<c:choose>
													<c:when test="${fn:length(suimVO.ptnr_dept_nm) > 9}">
														${fn:substring(suimVO.ptnr_dept_nm,0,9)}...
													</c:when>
													<c:otherwise>${suimVO.ptnr_dept_nm}</c:otherwise>
												</c:choose>
											</td>
											<!-- 보험담당 -->
											<td title="${suimVO.ptnr_mbr_nm}" >${suimVO.ptnr_mbr_nm}</td>
											<!-- 처리팀 -->
											<td title="${suimVO.team_name}" >${suimVO.team_name}</td>
											<!-- 담당자 -->
											<td title="${suimVO.user_name}" >
												<c:choose>
													<c:when test="${suimVO.user_no > 0}">${suimVO.user_name}</c:when>
													<c:otherwise><font color="red">미배당</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 계약자 -->
											<td title="${suimVO.policyholder_nm}">
												<c:choose>
													<c:when test="${suimVO.policyholder_nm != ''}">
														<c:choose>
															<c:when test="${fn:length(suimVO.policyholder_nm) > 8}">
																${fn:substring(suimVO.policyholder_nm,0,8)}...
															</c:when>
															<c:otherwise>${suimVO.policyholder_nm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<!-- 피보험자 -->
											<td title="${suimVO.beneficiary_nm}" >
												<c:choose>
													<c:when test="${suimVO.beneficiary_nm != ''}">
														<c:choose>
															<c:when test="${fn:length(suimVO.beneficiary_nm) > 8}">
																${fn:substring(suimVO.beneficiary_nm,0,8)}...
															</c:when>
															<c:otherwise>${suimVO.beneficiary_nm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<!-- 피해자 -->
											<td title="${suimVO.damaged_nm}" >
												<c:choose>
													<c:when test="${suimVO.damaged_nm != ''}">
														<c:choose>
															<c:when test="${fn:length(suimVO.damaged_nm) > 8}">
																${fn:substring(suimVO.damaged_nm,0,8)}...
															</c:when>
															<c:otherwise>${suimVO.damaged_nm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<!-- 사고 -->
											<td title="${suimVO.accident_date_fmt}" >${suimVO.accident_date_fmt}</td>
											<!-- 수임 -->
											<td title="${suimVO.reg_date_fmt}" >${suimVO.reg_date_fmt}</td>
											<!-- 종결 -->
											<td>
												<p <c:if test="${suimVO.suim_rpt_state  eq 3}">title="${suimVO.suim_cancel_date_fmt}"</c:if> >
													<c:choose>
														<c:when test="${suimVO.suim_rpt_state  eq 1}"><font color="#0066ff">결재</font></c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 11}"><font color="#CC3300">반려</font></c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 2}">${suimVO.close_date_fmt}</c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 3}">반송</c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 4}">소송</c:when>
														<c:when test="${suimVO.past_date > 15}"><font color="fuchsia">${suimVO.past_date}일</font></c:when>
														<c:otherwise>${suimVO.past_date}일</c:otherwise>
													</c:choose>
												</p>
											</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>

</body>

</html>
