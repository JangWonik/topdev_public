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

			$("#mainSearchSuit18ExcelBtn").click(function(){
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));
				$("#searchMainQueryForm").attr("action","searchMainQuerySuit18Excel");
				searchMainQueryForm.submit();
			});
		});//ready

		function popSuit18Dtl(suim_rpt_no, delDate){
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
			window.open('popSuit18Dtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function reqPgNoClickSuit18(pgNo){
			searchMainPagingForm.reqPgNo.value = pgNo;
			searchMainPagingForm.presentPage.value = "suit18rpttab";
			searchMainPagingForm.submit();
		}
	</script>

			<p style="margin-bottom:1px;text-align:right;">
				적부 삼성 검색 불가 항목 : 종별구분/보험사팀/보험사담당자/계약자주민번호/피보험자/피보험자주민번호/피해자/사고번호/사고내용/모랄/민원&nbsp;&nbsp;&nbsp;
				<!-- 엑셀다운로드는 권한이있는 직원만 가능하도록 변경 by top3009 -->
				<c:if test="${mbrAuthVo_Session.mbr_pms_33 eq '1'}">
				<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="mainSearchSuit18ExcelBtn" />
				</c:if>
			</p>

							<div class= "tableStyle2" >
								<table class="srchResultTable">
									<thead >
										<tr > <!-- #E7ECF1 -->
											<th  rowspan="2" width="2%" >no.</th>
											<th  rowspan="2" width="2%">Lock</th>
											<th  rowspan="2" width="5%">접수번호</th>
											<th  rowspan="2" width="5%">종결번호</th>
											<th  rowspan="2" width="4%">보험사</th>
											<th  rowspan="2" width="5%">처리팀</th>
											<th  rowspan="2" width="4%">담당자</th>
											<th  rowspan="2" width="2%">건물구분</th>
											<th  rowspan="2" width="5%">계약자</th>
											<th  colspan="2" width="4%">SMS</th>
											<th  rowspan="2" width="4%">수임</th>
											<th  rowspan="2" width="4%">종결</th>
										</tr>
										<tr>
											<th>모집인</th>
											<th>계약자</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${suitList18}" var="suitVO" varStatus="status" > 
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;" onclick="popSuit18Dtl('${suitVO.suimRptNo}', '${suitVO.delDate}');">
											<!-- no -->
											<td>${suit18RptListTotCnt - (18 * (reqPgNoInt318 - 1)) - status.index}</td>
											<!-- lock -->
											<td>
												<c:if test="${suitVO.lockFlag eq 1}">
													<img src="./resources/ne_img/icon_lock.png" width="20px" height="20px" alt="보고서 잠금" />
												</c:if>
												<c:if test="${suitVO.lockFlag eq 0}">
													<img src="./resources/ne_img/icon_unlock.png" width="20px" height="20px" alt="보고서 열람가능" />
												</c:if>
											</td>
											<!-- suim_accept_no -->
											<td title="${suitVO.suimAcceptNo}">
												${suitVO.suimAcceptNo}
											</td>
											<!-- suim_close_no -->
											<td title="${suitVO.suimCloseNo}" >
												<c:choose>
													<c:when test="${suitVO.suimCloseNo != ''}">${suitVO.suimCloseNo}</c:when>
													
													<c:otherwise>
														<c:choose>
															<c:when test="${suitVO.suimRptState == 3}">반송</c:when>
															<c:when test="${suitVO.suimRptState == 4}">소송</c:when>
															<c:otherwise><font color="red">미결</font></c:otherwise>
															<%--<c:when test="${suitVO.suimRptState  eq 3}">반송</c:when>--%>
															<%--<c:when test="${suitVO.suimRptState  eq 4}">소송</c:when>--%>
															<%--<c:otherwise>--%>
																<%--<font color="red">미결</font>--%>
															<%--</c:otherwise>--%>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 보험사 -->
											<td title="${suitVO.ptnrName}" >${suitVO.ptnrNick}</td>
											<!-- 처리팀 -->
											<td title="${suitVO.teamName}" >
												<c:if test="${not empty suitVO.teamMark}">
													<span class="mark_alarm">${suitVO.teamMark}</span>
												</c:if>
											</td>
											<!-- 담당자 -->
											<td title="${suitVO.userName}" >
												<c:choose>
													<c:when test="${suitVO.userNo > 0}">
														<c:choose>
															<c:when test="${fn:length(suitVO.userName) > 3}">
																${fn:substring(suitVO.userName,0,3)}...
															</c:when>
															<c:otherwise>${suitVO.userName}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise><font color="red">미배당</font></c:otherwise>
												</c:choose>
											</td>
											<!-- 건물 -->
											<td title="${suitVO.bdType}" >
												<c:choose>
													<c:when test="${suitVO.bdType eq '1'}">일반</c:when>
													<c:otherwise>
														공장
													</c:otherwise>
												</c:choose>
											</td>
											<!-- 계약자 -->
											<td title="${suitVO.policyholderNm}">
												<c:choose>
													<c:when test="${suitVO.policyholderNm != ''}">
														<c:choose>
															<c:when test="${fn:length(suitVO.policyholderNm) > 8}">
																${fn:substring(suitVO.policyholderNm,0,8)}...
															</c:when>
															<c:otherwise>${suitVO.policyholderNm}</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${suitVO.suimRptState >1 }">
														-
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${suitVO.conCnt1 > 0}">
																발송
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${suitVO.clerkHndPhoneNo ne '' 
															and (
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '010') or 
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '011') or 
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '016') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '017') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '018') or
																(fn:substring(suitVO.clerkHndPhoneNo,0,3) eq '019')
															)
															}">
																		<font color='#CC3300'>미발송</font>
																	</c:when>
																	<c:otherwise>
																		<font color='#cccccc'>해당無</font>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${suitVO.suimRptState >1 }">
														-
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${suitVO.conCnt2 > 0}">
																발송
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${suitVO.conHndPhoneNo ne '' 
															and (
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '010') or 
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '011') or 
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '016') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '017') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '018') or
																(fn:substring(suitVO.conHndPhoneNo,0,3) eq '019')
															)
															}">
																		<font color='#CC3300'>미발송</font>
																	</c:when>
																	<c:otherwise>
																		<font color='#cccccc'>해당無</font>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</td>
											
											<td>
												${suitVO.regDate}
											</td>
											<td>
												<p <c:if test="${suitVO.suimRptState  eq 3}">title="${suitVO.suimCancelDateFmt}"</c:if> >
													<c:choose>
														<c:when test="${suitVO.delDate < 0}"><font color="red"><b>삭제</b></font></c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${suitVO.suimRptState  eq 1}"><font color="#0066ff">결재</font></c:when>
																<c:when test="${suitVO.suimRptState  eq 11}"><font color="#CC3300">반려</font></c:when>
																<c:when test="${suitVO.suimRptState  eq 2}">${suitVO.closeDate}</c:when>
																<c:when test="${suitVO.suimRptState  eq 3}">반송</c:when>
																<c:when test="${suitVO.suimRptState  eq 4}">소송</c:when>
																<c:when test="${suitVO.pastDateOld > 15}"><font color="fuchsia">${suitVO.pastDateOld}일</font></c:when>
																<c:otherwise>${suitVO.pastDateOld}일</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</p>
											</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->

	<!-- page start -->
		<c:if test="${pgNm318 != null}">
			<p style="text-align:center;">
				<c:if test="${startPgNoInt318 > 18}">
					<a href="javascript:reqPgNoClickSuit18(${startPgNoInt318 - 1});">&lt;</a>
				</c:if>
				<c:forEach var="pageNo" begin="${startPgNoInt318}" end="${endPgNoInt318}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt318 != pageNo}">
							<a href="javascript:reqPgNoClickSuit18(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${totPgCntInt318 >= endPgNoInt318 + 1}">
					<a href="javascript:reqPgNoClickSuit18(${endPgNoInt318 + 1});">&gt;</a>
				</c:if>
			</p>
		</c:if>
	<!-- //page end -->
