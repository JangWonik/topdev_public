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

			$("#mainSearchSuit10ExcelBtn").click(function(){
				$("#tmGubun").val($("#tmSearch option:selected").text().indexOf("└"));
				$("#ptnrGubun").val($("#ptnrSearch option:selected").text().indexOf("└"));
				$("#searchMainQueryForm").attr("action","searchMainQuerySuit10Excel");
				searchMainQueryForm.submit();
			});
		});//ready

		function popSuit10Dtl(suim_rpt_no, delDate){
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
			window.open('popSuit10Dtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function reqPgNoClickSuit10(pgNo){
			searchMainPagingForm.reqPgNo.value = pgNo;
			searchMainPagingForm.presentPage.value = "suit10rpttab";
			searchMainPagingForm.submit();
		}
	</script>

			<p style="margin-bottom:1px;text-align:right;">
				적부 KB 검색 불가 항목 : 종별구분/보험사팀/보험사담당자/계약자주민번호/피보험자/피보험자주민번호/피해자/사고번호/사고내용/모랄/민원&nbsp;&nbsp;&nbsp;
				<!-- 엑셀다운로드는 권한이있는 직원만 가능하도록 변경 by top3009 -->
				<c:if test="${mbrAuthVo_Session.mbr_pms_33 eq '1'}">
				<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="mainSearchSuit10ExcelBtn" />
				</c:if>
			</p>

							<div class= "tableStyle2" >
								<table class="srchResultTable">
									<thead>
										<tr>
											<th width="2%">no.</th>
											<th width="2%">Lock</th>
											<th width="5%">접수번호</th>
											<th width="5%">종결번호</th>
											<th width="7%">보험사</th>
											<th width="5%">처리팀</th>
											<th width="5%">담당자</th>
											<th width="2%">구분</th>
											<th width="5%">계약자</th>
											<th width="4%">수임</th>
											<th width="4%">종결</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${suitList10}" var="suitVO" varStatus="status" > 
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;" onclick="popSuit10Dtl('${suitVO.suimRptNo}', '${suitVO.delDate}');">
											<!-- no -->
											<td>${suit10RptListTotCnt - (18 * (reqPgNoInt310 - 1)) - status.index}</td>
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
													<c:when test="${suitVO.suimCloseNo != '' and suitVO.suimCloseNo != null}">${suitVO.suimCloseNo}</c:when>
													<c:when test="${suitVO.suimRptState == 3}">반송</c:when>
													<c:otherwise><font color="red">미결</font></c:otherwise>
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
													<c:when test="${suitVO.bdType eq '01'}">일반</c:when>
													<c:when test="${suitVO.bdType eq '02'}">공장</c:when>
													<c:when test="${suitVO.bdType eq '99'}">아파트</c:when>
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
		<c:if test="${pgNm310 != null}">
			<p style="text-align:center;">
				<c:if test="${startPgNoInt310 > 10}">
					<a href="javascript:reqPgNoClickSuit10(${startPgNoInt310 - 1});">&lt;</a>
				</c:if>
				<c:forEach var="pageNo" begin="${startPgNoInt310}" end="${endPgNoInt310}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt310 != pageNo}">
							<a href="javascript:reqPgNoClickSuit10(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${totPgCntInt310 >= endPgNoInt310 + 1}">
					<a href="javascript:reqPgNoClickSuit10(${endPgNoInt310 + 1});">&gt;</a>
				</c:if>
			</p>
		</c:if>
	<!-- //page end -->
							