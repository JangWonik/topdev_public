<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});

		function popSuimDtl(suim_rpt_no, delDate){
			if(delDate < 0){
				alert("삭제된 보고서 입니다.");
				return;
			}	
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function reqPgNoClick1(pgNo){
			myNoMainPagingForm.reqPgNo.value = pgNo;
			myNoMainPagingForm.presentPage.value = "mynositetab";
			myNoMainPagingForm.submit();
		}
	</script>

							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="3%">no.</th>
											<th width="2%">-</th>
											<th width="5%">구분</th>
											<th width="7%">접수번호</th>
											<th width="6%">종결번호</th>
											<th width="6%">보험사</th>
											<th width="7%">보험팀</th>
											<th width="5%">보험담당</th>
											<th width="5%">처리팀</th>
											<th width="5%">담당자</th>
											<th width="8%">계약자</th>
											<th width="8%">피보험자</th>
											<th width="8%">피해자</th>
											<th width="5%">사고</th>
											<th width="5%">수임</th>
											<th width="5%">현장</th>
											<th width="5%">중간</th>
											<th width="5%">상태</th>
										</tr>
									</thead>
									<tbody>
										<!--  -->
										<c:forEach items="${myNoSiteList}" var="suimVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimDtl('${suimVO.suim_rpt_no}', '${suimVO.delDate}')">
											<!-- no -->
											<td>${totCntIntForListNo1 - (18 * (reqPgNoInt1 - 1)) - status.index}</td>
											<!-- lock -->
											<td>
												<c:if test="${suimVO.lock_flag eq 1}">
													<img src="./resources/ne_img/icon_lock.png" width="20px" height="20px" alt="보고서 잠금" />
												</c:if>
												<c:if test="${suimVO.lock_flag eq 0}">
													<img src="./resources/ne_img/icon_unlock.png" width="20px" height="20px" alt="보고서 열람가능" />
												</c:if>
											</td>
											<!-- suim_rpt_type1 -->
											<td title="${suimVO.suim_rpt_type1_nm}" >${suimVO.suim_rpt_type1_nm}</td>
											<!-- suim_accept_no -->
											<td title="${suimVO.minwon_flag_nm}" >
												<c:choose>
													<c:when test="${suimVO.minwon_flag == 1}">
														<font color="BLUE">${suimVO.suim_accept_no}</font>
													</c:when>
													<c:when test="${suimVO.minwon_flag == 2}">
														<font color="RED">${suimVO.suim_accept_no}</font>
													</c:when>
													<c:otherwise>${suimVO.suim_accept_no}</c:otherwise>
												</c:choose>
												<c:if test="${suimVO.memo_cnt > 0}"><font color="#0066CC">[${suimVO.memo_cnt}]</font></c:if>
												<c:if test="${suimVO.file_cnt > 0}"><img src="./resources/ls_img/icon_disket.gif" width="10" height="10" border="0"></c:if>
											</td>
											<!-- suim_close_no -->
											<td title="${suimVO.suim_close_no}" >
												<c:choose>
													<c:when test="${suimVO.suim_close_no != '' and suimVO.suim_close_no != null}">${suimVO.suim_close_no}</c:when>
													<c:otherwise><font color="red">미결</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 보험사 -->
											<td title="${suimVO.ptnr_name}" >${suimVO.ptnr_nick}</td>
											<!-- 보험팀 -->
											<td title="${suimVO.ptnr_dept_nm}" >
												<c:choose>
													<c:when test="${fn:length(suimVO.ptnr_dept_nm) > 6}">
														${fn:substring(suimVO.ptnr_dept_nm,0,6)}...
													</c:when>
													<c:otherwise>${suimVO.ptnr_dept_nm}</c:otherwise>
												</c:choose>
											</td>
											<!-- 보험담당 -->
											<td title="${suimVO.ptnr_mbr_nm}" >
												<c:choose>
													<c:when test="${fn:length(suimVO.ptnr_mbr_nm) > 3}">
														${fn:substring(suimVO.ptnr_mbr_nm,0,3)}...
													</c:when>
													<c:otherwise>${suimVO.ptnr_mbr_nm}</c:otherwise>
												</c:choose>
											</td>
											<!-- 처리팀 -->
											<td title="${suimVO.team_name}" >
												<c:if test="${not empty suimVO.team_mark}">
													<span class="mark_alarm">${suimVO.team_mark}</span>
												</c:if>
											</td>
											<!-- 담당자 -->
											<td title="${suimVO.user_name}" >
												<c:choose>
													<c:when test="${suimVO.user_no > 0}">
														<c:choose>
															<c:when test="${fn:length(suimVO.user_name) > 3}">
																${fn:substring(suimVO.user_name,0,3)}...
															</c:when>
															<c:otherwise>${suimVO.user_name}</c:otherwise>
														</c:choose>
													</c:when>
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
											<td title="${suimVO.rpt_now_txt}" >${suimVO.reg_date_fmt}</td>
											<!-- 현장 -->
											<td title="${suimVO.site_date_fmt}" >${suimVO.site_date_fmt}</td>
											<!-- 중간 -->
											<td title="${suimVO.interim_date_fmt}" >${suimVO.interim_date_fmt}</td>
											<!-- 종결 -->
											<td <c:if test="${suimVO.delDate != 0}">bgcolor="pink"</c:if>>
												<p <c:if test="${suimVO.suim_rpt_state  eq 3}">title="${suimVO.suim_cancel_date_fmt}"</c:if> >
													<c:choose>
														<c:when test="${suimVO.delDate < 0}"><font color="red"><b>삭제</b></font></c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${suimVO.suim_rpt_state  eq 1}"><font color="#0066ff">결재</font></c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 11}"><font color="#CC3300">반려</font></c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 2}">${suimVO.close_date_fmt}</c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 3}">반송</c:when>
																<c:when test="${suimVO.suim_rpt_state  eq 4}">소송</c:when>
																<c:when test="${suimVO.past_date > 15}"><font color="fuchsia">${suimVO.past_date}일</font></c:when>
																<c:otherwise>${suimVO.past_date}일</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</p>
											</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->

	<!-- page start -->
		<c:if test="${pgNm1 != null}">
			<p style="text-align:center;">
				<c:if test="${startPgNoInt1 > 10}">
					<a href="javascript:reqPgNoClick1(${startPgNoInt1 - 1});">&lt;</a>
				</c:if>
				<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt1 != pageNo}">
							<a href="javascript:reqPgNoClick1(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
					<a href="javascript:reqPgNoClick1(${endPgNoInt1 + 1});">&gt;</a>
				</c:if>
			</p>
		</c:if>
	<!-- //page end -->
