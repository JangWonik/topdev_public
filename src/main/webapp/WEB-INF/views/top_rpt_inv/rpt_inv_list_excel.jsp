<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=InvoiceList.xls"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
</head>

<body>

	<h1>InvoiceList.xls</h1>
	<br /><br />
	<!-- 검색 조건 테이블 -->
	<%-- <h2>검색 조건 테이블</h2>
			<table border="1">
				<tbody>
					<tr>
						<th width="7%" bgcolor="#e7ecf1">담당팀</th>
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
						<th width="7%" bgcolor="#e7ecf1">보험사</th>
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
						<th width="7%" bgcolor="#e7ecf1">종별구분</th>
						<td width="18%">
							<c:choose>
								<c:when test="${searchVO.type1Search == 0}">전체</c:when>
								<c:otherwise>
									<c:forEach items="${type1List}" var = "type1Vo">
										<c:if test="${searchVO.type1Search == type1Vo.col_cd}">${type1Vo.col_val}</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							ㆍ스피드
								<c:choose>
									<c:when test="${searchVO.speedCheck == 'on'}"> O </c:when>
									<c:otherwise> X </c:otherwise>
								</c:choose>
						</td>
						<th width="7%" bgcolor="#e7ecf1">제출일</th>
						<td width="22%">
							<c:if test="${searchVO.invoice_date_From != '' || searchVO.invoice_date_To != ''}">
								${searchVO.invoice_date_From} ~ &nbsp;${searchVO.invoice_date_To}
							</c:if>
							ㆍ 수정
								<c:choose>
									<c:when test="${searchVO.invDateEditCheck == 'on'}"> O </c:when>
									<c:otherwise> X </c:otherwise>
								</c:choose>
						</td>
					</tr>
					<tr>
						<th bgcolor="#e7ecf1">조사자</th>
						<td>${searchVO.userNmSearch}</td>
						<th bgcolor="#e7ecf1">보험사담당자</th>
						<td>${searchVO.ptnrUserNmSearch}</td>
						<th bgcolor="#e7ecf1">정렬기준</th>
						<td>
							<c:choose>
								<c:when test="${searchVO.orderBy == 'close_date'}">종결일</c:when>
								<c:when test="${searchVO.orderBy == 'invoice_date'}">제출일</c:when>
								<c:when test="${searchVO.orderBy == 'deposit_date'}">입금일</c:when>
							</c:choose>
						</td>
						<th bgcolor="#e7ecf1">종결일</th>
						<td>
							<c:if test="${searchVO.close_date_From != '' || searchVO.close_date_To != ''}">
								${searchVO.close_date_From} ~ &nbsp;${searchVO.close_date_To}
							</c:if>
						</td>
					</tr>
					<tr>
						<th bgcolor="#e7ecf1">피보험자</th>
						<td>${searchVO.benefiNmSearch}</td>
						<th bgcolor="#e7ecf1">계약자</th>
						<td>${searchVO.policyhNmSearch}</td>
						<th bgcolor="#e7ecf1">접수번호</th>
						<td>${searchVO.acceptNoSearch}</td>
						<th bgcolor="#e7ecf1">입금일</th>
						<td>
							<c:if test="${searchVO.deposit_date_From != '' || searchVO.deposit_date_To != ''}">
								${searchVO.deposit_date_From} ~ &nbsp;${searchVO.deposit_date_To}
							</c:if>
						</td>
					</tr>
					<tr>
						<th bgcolor="#e7ecf1">입금액</th>
						<td colspan="3">
							<c:if test="${searchVO.totAmtF != '' || searchVO.totAmtT != ''}">
								<fmt:formatNumber value="${searchVO.totAmtF}" pattern="###,###,##0.##"/> 원
								~ &nbsp;<fmt:formatNumber value="${searchVO.totAmtT}" pattern="###,###,##0.##"/> 원
							</c:if>
							ㆍ 미수
								<c:choose>
									<c:when test="${searchVO.depositNoCheck == 'on'}"> O </c:when>
									<c:otherwise> X </c:otherwise>
								</c:choose>
							ㆍ 수정
								<c:choose>
									<c:when test="${searchVO.amtEditCheck == 'on'}"> O </c:when>
									<c:otherwise> X </c:otherwise>
								</c:choose>
						</td>
						<th bgcolor="#e7ecf1">계산서No</th>
						<td>
							${searchVO.taxNoSearch}
							ㆍ 미발행
								<c:choose>
									<c:when test="${searchVO.taxNoCheck == 'on'}"> O </c:when>
									<c:otherwise> X </c:otherwise>
								</c:choose>
						</td>
						<th bgcolor="#e7ecf1">계산서</th>
						<td>
							<c:if test="${searchVO.tax_date_From != '' || searchVO.tax_date_To != ''}">
								${searchVO.tax_date_From} ~ &nbsp;${searchVO.tax_date_To}
							</c:if>
						</td>
					</tr>
				</tbody>
			</table> --%>
	<!-- //검색 조건 테이블 -->
	<br /><br />
	<!-- 검색 결과 테이블 -->
	<h2>검색 결과 테이블</h2>
			<table border="1">
				<thead>
					<tr>
						<th style="width:4%" bgcolor="#e7ecf1">구분</th>
						<th bgcolor="#e7ecf1">상세구분</th>
						<th bgcolor="#e7ecf1">보험사</th>
						<th bgcolor="#e7ecf1">센터명</th>
						<th bgcolor="#e7ecf1">지점</th>
						<th bgcolor="#e7ecf1">조사자</th>
						<th bgcolor="#e7ecf1">보험사팀</th>
						<th bgcolor="#e7ecf1">보험사담당자</th>
						<th bgcolor="#e7ecf1">접수번호</th>
						<th bgcolor="#e7ecf1">종결번호</th>
						<th bgcolor="#e7ecf1">증권번호</th>
						<th bgcolor="#e7ecf1">사고번호</th>
						<th bgcolor="#e7ecf1">보험종목</th>
						<th bgcolor="#e7ecf1">계약자</th>
						<th bgcolor="#e7ecf1">피보험자</th>
						<th bgcolor="#e7ecf1">접수일</th>
						<th bgcolor="#e7ecf1">종결일</th>
						<th bgcolor="#e7ecf1">입금일</th>
						<th bgcolor="#e7ecf1">계산서<br />재발행일</th>
						<th bgcolor="#e7ecf1">기본보수</th>
						<th bgcolor="#e7ecf1">결재수수료</th>
						<th bgcolor="#e7ecf1">일비</th>
						<th bgcolor="#e7ecf1">교통비</th>
						<th bgcolor="#e7ecf1">자문료</th>
						<th bgcolor="#e7ecf1">기타</th>
						<th bgcolor="#e7ecf1">계</th>
						<th style="width:4%" bgcolor="#e7ecf1">수정액</th>
						<th bgcolor="#e7ecf1">미수금</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${invList}" var="invVO">
						<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" >
							<!--구분-->
							<td>${invVO.suim_rpt_type1_nm}</td>
							<!-- 상세구분 -->
							<td>${invVO.suim_rpt_type3_nm}</td>
							<!--보험사-->
							<td>${invVO.ptnr_nick}</td>
							<!--센터명-->
							<td>
								<c:if test="${not empty invVO.center_name}">
									<span class="mark_alarm">${invVO.center_name}</span>
								</c:if>
							</td>
							<!--지점-->
							<td>
								<c:if test="${not empty invVO.team_mark}">
									<span class="mark_alarm">${invVO.team_mark}</span>
								</c:if>
							</td>
							<!--조사자-->
							<td>${invVO.user_nm}</td>
							<!-- 보험사팀 -->
							<td>${invVO.ptnr_dept_nm}</td>
							<!--담당자-->
							<td>${invVO.ptnr_mbr_nm_4edit}</td>
							<!--접수번호-->
							<td style="mso-number-format:'\@';">${invVO.suim_accept_no}</td>
							<!--종결번호-->
							<td>${invVO.suim_close_no}</td>
							<!--증권번호-->
							<td style="mso-number-format:'\@';">${invVO.policy_no}</td>
							<!--사고번호-->
							<td style="mso-number-format:'\@';">${invVO.accident_no}</td>
							<!--보험종목-->
							<td>${invVO.insurance_nm}</td>
							<!--계약자-->
							<td>${invVO.policyholder_nm}</td>
							<!--피보험자-->
							<td>${invVO.beneficiary_nm}</td>
							<!--접수일-->
							<td>${invVO.reg_date}</td>
							<!--종결일-->
							<td>${invVO.close_date_fmt}</td>
							<!--입금일-->
							<td>
									<c:choose>
										<c:when test="${invVO.deposit_date > 0}">
											${invVO.deposit_date_fmt}
										</c:when>
									</c:choose>
								<c:if test="${invVO.deposit_date == null || invVO.deposit_date < 1}">
									<c:set var="sum_not_deposit" value="${invVO.amt_total + sum_not_deposit}" />
								</c:if>
							</td>
							<!--계산서<br />재발행일-->
							<td>${invVO.tax_date_fmt}</td>
							
							<c:choose>
								<c:when test="${invVO.amt_approval > 0}">
									<!-- 기본보수 -->
									<td>
										<fmt:formatNumber value="${invVO.amt_basic - invVO.amt_approval}" pattern="###,###,##0.##"/>
									</td>
									<!-- 현대해상 결재수수료 -->
									<td>
										<fmt:formatNumber value="${invVO.amt_approval}" pattern="###,###,##0.##"/>										
									</td>
									<c:set var="sum_amt_basic" value="${invVO.amt_basic - invVO.amt_approval + sum_amt_basic}" />
									<c:set var="sum_amt_approval" value="${invVO.amt_approval + sum_amt_approval}" />
								</c:when>
								<c:otherwise>
									<!--기본보수-->
									<td><fmt:formatNumber value="${invVO.amt_basic}" pattern="###,###,##0.##"/></td>
									<!-- 현대해상 결재수수료 -->																		
									<td><fmt:formatNumber value="0" pattern="###,###,##0.##"/></td>
									<c:set var="sum_amt_basic" value="${invVO.amt_basic + sum_amt_basic}" />
								</c:otherwise>
							</c:choose>
							<!--일비-->
							<td><fmt:formatNumber value="${invVO.amt_daily}" pattern="###,###,##0.##"/></td>
							<c:set var="sum_amt_daily" value="${invVO.amt_daily + sum_amt_daily}" />
							<!--교통비-->
							<td><fmt:formatNumber value="${invVO.amt_traffic}" pattern="###,###,##0.##"/></td>
							<c:set var="sum_amt_traffic" value="${invVO.amt_traffic + sum_amt_traffic}" />
							<!--자문료-->
							<td><fmt:formatNumber value="${invVO.amt_counsel}" pattern="###,###,##0.##"/></td>
							<c:set var="sum_amt_counsel" value="${invVO.amt_counsel + sum_amt_counsel}" />
							<!--기타-->
							<td><fmt:formatNumber value="${invVO.amt_etc}" pattern="###,###,##0.##"/></td>
							<c:set var="sum_amt_etc" value="${invVO.amt_etc + sum_amt_etc}" />
							<!--계-->
							<td><fmt:formatNumber value="${invVO.amt_total}" pattern="###,###,##0.##"/></td>
							<c:set var="sum_amt_total" value="${invVO.amt_total + sum_amt_total}" />
							<!--수정-->
							<td>
								<c:choose>
									<c:when test="${invVO.modify_amout > 0}">
										<font color="blue">
											<fmt:formatNumber value="${invVO.modify_amout}" pattern="###,###,##0.##"/>
										</font>
									</c:when>
									<c:when test="${invVO.modify_amout < 0 }">
										<font color="red">
											<fmt:formatNumber value="${invVO.modify_amout}" pattern="###,###,##0.##"/>											
										</font>
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${invVO.modify_amout}" pattern="###,###,##0.##"/>
									</c:otherwise>
								</c:choose>
							</td>
							<!-- 미수금 -->
							<td>
								<c:if test="${invVO.deposit_date == null || invVO.deposit_date < 1}">
									<font color="red"><fmt:formatNumber value="${invVO.amt_total}" pattern="###,###,##0.##"/></font>
								</c:if>
							</td>							
						</tr>
					</c:forEach>
					<tr>
						<td colspan="19" bgcolor="#e7ecf1">현재 페이지 합계</td>
						<td><fmt:formatNumber value="${sum_amt_basic}" pattern="###,###,##0.##"/></td>
						<td><fmt:formatNumber value="${sum_amt_approval}" pattern="###,###,##0.##"/></td>
						<td><fmt:formatNumber value="${sum_amt_daily}" pattern="###,###,##0.##"/></td>
						<td><fmt:formatNumber value="${sum_amt_traffic}" pattern="###,###,##0.##"/></td>
						<td><fmt:formatNumber value="${sum_amt_counsel}" pattern="###,###,##0.##"/></td>
						<td><fmt:formatNumber value="${sum_amt_etc}" pattern="###,###,##0.##"/></td>
						<td><fmt:formatNumber value="${sum_amt_total}" pattern="###,###,##0.##"/></td>
						<td></td>
						<td>
							<font color="red"><fmt:formatNumber value="${sum_not_deposit}" pattern="###,###,##0.##"/></font>
						</td>
					</tr>
				</tbody>
			</table>
	<!-- //검색 결과 테이블 -->
	<br /><br />
	<!-- 총계 테이블 -->
	<h2>총계 테이블</h2>
		<table border="1">
				<tr>
					<th rowspan="2" bgcolor="#e7ecf1">총합계</th>
					<th bgcolor="#e7ecf1">기본보수</th>
					<th bgcolor="#e7ecf1">일비</th>
					<th bgcolor="#e7ecf1">교통비</th>
					<th bgcolor="#e7ecf1">자문료</th>
					<th bgcolor="#e7ecf1">기타</th>
					<th bgcolor="#e7ecf1">합계</th>
					<th bgcolor="#e7ecf1">미수금</th>
				</tr>
				<tr>
					<td><fmt:formatNumber value="${totVO.totAmtBasic}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtDaily}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtTraffic}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtCounsel}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtEtc}" pattern="###,###,##0.##"/></td>
					<td><fmt:formatNumber value="${totVO.totAmtTotal}" pattern="###,###,##0.##"/></td>
					<td><font color="red"><fmt:formatNumber value="${totAmtNotDeposit}" pattern="###,###,##0.##"/></font></td>
				</tr>																					
		</table>
	<!-- //총계 테이블 -->

</body>

</html>
