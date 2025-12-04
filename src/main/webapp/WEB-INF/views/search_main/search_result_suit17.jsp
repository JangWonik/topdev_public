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

			$("#mainSearchSuit17ExcelBtn").click(function(){
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));
				$("#searchMainQueryForm").attr("action","searchMainQuerySuit17Excel");
				searchMainQueryForm.submit();
			});
		});//ready

		function popSuimSuit17Dtl(suimRptNo, delDate){
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
			window.open('topSuimSuit17Dtl?suimRptNo='+suimRptNo,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function reqPgNoClickSuit17(pgNo){
			searchMainPagingForm.reqPgNo.value = pgNo;
			searchMainPagingForm.presentPage.value = "suit17rpttab";
			searchMainPagingForm.submit();
		}
	</script>

			<p style="margin-bottom:1px;text-align:right;">
				적부 흥국 검색 불가 항목 : 종별구분/보험사팀/보험사담당자/계약자주민번호/피보험자/피보험자주민번호/피해자/사고번호/증권번호/사고내용/모랄/민원&nbsp;&nbsp;&nbsp;
				<!-- 엑셀다운로드는 권한이있는 직원만 가능하도록 변경 by top3009 -->
				<c:if test="${mbrAuthVo_Session.mbr_pms_33 eq '1'}">
				<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="mainSearchSuit17ExcelBtn" />
				</c:if>
			</p>

							<div class= "tableStyle2">
								<table class="srchResultTable">
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
											<th>건물</th>
											<th>계약자</th>
											<th>수임</th>
											<th>종결</th>
										</tr>
									</thead>
									<tbody>
										<!--  -->
										<c:forEach items="${suimSuit17List}" var="suit17VO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimSuit17Dtl('${suit17VO.suimRptNo}', '${suit17VO.delDate}')">
											<!-- no -->
											<td>${suit17RptListTotCnt - (18 * (reqPgNoInt317 - 1)) - status.index}</td>
											<!-- lock -->
											<td>
												<c:choose>
													<c:when test="${suit17VO.lockFlag eq 1}">
														<img src="./resources/ne_img/icon_lock.png" width="20px" height="20px" alt="보고서 잠금" />
													</c:when>
													<c:when test="${suit17VO.lockFlag eq 0}">
														<img src="./resources/ne_img/icon_unlock.png" width="20px" height="20px" alt="보고서 열람가능" />
													</c:when>
												</c:choose>
											</td>
											<!-- 접수번호 -->
											<td>${suit17VO.suimAcceptNo}</td>
											<!-- 종결번호 -->
											<td>
												<c:choose>
													<c:when test="${suit17VO.suimCloseNo ne '' and suit17VO.suimCloseNo ne null}">
														${suit17VO.suimCloseNo}
													</c:when>
													<c:when test="${suit17VO.suimRptState == 3}">반송</c:when>
													<c:otherwise><font color="red">미결</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 보험사 -->
											<td>${suit17VO.ptnrNick}</td>
											<!-- 처리팀 -->
											<td>
												<c:if test="${not empty suit17VO.teamMark}">
													<span class="mark_alarm">${suit17VO.teamMark}</span>
												</c:if>
											</td>
											<!-- 담당자 -->
											<td>${suit17VO.userName}</td>
											<!-- 건물 -->
											<td>
											<c:choose>
												<c:when test="${suit17VO.bdType eq 1}">일반</c:when>
												<c:otherwise>공장</c:otherwise>
											</c:choose>
											</td>
											<!-- 계약자 -->
											<td>
												<c:choose>
													<c:when test="${suit17VO.policyholderNm != ''}">
														<c:choose>
															<c:when test="${fn:length(suit17VO.policyholderNm) > 8}">
																${fn:substring(suit17VO.policyholderNm,0,8)}...
															</c:when>
															<c:otherwise>${suit17VO.policyholderNm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<!-- 수임 -->
											<td>${suit17VO.regDateFmt}</td>
											<!-- 종결 -->
											<td>
<%-- 												<p <c:if test="${suit17VO.suimRptState  eq 3}">title="${suit17VO.suim_cancel_date_fmt}"</c:if> > --%>
													<c:choose>
														<c:when test="${suit17VO.delDate < 0}"><font color="red">삭제</font></c:when>
														<c:when test="${suit17VO.suimRptState  eq 1}">결재</c:when>
														<c:when test="${suit17VO.suimRptState  eq 11}">반려</c:when>
														<c:when test="${suit17VO.suimRptState  eq 2}">${suit17VO.closeDateFmt}</c:when>
														<c:when test="${suit17VO.suimRptState  eq 3}">반송</c:when>
														<c:when test="${suit17VO.suimRptState  eq 4}">소송</c:when>
														<c:when test="${suit17VO.pastDate > 15}"><font color="fuchsia">${suit17VO.pastDate}일</font></c:when>
														<c:otherwise>${suit17VO.pastDate}일</c:otherwise>
													</c:choose>
<!-- 												</p> -->
											</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->

	<!-- page start -->
		<c:if test="${pgNm317 != null}">
			<p style="text-align:center;">
				<c:if test="${startPgNoInt317 > 10}">
					<a href="javascript:reqPgNoClickSuit17(${startPgNoInt317 - 1});">&lt;</a>
				</c:if>
				<c:forEach var="pageNo" begin="${startPgNoInt317}" end="${endPgNoInt317}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt317 != pageNo}">
							<a href="javascript:reqPgNoClickSuit17(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${totPgCntInt317 >= endPgNoInt317 + 1}">
					<a href="javascript:reqPgNoClickSuit17(${endPgNoInt317 + 1});">&gt;</a>
				</c:if>
			</p>
		</c:if>
	<!-- //page end -->
							