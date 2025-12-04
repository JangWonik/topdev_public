<%-- <% response.setCharacterEncoding("UTF-8"); %> --%>
<%-- <% response.setHeader("Content-Type", "application/vnd.ms-xls"); %> --%>
<%-- <% response.setHeader("Content-Disposition", "attachment;filename=SuimList.xls"); %> --%>

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

<%--
	<h1>PrimBizRptSearch.xls</h1>
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
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>종별구분</b></td>
						<td width="16%">
							<c:choose>
								<c:when test="${searchVO.type1Search == 0}">전체</c:when>
								<c:otherwise>
									<c:forEach items="${type1List}" var = "type1Vo">
										<c:if test="${searchVO.type1Search == type1Vo.col_cd}">${type1Vo.col_val}</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
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
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>보험사팀</b></td>
						<td width="16%">
							${searchVO.ptnrDeptNmSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>보험사담당자</b></td>
						<td width="18%">
							${searchVO.ptnrUserNmSearch}
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
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>계약자 주번</b></td>
						<td width="16%">
							<c:if test="${searchVO.policySsn1Search != '' || searchVO.policySsn2Search != ''}">
								${searchVO.policySsn1Search} - &nbsp;${searchVO.policySsn2Search}
							</c:if>
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>피보험자</b></td>
						<td width="16%">
							${searchVO.benefiNmSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>피보험자 주번</b></td>
						<td width="16%">
							<c:if test="${searchVO.benefiSsn1Search != '' || searchVO.benefiSsn2Search != ''}">
								${searchVO.benefiSsn1Search} - &nbsp;${searchVO.benefiSsn2Search}
							</c:if>
						</td>
					</tr>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>피해자/물</b></td>
						<td width="16%">
							${searchVO.damagedNmSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>사고번호</b></td>
						<td width="16%">
							${searchVO.accidentNoSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>증권번호</b></td>
						<td width="16%">
							${searchVO.policyNoSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>사고내용</b></td>
						<td width="16%">
							${searchVO.accidentFactsSearch}
						</td>
					</tr>
					<tr>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>접수번호</b></td>
						<td width="16%">
							${searchVO.acceptNoSearch}
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>모랄</b></td>
						<td width="16%">
							ㆍ 모랄건
								<c:choose>
									<c:when test="${searchVO.moralSearch == 'on'}"> O </c:when>
									<c:otherwise> X </c:otherwise>
								</c:choose>
						</td>
						<td width="8%" bgcolor="#e7ecf1" style="text-align:center;"><b>민원</b></td>
						<td width="16%">
							<c:choose>
								<c:when test="${searchVO.minwonSearch eq 0 || searchVO.minwonSearch eq null}">없음</c:when>
								<c:when test="${searchVO.minwonSearch == '1'}">예상</c:when>
								<c:when test="${searchVO.minwonSearch == '2'}">발생</c:when>
							</c:choose>
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
 --%>	
	
			<table border="1">
									<thead>
										<tr>
											<th bgcolor="#e7ecf1">접수번호</th>
											<th bgcolor="#e7ecf1">종결번호</th>
<!-- 											<th bgcolor="#e7ecf1">상태</th> -->
											<th bgcolor="#e7ecf1">처리팀</th>
											<th bgcolor="#e7ecf1">처리 담당자</th>
											<th bgcolor="#e7ecf1">처리 담당자 H.P.</th>
											<th bgcolor="#e7ecf1">보험사</th>
											<th bgcolor="#e7ecf1">보험사담당자</th>
											<th bgcolor="#e7ecf1">담당부서</th>
											<th bgcolor="#e7ecf1">담당팀</th>
											<th bgcolor="#e7ecf1">구분</th>
<!-- 											<th bgcolor="#e7ecf1">구분(Speed)</th> -->
											<th bgcolor="#e7ecf1">사고번호</th>
											<th bgcolor="#e7ecf1">증권번호</th>
											<th bgcolor="#e7ecf1">보험종목</th>
											
											<th bgcolor="#e7ecf1">기준업무량</th>
											<th bgcolor="#e7ecf1">기준업무량 종결건수</th>
											
											<th bgcolor="#e7ecf1">계약자</th>
											<th bgcolor="#e7ecf1">피보험자</th>
											<th bgcolor="#e7ecf1">피해자</th>
											<th bgcolor="#e7ecf1">사고내용</th>
<!-- 											<th bgcolor="#e7ecf1">사고장소</th> -->
<!-- 											<th bgcolor="#e7ecf1">현재진행사항</th> -->
<!-- 											<th bgcolor="#e7ecf1">문제점</th> -->
<!-- 											<th bgcolor="#e7ecf1">향후처리방안</th> -->
											<th bgcolor="#e7ecf1">사고일</th>
											<th bgcolor="#e7ecf1">수임일</th>
<!-- 											<th bgcolor="#e7ecf1">현장제출일</th> -->
<!-- 											<th bgcolor="#e7ecf1">중간제출일</th> -->
											<th bgcolor="#e7ecf1">총경과일</th>
<!-- 											<th bgcolor="#e7ecf1">과정경과일</th> -->
<!-- 											<th bgcolor="#e7ecf1">사고처리과정표1</th> -->
<!-- 											<th bgcolor="#e7ecf1">사고처리과정표2</th> -->
											<th bgcolor="#e7ecf1">종결일</th>
											<th bgcolor="#e7ecf1">추정손해액</th>
											<th bgcolor="#e7ecf1">추정수수료</th>
											<th bgcolor="#e7ecf1">종결구분</th>
											<th bgcolor="#e7ecf1">손해액</th>
											<th bgcolor="#e7ecf1">합의금액</th>
											<th bgcolor="#e7ecf1">자기부담금</th>
											<th bgcolor="#e7ecf1">지급보험금</th>
											<th bgcolor="#e7ecf1">절감액</th>
											<th bgcolor="#e7ecf1">기본보수</th>
											<th bgcolor="#e7ecf1">일비</th>
											<th bgcolor="#e7ecf1">교통비</th>
											<th bgcolor="#e7ecf1">자문료</th>
											<th bgcolor="#e7ecf1">기타</th>
											<th bgcolor="#e7ecf1">인보이스합계</th>
											<th bgcolor="#e7ecf1">수임등록자</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${primbizRptList}" var="suimVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimDtl('${suimVO.suim_rpt_no}')">
											<!-- 접수번호 -->
											<td>${suimVO.suim_accept_no}</td>
											<!-- 종결번호 -->
											<td>${suimVO.suim_close_no}</td>
											<!-- 상태 -->
<%-- 											<td>${suimVO.suim_rpt_state_nm}</td> --%>
											<!-- 처리팀 -->
											<td>${suimVO.team_name}</td>
											<!-- 처리 담당자 -->
											<td>${suimVO.user_name}</td>
											<!-- 처리 담당자 H.P. -->
											<td>${suimVO.handphone}</td>
											<!-- 보험사 -->
											<td>${suimVO.ptnr_name}</td>
											<!-- 보험사담당자 -->
											<td>${suimVO.ptnr_mbr_nm}</td>
											<!-- 종결된 경우는 종결시점 저장된 보험사 부서팀명으로 표시 by top3009 -->
											<c:choose>
												<c:when test="${suimVO.suim_rpt_state eq '2'}">
													<td>
														${suimVO.close_ptnr_dept_nm}
													</td>
													<!-- 담당 팀 -->											
													<td>
														${suimVO.close_ptnr_tm2_nm}
													</td>
												</c:when>
												<c:otherwise>
													<td>
														${suimVO.ptnr_dept_nm}
													</td>
													<!-- 담당 팀 -->											
													<td>
														${suimVO.ptnr_tm2_nm}
													</td>		
												</c:otherwise>
											</c:choose>
											<%-- <!-- 담당부서 -->
											<td>${suimVO.ptnr_dept_nm}</td>
											<!-- 담당팀 -->
											<td>${suimVO.ptnr_tm2_nm}</td> --%>
											<!-- 구분 -->
											<td>${suimVO.suim_rpt_type1_nm}</td>
											<!-- 구분(Speed):단순입력(비례보상) 0:스피드아님 1:단순입력 2:대인 3:대물 4:재물 5:대인+대물 -->
<!-- 											<td> -->
<%-- 												<c:choose> --%>
<%-- 													<c:when test="${suimVO.speed_type == 0}">스피드아님</c:when> --%>
<%-- 													<c:when test="${suimVO.speed_type == 1}">단순입력</c:when> --%>
<%-- 													<c:when test="${suimVO.speed_type == 2}">대인</c:when> --%>
<%-- 													<c:when test="${suimVO.speed_type == 3}">대물</c:when> --%>
<%-- 													<c:when test="${suimVO.speed_type == 4}">재물</c:when> --%>
<%-- 													<c:when test="${suimVO.speed_type == 5}">대인+대물</c:when> --%>
<%-- 													<c:otherwise> - </c:otherwise> --%>
<%-- 												</c:choose> --%>
<!-- 											</td> -->
											<!-- 사고번호 -->
											<td>${suimVO.accident_no}</td>
											<!-- 증권번호 -->
											<td>${suimVO.policy_no}</td>
											<!-- 보험종목 -->
											<td>${suimVO.insurance_nm}</td>

											<!-- 기준업무량 -->
											<td>${suimVO.workloadTypeVal}</td>											
											<!-- 기준업무량 종결건수-->
											<td>${suimVO.workloadEa}</td>											
											
											<!-- 계약자 -->
											<td>${suimVO.policyholder_nm}</td>
											<!-- 피보험자 -->
											<td>${suimVO.beneficiary_nm}</td>
											<!-- 피해자 -->
											<td>${suimVO.damaged_nm}</td>
											<!-- 사고내용 -->
											<td>${suimVO.accident_facts}</td>
											<!-- 사고장소 -->
<%-- 											<td>${suimVO.investigate_addr1}</td> --%>
											<!-- 현재진행사항 -->
<%-- 											<td>${suimVO.rpt_now_txt}</td> --%>
										<!-- 문제점 -->
<!-- 										<td></td> -->
										<!-- 향후처리방안 -->
<!-- 										<td></td> -->
											<!-- 사고일 -->
											<td>${suimVO.accident_date_fmt}</td>
											<!-- 수임일 -->
											<td>${suimVO.reg_date_fmt}</td>
											<!-- 현장제출일 -->
<%-- 											<td>${suimVO.site_date_fmt}</td> --%>
											<!-- 중간제출일 -->
<%-- 											<td>${suimVO.interim_date_fmt}</td> --%>
											<!-- 총경과일 -->
											<td>${suimVO.past_date}</td>
										<!-- 과정경과일 -->
<!-- 										<td> -->
<%-- 											${suimVO.past_date_ing} --%>
<!-- 										</td> -->
										<!-- 사고처리과정표1 -->
<%-- 										<td>${suimVO.control_date_cnt}</td> --%>
										<!-- 사고처리과정표2 -->
<%-- 										<td>${suimVO.control_memo}</td> --%>
											<!-- 종결일 -->
											<td>${suimVO.close_date_fmt}</td>
											<!-- 추정손해액 -->
											<td>${suimVO.amt_estimated_damage}</td>
											<!-- 추정수수료 -->
											<td>${suimVO.commission_estimated}</td>
											<!-- 종결구분 -->
											<td>
												<c:choose>
													<c:when test="${suimVO.suim_rpt_type1 eq '3' || suimVO.suim_rpt_type1 eq '4'}">
														<c:choose>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '1'}">유지/지급</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '2'}">유지/삭감</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '3'}">유지/면책</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '4'}">해지/지급</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '5'}">해지/삭감</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '6'}">해지/면책</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '7'}">부담보/지급</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '8'}">부담보/삭감</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close34 eq '9'}">부담보/면책</c:when>
															<c:otherwise> </c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${suimVO.suim_rpt_type1_close12 eq '1'}">부책</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close12 eq '2'}">면책</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close12 eq '3'}">청구포기</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close12 eq '4'}">구내치료비</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close12 eq '5'}">모럴</c:when>
															<c:when test="${suimVO.suim_rpt_type1_close12 eq '6'}">소송</c:when>
															<c:otherwise> </c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 손해액 -->
											<td>${suimVO.amt_claimed}</td>
											<!-- 합의금액 -->
											<td>${suimVO.amt_settlement}</td>
											<!-- 자기부담금 -->
											<td>${suimVO.amt_self_pay}</td>
											<!-- 지급보험금 -->
											<td>${suimVO.amt_insu_payment}</td>
											<!-- 절감액 -->
											<td>${suimVO.amt_reduction}</td>
											<!-- 기본보수 -->
											<td>${suimVO.amt_basic}</td>
											<!-- 일비 -->
											<td>${suimVO.amt_daily}</td>
											<!-- 교통비 -->
											<td>${suimVO.amt_traffic}</td>
											<!-- 자문료 -->
											<td>${suimVO.amt_counsel}</td>
											<!-- 기타 -->
											<td>${suimVO.amt_etc}</td>
											<!-- 인보이스합계 -->
											<td>${suimVO.amt_total}</td>
											<!-- 수임등록자 -->
											<td>${suimVO.registrant_nm}</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
			</table>
	<!-- //검색 결과 테이블 -->

</body>

</html>
