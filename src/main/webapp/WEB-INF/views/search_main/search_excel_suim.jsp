<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
// 	response.setCharacterEncoding("UTF-8");
// 	response.setHeader("Content-Type", "application/vnd.ms-xls");
// 	response.setHeader("Content-Disposition", "attachment;filename=sss.xls");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
</head>

<body>

<%--
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
	<br /><br />--%>
	<!-- 검색 결과 테이블 -->
			<table border="1">
									<thead>
										<tr>
											<th bgcolor="#e7ecf1">접수번호</th>
											<th bgcolor="#e7ecf1">종결번호</th>
											<th bgcolor="#e7ecf1">상태</th>
											<th bgcolor="#e7ecf1">과정관리</th>
											<%--<th bgcolor="#e7ecf1">처리팀그룹</th>--%>
											<th bgcolor="#e7ecf1">센터명</th>
											<th bgcolor="#e7ecf1">처리팀</th>
											<th bgcolor="#e7ecf1">처리 담당자</th>
											<th bgcolor="#e7ecf1">처리 담당자 H.P.</th>
											
											<c:if test="${searchVO.type1Search == 140}">
												<th bgcolor="#e7ecf1">현장 조사 담당부서</th>
												<th bgcolor="#e7ecf1">현장 조사 담당자</th>
												<th bgcolor="#e7ecf1">현장 조사 담당자 H.P.</th>											
											</c:if>
											
											<th bgcolor="#e7ecf1">보험사</th>
											<th bgcolor="#e7ecf1">보험사담당자</th>
											<th bgcolor="#e7ecf1">담당부서</th>
											<th bgcolor="#e7ecf1">담당팀</th>
											<c:if test="${searchVO.type1Search eq '3' || searchVO.type1Search eq '4' || searchVO.type1Search eq '22'}">
												<th bgcolor="#e7ecf1">지정건 구분</th>
												<th bgcolor="#e7ecf1">보험사 상세 구분</th>
											</c:if>											
											
											<th bgcolor="#e7ecf1">구분</th>
											<th bgcolor="#e7ecf1">구분(Speed)</th>
											<th bgcolor="#e7ecf1">사고번호</th>
											<th bgcolor="#e7ecf1">증권번호</th>
											<th bgcolor="#e7ecf1">보험종목</th>
											<!-- <th bgcolor="#e7ecf1">보험조건</th> -->
											
											<th bgcolor="#e7ecf1">기준업무량</th>
											<th bgcolor="#e7ecf1">기준업무량 종결건수</th>
											
											<th bgcolor="#e7ecf1">계약자</th>
											<th bgcolor="#e7ecf1">피보험자</th>
											<th bgcolor="#e7ecf1">피해자</th>
											<th bgcolor="#e7ecf1">사고내용</th>
											<th bgcolor="#e7ecf1">사고장소</th>

                                            <!-- <th bgcolor="#e7ecf1">사고처리과정표1</th>
                                            <th bgcolor="#e7ecf1">사고처리과정표2</th> -->
                                            
                                            <th bgcolor="#e7ecf1">사고처리과정표</th>

											<th bgcolor="#e7ecf1">미결사유</th>
											<th bgcolor="#e7ecf1">문제점</th>
											<th bgcolor="#e7ecf1">향후처리방안</th>
											<th bgcolor="#e7ecf1">과정관리메모</th>
											

                                            <th bgcolor="#e7ecf1">청구금액</th>
                                            <th bgcolor="#e7ecf1">추정손해액</th>
                                            <th bgcolor="#e7ecf1">선견적</th>
                                            <th bgcolor="#e7ecf1">선견적업체명</th>
                                            <th bgcolor="#e7ecf1">독립손사</th>
                                            <th bgcolor="#e7ecf1">손해평가서류</th>
                                            <th bgcolor="#e7ecf1">민원</th>
                                            <th bgcolor="#e7ecf1">민원발생일</th>
                                            
                                            <th bgcolor="#e7ecf1">보험사기</th>
                                            <th bgcolor="#e7ecf1">공문수신일</th>
                                            
                                            <th bgcolor="#e7ecf1">추정수수료</th>

                                            <th bgcolor="#e7ecf1">사고일</th>
											<th bgcolor="#e7ecf1">수임일</th>
											<th bgcolor="#e7ecf1">현장제출일</th>
											<!-- <th bgcolor="#e7ecf1">일정제출일</th> -->
											<th bgcolor="#e7ecf1">중간제출일</th>
											<th bgcolor="#e7ecf1">총경과일</th>
											<th bgcolor="#e7ecf1">과정경과일</th>
											<th bgcolor="#e7ecf1">종결예정일</th>
											<th bgcolor="#e7ecf1">종결일</th>
											
											<th bgcolor="#e7ecf1">종결구분</th>
											<th bgcolor="#e7ecf1">손해액</th>
											<th bgcolor="#e7ecf1">합의금액</th>
											<th bgcolor="#e7ecf1">자기부담금</th>
											<th bgcolor="#e7ecf1">지급보험금</th>
											<th bgcolor="#e7ecf1">절감액</th>
											<th bgcolor="#e7ecf1">기본보수</th>
											<th bgcolor="#e7ecf1">결재수수료</th>
											<th bgcolor="#e7ecf1">일비</th>
											<th bgcolor="#e7ecf1">교통비</th>
											<th bgcolor="#e7ecf1">자문료</th>
											<th bgcolor="#e7ecf1">기타</th>
											<th bgcolor="#e7ecf1">인보이스합계</th>
											<th bgcolor="#e7ecf1">수임등록자</th>
											<th bgcolor="#e7ecf1">입금일</th>
											<th bgcolor="#e7ecf1">부서상세 구분</th>
											<th bgcolor="#e7ecf1">장기/일반 구분</th>
											<!-- 위임취소일, 위임취소사유 추가 by top3009 김두현부장요청사항 20240717-->
											<th bgcolor="#e7ecf1">위임취소일</th>
											<th bgcolor="#e7ecf1">위임취소사유</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${suimBookList}" var="suimVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimDtl('${suimVO.suim_rpt_no}')">
											<!-- 접수번호 -->
											<td>${suimVO.suim_accept_no}</td>
											<!-- 종결번호 -->
											<td>${suimVO.suim_close_no}</td>
											<!-- 상태 -->
											<td>${suimVO.suim_rpt_state_nm}</td>
											<%-- 과정관리 추가 --%>
											<td>
												<c:choose>
													<c:when test="${suimVO.pendncy_trget_at eq 1}">대상</c:when>
													<c:when test="${suimVO.pendncy_trget_at eq 2}">비대상</c:when>
													<c:when test="${suimVO.pendncy_trget_at eq 3}">과정관리</c:when>
													<c:when test="${suimVO.pendncy_trget_at eq 4}">현장+과정관리</c:when>
													<c:otherwise>없음</c:otherwise>
												</c:choose>
											</td>
											
                                            <%--처리팀 그룹--%>
                                            <%--<td>${suimVO.pTeamName}</td>--%>
                                            <!-- 처리팀 -->
											<td>
												 ${suimVO.pTeamName} 
                                                <%-- <c:choose>
                                                    <c:when test="${suimVO.team_id == '56'
                                                                    || suimVO.team_id == '63'
                                                                    || suimVO.team_id == '98'
                                                                    || suimVO.team_id == '99'
                                                                    || suimVO.team_id == '9'
                                                                    || suimVO.team_id == '8'
                                                                    || suimVO.team_id == '104'
                                                                    || suimVO.team_id == '105'
                                                                    || suimVO.team_id == '39'
                                                                    || suimVO.team_id == '132'
                                                                    }">
                                                        ${suimVO.pTeamName} - ${suimVO.team_name}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${suimVO.team_name}
                                                    </c:otherwise>
                                                </c:choose> --%>
                                            </td>
                                            <td>
                                            	${suimVO.team_name}
                                            </td>
											<!-- 처리 담당자 -->
											<td>
												${suimVO.user_name}
											</td>
											<!-- 처리 담당자 H.P. -->
											<td>
												${suimVO.handphone}
											</td>
											
											<!-- 원스탑 현장 조사 담당자 -->
											<c:if test="${searchVO.type1Search == 140}">
												<td>${suimVO.onestopTeamNm}</td>
												<td>${suimVO.onestopMbrNm}</td>
												<td>${suimVO.onestopMbrHandphone}</td>											
											</c:if>											
											
											<!-- 보험사 -->
											<td>${suimVO.ptnr_name}</td>
											<!-- 보험사담당자 -->
											<td>
												${suimVO.ptnr_mbr_nm}
											</td>
											<!-- 담당부서 -->
											
											<!-- 종결된 경우는 종결시점 저장된 보험사 부서팀명으로 표시 by top3009 -->
											<c:choose>
												<c:when test="${suimVO.suim_rpt_state_nm eq '종결'}">
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
											
											<c:if test="${searchVO.type1Search eq '3' || searchVO.type1Search eq '4' || searchVO.type1Search eq '22'}">
												<td>
													<c:choose>
														<c:when test="${suimVO.ptnrAssignGubun eq '0'}">비지정</c:when>
														<c:when test="${suimVO.ptnrAssignGubun eq '1'}">지정</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose>
												</td>
												<td>
													<c:choose>
														<c:when test="${suimVO.ptnrDetailGubun eq '1'}">원수사</c:when>
														<c:when test="${suimVO.ptnrDetailGubun eq '2'}">자회사</c:when>
														<c:when test="${suimVO.ptnrDetailGubun eq '3'}">외주사</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose>												
												</td>
											</c:if>
											
											<!-- 구분 -->
											<td>${suimVO.suim_rpt_type1_nm}</td>
											<!-- 구분(Speed):단순입력(비례보상) 0:스피드아님 1:단순입력 2:대인 3:대물 4:재물 5:대인+대물 -->
											<td>
												<c:choose>
													<c:when test="${suimVO.speed_type == 0}">스피드아님</c:when>
													<c:when test="${suimVO.speed_type == 1}">단순입력</c:when>
													<c:when test="${suimVO.speed_type == 11}">간이(타사)</c:when>
													<c:when test="${suimVO.speed_type == 12}">간이(구내치료비)</c:when>
													<c:when test="${suimVO.speed_type == 13}">간이(홀인원)</c:when>
													<c:when test="${suimVO.speed_type == 2}">대인</c:when>
													<c:when test="${suimVO.speed_type == 3}">대물</c:when>
													<c:when test="${suimVO.speed_type == 4}">재물</c:when>
													<c:when test="${suimVO.speed_type == 41}">재물(6대가전)</c:when>
													<c:when test="${suimVO.speed_type == 42}">재물(도난)</c:when>
													<c:when test="${suimVO.speed_type == 43}">재물(골프용품)</c:when>
													<c:when test="${suimVO.speed_type == 44}">재물(풍수재)</c:when>
													<c:when test="${suimVO.speed_type == 45}">재물(여행자)</c:when>
													<c:when test="${suimVO.speed_type == 46}">재물(위로금)</c:when>
													<c:when test="${suimVO.speed_type == 47}">재물(일반)</c:when>
													<c:when test="${suimVO.speed_type == 5}">대인+대물</c:when>
													<c:when test="${suimVO.speed_type == 6}">임의종결</c:when>
													<c:when test="${suimVO.speed_type == 7}">임의종결</c:when>
													<c:otherwise> - </c:otherwise>
												</c:choose>
											</td>
											<!-- 사고번호 -->
											<td>${suimVO.accident_no}</td>
											<!-- 증권번호 -->
											<td>${suimVO.policy_no}</td>
											<!-- 보험종목 -->
											<td>${suimVO.insurance_nm}</td>
											<!-- 보험조건 -->
											<%-- <td>${suimVO.insu_condition}</td> --%>
											<!-- 기준업무량 상세코드 -->
											<td>${suimVO.workloadTypeVal}</td>
											<!-- 기준업무량 종결건수 -->
											<td>${suimVO.workloadEa}</td>
											<!-- 계약자 -->
											<td>${suimVO.policyholder_nm}</td>
											<!-- 피보험자 -->
											<td>${suimVO.beneficiary_nm}</td>
											<!-- 피해자 -->
											<td>${suimVO.damaged_nm}</td>
											<!-- 사고내용 -->
											<td>${suimVO.accident_facts}</td>
											<!-- 사고장소 상세주소 기준으로 표시 (20250226 김두현 이사 요청사항)-->
											<%-- <td>${suimVO.investigate_addr1}</td> --%>
											<td>${suimVO.investigate_addr2}</td>
											
                                            <%-- <!-- 사고처리과정표1 -->
                                            <td>${suimVO.control_date_cnt}</td>
                                            <!-- 사고처리과정표2 -->
                                            <td>${suimVO.control_memo}</td> --%>
                                            <!-- 신규 사고처리 과정표 -->
                                            <td>${suimVO.sagoTotalMsg}</td>
                                            
                                            <!-- 미결사유 -->
                                            <td>${suimVO.now_memo}</td>
                                            <!-- 문제점 -->
                                            <td>${suimVO.prb_memo}</td>
                                            <!-- 향후처리방안 -->
                                            <td>${suimVO.pln_memo}</td>
                                            <!-- 과정관리 메모 -->
                                            <td>${suimVO.processManageMemo}</td>
                                            <!-- 청구금액 -->
                                            <td>${suimVO.amt_claimed}</td>

                                            <!-- 추정손해액 -->
                                            <td>${suimVO.amt_estimated_damage}</td>
                                            <!-- 선견적여부 -->
                                            <td>
                                                <c:if test="${suimVO.pre_estmt_at == '1'}">여</c:if>
                                                <c:if test="${suimVO.pre_estmt_at == '2'}">부</c:if>
                                            </td>
                                            <!-- 선견적업체명 -->
                                            <td>${suimVO.pre_estmt_cmpy}</td>
                                            <!-- 독립손사유무 -->
                                            <td>
                                                <c:if test="${suimVO.ind_ajmdmge_ennc == '1'}">무</c:if>
                                                <c:if test="${suimVO.ind_ajmdmge_ennc == '2'}">유</c:if>
                                            </td>
                                            <!-- 손해평가서류 -->
                                            <td>
                                                <c:if test="${suimVO.doc_rcept_at == '1'}">여</c:if>
                                                <c:if test="${suimVO.doc_rcept_at == '2'}">부</c:if>
                                            </td>

                                            <!-- 민원 -->
                                            <td>
                                                <c:if test="${suimVO.minwon_flag == '0'}">없음</c:if>
                                                <c:if test="${suimVO.minwon_flag == '1'}">민원예상</c:if>
                                                <c:if test="${suimVO.minwon_flag == '2'}">민원발생</c:if>
                                            </td>
                                            <td>${suimVO.minwon_date}</td>

                                            <!-- 보험사기 -->
                                            <td>
                                                <c:if test="${suimVO.moral_flag == '0'}">조사중</c:if>
                                                <c:if test="${suimVO.moral_flag == '1'}">해당</c:if>
                                                <c:if test="${suimVO.moral_flag == '2'}">해당없음</c:if>
                                            </td>
											<td>${suimVO.moral_date}</td>

                                            <!-- 추정수수료 -->
                                            <td>${suimVO.commission_estimated}</td>

											<!-- 사고일 -->
											<td>${suimVO.accident_date_fmt}</td>
											<!-- 수임일 -->
											<td>${suimVO.reg_date_fmt}</td>											
											<!-- 현장 -->
											<!-- 현장 보고서 (물보험은 현장보고서결재일, 인보험은 기존 중간보고서 최신으로 표시 -->
											<!-- 현장제출일 -->
											<c:choose>
												<c:when test="${suimVO.suim_rpt_type1 eq 3 or suimVO.suim_rpt_type1 eq 4}">
													<td title="${suimVO.site_date_fmt}" >${suimVO.site_date_fmt}</td>
												</c:when>
												<c:otherwise>
													<td title="${suimVO.site_rpt_aprv_date_fmt}" >${suimVO.site_rpt_aprv_date_fmt}</td>		
												</c:otherwise>
											</c:choose>																						
											<!-- 일정제출일 -->
											<%-- <td>${suimVO.schedule_date_fmt}</td> --%>
											<!-- 중간제출일 -->
											<td>${suimVO.interim_date_fmt}</td>
											<!-- 총경과일 -->
											<td>${suimVO.past_date}</td>
											<!-- 과정경과일 -->
											<td>
												${suimVO.past_date_ing}
											</td>

											<!-- 종결예정일 -->
											<td>${suimVO.closePrarnDate}</td>
											<!-- 종결일 -->
											<td>${suimVO.close_date_fmt}</td>

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
											<c:choose>
												<c:when test="${suimVO.amt_approval > 0}">
													<!-- 기본보수 -->
													<%-- <td>${suimVO.amt_basic - suimVO.amt_approval}</td> --%>
													<td>${suimVO.amt_basic}</td>
													<!-- 현대해상 결재수수료 -->
													<td>${suimVO.amt_approval}</td>
												</c:when>
												<c:otherwise>
													<!-- 기본보수 -->
													<td>${suimVO.amt_basic}</td>
													<!-- 현대해상 결재수수료 -->
													<td>0</td>		
												</c:otherwise>
											</c:choose>
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
											<!-- 입금일 -->
											<td>
												<c:choose>
													<c:when test="${empty suimVO.deposit_date_fmt}">정보없음</c:when>
													<c:otherwise>${suimVO.deposit_date_fmt}</c:otherwise>
												</c:choose>
											</td>
											<td>${suimVO.ptnr_id_sub_nm}</td>										
											<!-- 장기/일반 구분 -->
											<td>${suimVO.period_flag_nm}</td>
											<!-- 위임취소일자 -->
											<td>${suimVO.suim_cancel_date_fmt}</td>
											<!-- 위임취소사유 -->
											<td>${suimVO.cancel_reason}</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
			</table>
	<!-- //검색 결과 테이블 -->

</body>

</html>
