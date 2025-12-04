<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<script>
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
	</script>

							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" summary="고객리스트 현황1">
									<caption>고객리스트 현황1</caption>
									<colgroup>
										<col width="142" />
										<col width="94" />
										<col width="91" />
										<col width="123" />
										<col width="79" />
										<col width="79" />
										<col width="111" />
									</colgroup>
									<thead>
										<tr>
											<th>접수번호</th>
											<th>보험사</th>
											<th>건물구분</th>
											<th>계약자</th>
											<th>상태</th>
											<th>DAY</th>
											<th>수임일자</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${mainIndexSuit17List}" var="suit17VO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimSuit17Dtl('${suit17VO.suimRptNo}', '${suit17VO.delDate}')">
											<!-- 접수번호 -->
											<td>${suit17VO.suimAcceptNo}</td>
											<!-- 보험사 -->
											<td>${suit17VO.ptnrNick}</td>
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
											<!-- 상태 -->
											<td>미결</td>
											<!-- DAY -->
											<td>
												<c:choose>
													<c:when test="${suit17VO.pastDate > 15}"><font color="fuchsia">${suit17VO.pastDate}일</font></c:when>
													<c:otherwise>${suit17VO.pastDate}일</c:otherwise>
												</c:choose>
											</td>
											<!-- 수임일자 -->
											<td>${suit17VO.regDateFmt}</td>
											<!-- 종결 -->
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
