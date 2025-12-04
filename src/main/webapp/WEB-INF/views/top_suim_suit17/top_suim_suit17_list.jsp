<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null){
				window.location.assign("./logout");
			}
		});//ready
	</script>
	<c:set value="${suimSuit17List}" var="suimSuit17List"/>
	<script>
		function popSuimSuit17Dtl(suimRptNo, delDate){
			if(delDate != 0){
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
		
		/* 날짜 검색 버튼 동작 */
		function dateSelectBtn(){
			datef.submit();
		}
		
		$(document).ready(function(){
			/***** excelBtn *****/
			$("#excelBtn").click(function(){
				$("#hiddenFrom").val($("#selectorFrom").val());
				$("#hiddenTo").val($("#selectorTo").val());
				$("#suit17SearchForm").attr("action","topSuimSuit17List_Excel");
				$("#suit17SearchForm").submit();
			});
			/***** searchBtn *****/
			$("#searchBtn").click(function(){
				$("#hiddenFrom").val($("#selectorFrom").val());
				$("#hiddenTo").val($("#selectorTo").val());
				$("#suit17SearchForm").attr("action","topSuimSuit17List");
				$("#suit17SearchForm").submit();
			});
			
			/* 응답전문 */
			$("#Suit17ListRs").click(function(){
				$("#hiddenFrom").val($("#selectorFrom").val());
				$("#hiddenTo").val($("#selectorTo").val());
				$("#suit17SearchForm").attr("action","topSuimSuit17List_Rs");
				$("#suit17SearchForm").submit();
			});
				
		
		});//ready
	</script>
	
	<style>
		.tableStyle2 td{
			letter-spacing: 0px !important;
		}
	</style>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">적부(흥국)</a></li>
							</ul>

							<form id="suit17SearchForm" method="GET">
								<input type="hidden" id="hiddenFrom" name="hiddenFrom" />
								<input type="hidden" id="hiddenTo" name="hiddenTo" />
							
							<p align="right" style="margin-top:5px;"> 종결일 :
								<input type="text" id="selectorFrom" name="viewFromDate" size="10" value="${viewFromDate}" maxlength="10" />
								<font color="#0066CC">부터&nbsp&nbsp&nbsp</font>
								<input type="text" id="selectorTo"  name="viewToDate" size="10"  value="${viewToDate}" maxlength="10" /> 
								<font color="#0066CC">까지</font>
								<img src="./resources/ls_img/ls_report/btn_src.gif" border="0" style ="cursor:pointer;" id="searchBtn" />
								<input type="image" src="./resources/ls_img/report/icon_contract_rs.gif" border="0" style ="cursor:pointer;" id="Suit17ListRs"/>
								<input type="image" src="./resources/ls_img/btn_excel.gif" border="0" style ="cursor:pointer;" id="excelBtn"/>
							</p>
							</form>

						</div>
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
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
										<c:forEach items="${suimSuit17List}" var="suit17VO" > <!-- begin="1" end="20" step="1" -->
										<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
										style ="cursor:pointer;" onclick="popSuimSuit17Dtl('${suit17VO.suimRptNo}', '${suit17VO.delDate}')">
											<!-- no -->
											<td>${suit17VO.ROWNUM}</td>
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
													<c:when test="${suit17VO.suimCloseNo != ''}">${suit17VO.suimCloseNo}</c:when>
													
													<c:otherwise>
														<c:choose>
															<c:when test="${suit17VO.suimRptState  eq 3}">반송</c:when>
															<c:when test="${suit17VO.suimRptState  eq 4}">소송</c:when>
															<c:otherwise>
																<font color="red">미결</font>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
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
												<%-- <p <c:if test="${suit17VO.suimRptState  eq 3}">title="${suit17VO.suim_cancel_date_fmt}"</c:if> > --%>
													<c:choose>
														<c:when test="${suit17VO.delDate != 0}"><font color="red">삭제</font></c:when>
														<c:when test="${suit17VO.suimRptState  eq 1}"><font color="blue">결재</font></c:when>
														<c:when test="${suit17VO.suimRptState  eq 11}">반려</c:when>
														<c:when test="${suit17VO.suimRptState  eq 2}">${suit17VO.closeDateFmt}</c:when>
														<c:when test="${suit17VO.suimRptState  eq 3}">반송</c:when>
														<c:when test="${suit17VO.suimRptState  eq 4}">소송</c:when>
														<c:when test="${suit17VO.pastDate > 15}"><font color="fuchsia">${suit17VO.pastDate}일</font></c:when>
														<c:otherwise>${suit17VO.pastDate}일</c:otherwise>
													</c:choose>
												<!-- </p> -->
											</td>
										</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
							
							<p style="text-align:center;">
								<c:if test="${startPgNoInt1 > 10}">
									<a href="./${pgNm1}?reqPgNo=${startPgNoInt1 - 1}&viewFromDate=${viewFromDate}&viewToDate=${viewToDate}">&lt;</a>
								</c:if>
						
								<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
									<c:choose>
										<c:when test="${reqPgNoInt1 != pageNo}">
											<a href="./${pgNm1}?reqPgNo=${pageNo}&viewFromDate=${viewFromDate}&viewToDate=${viewToDate}"><c:out value="${pageNo}" /></a>
											&nbsp;&nbsp;
										</c:when>
										<c:otherwise>
											<font color="red"><c:out value="${pageNo}" /></font>
											&nbsp;&nbsp;
										</c:otherwise>
									</c:choose>
								</c:forEach>
						
								<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
									<a href="./${pgNm1}?reqPgNo=${endPgNoInt1 + 1}&viewFromDate=${viewFromDate}&viewToDate=${viewToDate}">&gt;</a>
								</c:if>
							</p>
						</div><!-- //guestcnt4 -->

					</div>
				</div>
				<!-- //centercnt_bot -->

			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>
