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

			$("#mainSearchPrimBizExcelBtn").click(function(){
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));
				$("#searchMainQueryForm").attr("action","searchMainQueryPrimBizExcel");
				searchMainQueryForm.submit();
			});
		});//ready

		function popSuimDtlPrimBiz(suim_rpt_no, del_date){
			if(del_date == -1){
				alert("삭제된 보고서 입니다.");
				return;
			}
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('primBizRptDtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function reqPgNoClickPrimBiz(pgNo){
			searchMainPagingForm.reqPgNo.value = pgNo;
			searchMainPagingForm.presentPage.value = "primbizrpttab";
			searchMainPagingForm.submit();
		}
	</script>
			<!-- 엑셀다운로드는 권한이있는 직원만 가능하도록 변경 by top3009 -->
			<c:if test="${mbrAuthVo_Session.mbr_pms_33 eq '1'}">
			<p style="margin-bottom:1px;text-align:right;">
				<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="mainSearchPrimBizExcelBtn" />
			</p>
			</c:if>

							<div class= "tableStyle2">
								<table class="srchResultTable">
									<thead>
										<tr>
											<th width="4%">no.</th>
											<th width="2%">-</th>
											<th width="6%">구분</th>
											<th width="9%">접수번호</th>
											<th width="6%">종결번호</th>
											<th width="6%">보험사</th>
											<th width="8%">보험팀</th>
											<th width="5%">보험담당</th>
											<th width="5%">처리팀</th>
											<th width="5%">담당자</th>
											<th width="8%">계약자</th>
											<th width="8%">피보험자</th>
											<th width="8%">피해자</th>
											<th width="5%">사고</th>
											<th width="5%">수임</th>
											<th width="5%">상태</th>
										</tr>
									</thead>
									<tbody>
										<!--  -->
										<c:forEach items="${primbizRptList}" var="suimVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimDtlPrimBiz('${suimVO.suim_rpt_no}', '${suimVO.del_date}')">
											<!-- no -->
											<td>${primbizRptListTotCnt - (18 * (reqPgNoInt201 - 1)) - status.index}</td>
											<!-- lock -->
											<td>
												<c:choose>
													<c:when test="${suimVO.lock_flag eq 1}">
														<img src="./resources/ne_img/icon_lock.png" width="20px" height="20px" alt="보고서 잠금" />
													</c:when>
													<c:when test="${suimVO.lock_flag eq 0}">
														<img src="./resources/ne_img/icon_unlock.png" width="20px" height="20px" alt="보고서 열람가능" />
													</c:when>
												</c:choose>
											</td>
											<!-- 구분 -->
											<td title="${suimVO.suim_rpt_type1_nm}" >${suimVO.suim_rpt_type1_nm}</td>
											<!-- 접수번호 -->
											<td title="${suimVO.suim_accept_no} ${suimVO.minwon_flag_nm}" >
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
											<!-- 종결번호 -->
											<td title="${suimVO.suim_close_no}" >
												<c:choose>
													<c:when test="${suimVO.suim_close_no != '' and suimVO.suim_close_no != null}">${suimVO.suim_close_no}</c:when>
													<c:when test="${suimVO.suim_rpt_state == 3}">반송</c:when>
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
											<td title="${suimVO.team_name}" >
												<c:if test="${not empty suimVO.team_mark}">
													<span class="mark_alarm">${suimVO.team_mark}</span>
												</c:if>
											</td>
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
														<c:when test="${suimVO.del_date eq -1}"><font color="red">삭제</font></c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 1}"><font color="#0066ff">결재</font></c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 11}"><font color="#CC3300">반려</font></c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 2}">${suimVO.close_date_fmt}</c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 3}">반송</c:when>
														<c:when test="${suimVO.suim_rpt_state  eq 31}"><font color=#C5A700>위임취소중</font></c:when>
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
							</div><!-- //tableStyle2 -->

	<!-- page start -->
		<c:if test="${pgNm201 != null}">
			<p style="text-align:center;">
				<c:if test="${startPgNoInt201 > 10}">
					<a href="javascript:reqPgNoClickPrimBiz(${startPgNoInt201 - 1});">&lt;</a>
				</c:if>
				<c:forEach var="pageNo" begin="${startPgNoInt201}" end="${endPgNoInt201}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt201 != pageNo}">
							<a href="javascript:reqPgNoClickPrimBiz(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${totPgCntInt201 >= endPgNoInt201 + 1}">
					<a href="javascript:reqPgNoClickPrimBiz(${endPgNoInt201 + 1});">&gt;</a>
				</c:if>
			</p>
		</c:if>
	<!-- //page end -->
