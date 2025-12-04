<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

							<p><b>보고서 열람 기록</b></p>

							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th> 번 호 </th>
											<th> 시 간 </th>
											<th> 접 근 I P </th>
											<th> 이 름 </th>
										</tr>
									</thead>
									<tbody>
										<!-- 보고서 열람 기록 -->
										<c:forEach items="${suimRptBscDtlReadLogList}" var="readLogVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'"
											onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
											<!-- 번 호 -->
											<td>${suimRptBscDtlReadLogList.size() - status.index}</td>
											<!-- 시 간 -->
											<td>${readLogVO.reg_date_fmt_detail}</td>
											<!-- 접 근 I P -->
											<td>${readLogVO.user_ip}</td>
											<!-- 이 름 -->
											<td>${readLogVO.user_nm}</td>
										</tr>
										</c:forEach>
										<!-- //보고서 열람 기록 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->

							<br />

							<p><b>보고서 파일 다운로드 기록</b></p>

							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="10%"> 번 호 </th>
											<th width="45%"> 파 일 이 름 </th>
											<th width="15%"> 시 간 </th>
											<th width="15%"> 접 근 I P </th>
											<th width="15%"> 이 름 </th>
										</tr>
									</thead>
									<tbody>
										<!-- 보고서 파일 다운로드 기록 -->
										<c:forEach items="${suimRptBscDtlFileLogList}" var="fileLogVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'"
											onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
											<!-- 번 호 -->
											<td>${suimRptBscDtlFileLogList.size() - status.index}</td>
											<!-- 파 일 이 름 -->
											<td>${fileLogVO.file_name}</td>
											<!-- 시 간 -->
											<td>${fileLogVO.reg_date_fmt_detail}</td>
											<!-- 접 근 I P -->
											<td>${fileLogVO.user_ip}</td>
											<!-- 이 름 -->
											<td>${fileLogVO.user_nm}</td>
										</tr>
										</c:forEach>
										<!-- //보고서 파일 다운로드 기록 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							<br />
							<p><b>보고서 결재 및 변경 기록</b></p>

							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th>타입</th>
											<th width="5%">상태</th>
											<th width="5%">종결</th>
											<th>수임일</th>
											<th width="7%">수임취소일</th>
											<th>상신일</th>
											<th>종결일</th>
											<th>삭제일</th>
											<th>Lock</th>
											<th>모랄</th>
											<th>민원</th>
											<th width="10%">로그일</th>
											<th>IP</th>
											<th>이름</th>
										</tr>
									</thead>
									<tbody>
										<!-- 보고서 결재 기록 -->
										<c:forEach items="${suimRptBscDtlLogList}" var="logVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'"
											onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
											<!-- 번호 -->
											<td>${suimRptBscDtlLogList.size() - status.index}</td>
											<!-- 타입 -->
											<td>${logVO.suim_rpt_type1_nm}</td>
											<!-- 상태 -->
											<td>${logVO.suim_rpt_state_nm}</td>
											<!-- 종결 -->
											<c:choose>
												<c:when test="${logVO.suim_rpt_type1 == 3 || logVO.suim_rpt_type1 == 4}">
													<td>${logVO.suim_rpt_type1_close34_nm}</td>
												</c:when>
												<c:otherwise>
													<td>${logVO.suim_rpt_type1_close12_nm}</td>
												</c:otherwise>
											</c:choose>
											<!-- 수임일 -->
											<td>${logVO.reg_date_fmt}</td>
											<!-- 수임취소일 -->
											<td>${logVO.suim_cancel_date_fmt}</td>
											<!-- 상신일 -->
											<td>${logVO.suim_rpt_aprv_date_fmt}</td>
											<!-- 종결일 -->
											<td>${logVO.close_date_fmt}</td>
											<!-- 삭제일 -->
											<td>${logVO.del_date_fmt}</td>
											<!-- Lock -->
											<td>${logVO.lock_flag_nm}</td>
											<!-- 모랄 -->
											<td>${logVO.moral_flag_nm}</td>
											<!-- 민원 -->
											<td>${logVO.minwon_flag_nm}</td>
											<!-- 로그일 -->
											<td>${logVO.log_date_fmt_detail}</td>
											<!-- IP -->
											<td>${logVO.log_ip}</td>
											<!-- 이름 -->
											<td>${logVO.log_user_nm}</td>
										</tr>
										</c:forEach>
										<!-- //보고서 결재 기록 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->							
							
							<br />
							<p><b>보고서 담당자 변경 기록</b></p>

							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th>담당부서</th>
											<th>담당자</th>
											<th>로그일</th>
											<th>IP</th>
											<th>이름</th>
										</tr>
									</thead>
									<tbody>
										<!-- 보고서 변경기록 -->
										<c:forEach items="${suimRptBscDtlLogList}" var="logVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'"
											onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
											<!-- 번호 -->
											<td>${suimRptBscDtlLogList.size() - status.index}</td>
											<!-- 담당부서 -->
											<td>${logVO.team_nm}</td>
											<!-- 담당자 -->
											<td>${logVO.user_nm}</td>											
											<!-- 로그일 -->
											<td>${logVO.log_date_fmt_detail}</td>
											<!-- IP -->
											<td>${logVO.log_ip}</td>
											<!-- 이름 -->
											<td>${logVO.log_user_nm}</td>
										</tr>
										</c:forEach>
										<!-- //보고서 결재 기록 -->
									</tbody>
								</table>
							</div>
