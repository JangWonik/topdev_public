<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready
		
		function excelPtnrMember(gubun){
			$("#gubun").val(gubun);
			excelPtnrMemberForm.submit();
		}
	</script>
<style>
	.tableStyle2 td {letter-spacing: 0;}
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

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">관련업체 직원검색</a></li>
								<li><a href="#">손해보험</a></li>
								<li ><a href="#">생명보험</a></li>
								<li ><a href="#">협회</a></li>
								<li ><a href="#">공제</a></li>
								<li ><a href="#">기타</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<c:import url="../top_general/top_ptnr_mbr_search.jsp"></c:import>
						</div>
						<div class="guestcnt4" style="display:none;">
							<span style="float:right; margin:5px;">
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelPtnrMember('all')"   />
							</span>
							<!-- 엑셀 다운을 위한 폼 -->
							<form name="excelPtnrMemberForm" id="excelPtnrMemberForm" action="excelPtnrMember" method="GET">
								<input type="hidden" id="gubun" name="gubun" />
							</form>
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th>로고</th>
											<th width="30%">회사명</th>
											<th>고객센터</th>
											<th>PRM</th>
											<th>홈페이지</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 손해보험 출력 시작 -->
										<c:forEach items="${ptnrList}" var="vo">
													<tr>
														<c:choose>
															<c:when test="${vo.getPtnr_img_small().length() == 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td><img src="${vo.getPtnr_img_small()}"/></td>
															</c:otherwise>
														</c:choose>
														<td><c:out value="${vo.getPtnr_name()}"/></td>
														<td><c:out value="${vo.getPtnr_tel()}"/></td>
														<td>
															<c:choose>
																<c:when test="${empty vo.getPtnr_url()}"> - </c:when>
																<c:otherwise><a href="${vo.getPtnr_url()}" target="_blank"><input type="button" value="PRM" class="buttonAssistance" title="PRM 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td>
															<c:choose>
																<c:when test="${empty vo.getPtnr_homepage()}"> - </c:when>
																<c:otherwise><a href="${vo.getPtnr_homepage()}" target="_blank"><input type="button" value="홈페이지" class="buttonAssistanceEmail"  title="홈페이지 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td><a href="./topPtnrDTL?ptnr_id=${vo.getPtnr_id()}"><img src="./resources/ls_img/ls_partner/btn_view.gif"/></a></td>
													</tr>
										</c:forEach>
										<!-- 손해보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						<div class="guestcnt4" style="display:none;">
							<span style="float:right; margin:5px;">
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelPtnrMember('all')"   />
							</span>
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th>로고</th>
											<th width="30%">회사명</th>
											<th>고객센터</th>
											<th>PRM</th>
											<th>홈페이지</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 생명보험 출력 시작 -->
										<c:forEach items="${ptnrList2}" var="vo2">
													<tr>
														<c:choose>
															<c:when test="${vo2.getPtnr_img_small().length() == 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td><img src="${vo2.getPtnr_img_small()}"/></td>
															</c:otherwise>
														</c:choose>
														<td><c:out value="${vo2.getPtnr_name()}"/></td>
														<td><c:out value="${vo2.getPtnr_tel()}"/></td>
														<td>
															<c:choose>
																<c:when test="${empty vo2.getPtnr_url()}"> - </c:when>
																<c:otherwise><a href="${vo2.getPtnr_url()}" target="_blank"><input type="button" value="PRM" class="buttonAssistance" title="PRM 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td>
															<c:choose>
																<c:when test="${empty vo2.getPtnr_homepage()}"> - </c:when>
																<c:otherwise><a href="${vo2.getPtnr_homepage()}" target="_blank"><input type="button" value="홈페이지" class="buttonAssistanceEmail"  title="홈페이지 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td><a href="./topPtnrDTL?ptnr_id=${vo2.getPtnr_id()}"><img src="./resources/ls_img/ls_partner/btn_view.gif"/></a></td>
													</tr>
										</c:forEach>
										<!-- 생명보험 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						<div class="guestcnt4" style="display:none;">
							<span style="float:right; margin:5px;">
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelPtnrMember('all')"   />
							</span>
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th>로고</th>
											<th width="30%">회사명</th>
											<th>고객센터</th>
											<th>PRM</th>
											<th>홈페이지</th>										
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 협회 출력 시작 -->
										<c:forEach items="${ptnrList3}" var="vo3">
													<tr>
														<c:choose>
															<c:when test="${vo3.getPtnr_img_small().length() == 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td><img src="${vo3.getPtnr_img_small()}"/></td>
															</c:otherwise>
														</c:choose>
														<td><c:out value="${vo3.getPtnr_name()}"/></td>
														<td><c:out value="${vo3.getPtnr_tel()}"/></td>
														<td>
															<c:choose>
																<c:when test="${empty vo3.getPtnr_url()}"> - </c:when>
																<c:otherwise><a href="${vo3.getPtnr_url()}" target="_blank"><input type="button" value="PRM" class="buttonAssistance" title="PRM 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td>
															<c:choose>
																<c:when test="${empty vo3.getPtnr_homepage()}"> - </c:when>
																<c:otherwise><a href="${vo3.getPtnr_homepage()}" target="_blank"><input type="button" value="홈페이지" class="buttonAssistanceEmail"  title="홈페이지 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td><a href="./topPtnrDTL?ptnr_id=${vo3.getPtnr_id()}"><img src="./resources/ls_img/ls_partner/btn_view.gif"/></a></td>
													</tr>
										</c:forEach>
										<!-- 협회 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						<div class="guestcnt4" style="display:none;">
							<span style="float:right; margin:5px;">
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelPtnrMember('all')"   />
							</span>
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th>로고</th>
											<th width="30%">회사명</th>
											<th>고객센터</th>
											<th>PRM</th>
											<th>홈페이지</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<!--  공제 출력 시작 -->
										<c:forEach items="${ptnrList4}" var="vo4">
													<tr>
														<c:choose>
															<c:when test="${vo4.getPtnr_img_small().length() == 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td><img src="${vo4.getPtnr_img_small()}"/></td>
															</c:otherwise>
														</c:choose>
														<td><c:out value="${vo4.getPtnr_name()}"/></td>
														<td><c:out value="${vo4.getPtnr_tel()}"/></td>
														<td>
															<c:choose>
																<c:when test="${empty vo4.getPtnr_url()}"> - </c:when>
																<c:otherwise><a href="${vo4.getPtnr_url()}" target="_blank"><input type="button" value="PRM" class="buttonAssistance" title="PRM 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td>
															<c:choose>
																<c:when test="${empty vo4.getPtnr_homepage()}"> - </c:when>
																<c:otherwise><a href="${vo4.getPtnr_homepage()}" target="_blank"><input type="button" value="홈페이지" class="buttonAssistanceEmail"  title="홈페이지 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td><a href="./topPtnrDTL?ptnr_id=${vo4.getPtnr_id()}"><img src="./resources/ls_img/ls_partner/btn_view.gif"/></a></td>
													</tr>
										</c:forEach>
										<!-- 공제 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						
						<div class="guestcnt4" style="display:none;">
							<span style="float:right; margin:5px;">
								<img src="./resources/ls_img/btn_excel.gif" style="cursor:pointer;" onclick="excelPtnrMember('all')"   />
							</span>						
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th>로고</th>
											<th width="30%">회사명</th>
											<th>고객센터</th>
											<th>PRM</th>
											<th>홈페이지</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 기타 출력 시작 -->
										<c:forEach items="${ptnrList5}" var="vo5">
													<tr>
														<c:choose>
															<c:when test="${vo5.getPtnr_img_small().length() == 0}">
																<td></td>
															</c:when>
															<c:otherwise>
																<td><img src="${vo5.getPtnr_img_small()}"/></td>
															</c:otherwise>
														</c:choose>
														<td><c:out value="${vo5.getPtnr_name()}"/></td>
														<td><c:out value="${vo5.getPtnr_tel()}"/></td>
														<td>
															<c:choose>
																<c:when test="${empty vo5.getPtnr_url()}"> - </c:when>
																<c:otherwise><a href="${vo5.getPtnr_url()}" target="_blank"><input type="button" value="PRM" class="buttonAssistance" title="PRM 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td>
															<c:choose>
																<c:when test="${empty vo5.getPtnr_homepage()}"> - </c:when>
																<c:otherwise><a href="${vo5.getPtnr_homepage()}" target="_blank"><input type="button" value="홈페이지" class="buttonAssistanceEmail"  title="홈페이지 링크연결"></a></c:otherwise>
															</c:choose>															
														</td>
														<td><a href="./topPtnrDTL?ptnr_id=${vo5.getPtnr_id()}"><img src="./resources/ls_img/ls_partner/btn_view.gif"/></a></td>
													</tr>
										</c:forEach>
										<!-- 기타 출력 끝 -->
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div>
						
					</div>
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->

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
