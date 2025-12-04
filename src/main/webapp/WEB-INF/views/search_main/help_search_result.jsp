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
		});//ready

		function popSuimDtl(serialNo, editYN){
// 			if(editYN < 1){
// 				alert("열람 권한이 없습니다.");
// 				return;
// 			}
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=705; //띄울 창의 넓이
			var sh=470;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('helpRptBscDtl?serialNo='+serialNo,'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function reqPgNoClickHelp(pgNo){
			helpSearchPagingForm.reqPgNo.value = pgNo;
			helpSearchPagingForm.submit();
		}
	</script>

							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="4%">no.</th>
											<th width="10%">의뢰팀</th>
											<th width="10%">의뢰인</th>
											<th width="10%">수임팀</th>
											<th width="10%">수임인</th>
											<th width="8%">보고서번호</th>
											<th width="10%">피보험자</th>
											<th width="10%">의뢰일</th>
											<th width="10%">완료일</th>
											<th width="6%">상태</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${helpBookList}" var="helpVo" varStatus="status" >
										<tr id = "${helpVo.serialNo}" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimDtl('${helpVo.serialNo}','${helpVo.editYN}');">
											<td>${helpBookListTotCnt - (18 * (reqPgNoInt1 - 1)) - status.index}</td>
											<td>${helpVo.clientTm}</td>
											<td>${helpVo.clientMbr}</td>
											<td>${helpVo.acceptTm}</td>
											<td>${helpVo.acceptMbr}</td>
											<td>${helpVo.acceptNo}</td>
											<td>${helpVo.beneficiaryNm}</td>
											<td>${helpVo.regDate}</td>
											<c:choose>
												<c:when test="${helpVo.helpState eq '완료' }">
													<td>${helpVo.endDate}</td>
												</c:when>
												<c:otherwise>
													<td>-</td>
												</c:otherwise>
											</c:choose>
											<td>${helpVo.helpState}</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->

	<!-- page start -->
		<c:if test="${pgNm1 != null}">
			<p style="text-align:center;">
				<c:if test="${startPgNoInt1 > 10}">
					<a href="javascript:reqPgNoClickHelp(${startPgNoInt1 - 1});">&lt;</a>
				</c:if>
				<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt1 != pageNo}">
							<a href="javascript:reqPgNoClickHelp(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
					<a href="javascript:reqPgNoClickHelp(${endPgNoInt1 + 1});">&gt;</a>
				</c:if>
			</p>
		</c:if>
	<!-- //page end -->
