<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || ('${mbrAuthVo_Session.mbr_pms_14}' == 0 && '${mbrAuthVo_Session.mbr_pms_15}' == 0)){
				window.location.assign("./logout");
			}
		});//ready
	</script>
	<script>
		function goMmrState(team_id){
			location.href = "topMemberState?team_id="+team_id;
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
								<li class="on"><a href="#">팀별 인사 관리</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
									<thead>
										<tr>
											<th>팀명</th>
											<th width="15%">전화</th>
											<th width="55%">주소</th>
											<th width="5%">구성원</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<!-- 본부 출력 시작 -->
										<c:forEach items="${teamList}" var="tmVo">
  <%-- 											<c:when test="${tmVo.teamType != 4}"> --%>
												<c:choose>
													<c:when test="${tmVo.team_level eq 0}">
														<c:choose>
															<c:when test="${tmVo.team_type ne 4}">
																<tr style = "background:#E5EBFF;">
																	<td><b>${tmVo.team_name}</b></td>
																	<td></td>
																	<td></td>
																	<td>${tmVo.cnt}명</td>
																	<td></td>
																</tr>													
															</c:when>
															<c:otherwise>
																<tr style = "background:#F7E6CF;">
																	<td><b>${tmVo.team_name}</b></td>
																	<td></td>
																	<td></td>
																	<td>${tmVo.cnt}명</td>
																	<td></td>
																</tr>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when  test="${tmVo.team_level ne 0}">
														<c:if test="${tmVo.cnt ne '-'}">
															<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
																<td>
																<c:if test="${tmVo.team_level eq 2}">└</c:if>
																${tmVo.team_name}</td>
																<td>${tmVo.team_telephone}</td>
																<td>${tmVo.team_addr}</td>
																<td>${tmVo.cnt}명</td>
																<td>
																<c:if test="${(mbrAuthVo.mbr_pms_14 ne '0') && (mbrAuthVo.mbr_pms_15 ne '0')}">
																	<img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick="goMmrState('${tmVo.team_id}');"/>
																</c:if>
															</td>
														</tr>
														</c:if>
													</c:when>
												</c:choose>
<%-- 											</c:when> --%>
<%-- 											<c:otherwise> --%>

<%-- 												<c:choose> --%>
<%-- 													<c:when  test="${tmVo.team_level eq 0}"> --%>
<!-- 														<tr style = "background:#F7E6CF;"> -->
<%-- 															<td><b>${tmVo.team_name}</b></td> --%>
<!-- 															<td></td> -->
<!-- 															<td></td> -->
<%-- 															<td>${tmVo.cnt}명</td> --%>
<!-- 															<td></td> -->
<!-- 														</tr> -->
<%-- 													</c:when> --%>
<%-- 													<c:when  test="${tmVo.team_level ne 0}"> --%>
<%-- 														<c:if test="${tmVo.cnt ne '-'}"> --%>
<!-- 															<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"> -->
<!-- 																<td> -->
<%-- 																<c:if test="${tmVo.team_level eq 2}">└</c:if> --%>
<%-- 																${tmVo.team_name}</td> --%>
<%-- 																<td>${tmVo.team_telephone}</td> --%>
<%-- 																<td>${tmVo.team_addr}</td> --%>
<%-- 																<td>${tmVo.cnt}명</td> --%>
<!-- 																<td> -->
<%-- 																<c:if test="${(mbrAuthVo.mbr_pms_14 ne '0') && (mbrAuthVo.mbr_pms_15 ne '0')}"> --%>
<%-- 																	<img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick="goMmrState('${tmVo.team_id}');"/> --%>
<%-- 																</c:if> --%>
<!-- 															</td> -->
<!-- 														</tr> -->
<%-- 														</c:if> --%>
<%-- 													</c:when> --%>
<%-- 												</c:choose> --%>
<%-- 											</c:otherwise> --%>
											
										</c:forEach>
										<!-- 본부 출력 끝 -->
										
										<tr>
											<td colspan="3">총원</td>
											<td>${countWorkTotal}명</td>
											<td><img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick=""/></td>
										</tr>
										<tr>
											<td colspan="3">발령대기</td>
											<td>${countPendingTotal}명</td>
											<td><img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick=""/></td>
										</tr>
										<tr>
											<td colspan="3">퇴사자</td>
											<td>${countRetireTotal}명</td>
											<td><img src="./resources/ls_img/member/btn_view.gif" style="cursor:pointer;" onclick=""/></td>
										</tr>
										
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
						<div class="guestcnt4" style="display:none;">
						</div>
						<div class="guestcnt4" style="display:none;">
						</div>
						<div class="guestcnt4" style="display:none;">
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
