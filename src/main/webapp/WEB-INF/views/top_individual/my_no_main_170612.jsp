<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar-rptinv.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}

			if('${presentPage}' == null || '${presentPage}' == ''){
				$("#mynositetab").click();
			}else{
				$("#${presentPage}").click();
			}
		});//ready
	</script>
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

			<!-- center_cnt -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">

						<p style="margin-top:5px;text-align:right;"></p>

						<div class="guestTap">
							<ul>
								<c:if test="${myNoSiteList.size() > 0}">
									<li id="mynositetab"><a href="#">나의현장미제출 (${myNoSiteList.size()})</a></li>
								</c:if>
								<c:if test="${myNoInterimList.size() > 0}">
									<li id="mynointerimtab"><a href="#">나의중간미제출 (${myNoInterimList.size()})</a></li>
								</c:if>
								<c:if test="${myNoInterimList2.size() > 0}">
									<li id="mynointerim2tab"><a href="#">나의진행경과미제출 (${myNoInterimList2.size()})</a></li>
								</c:if>
								<c:if test="${myKind4MiList.size() > 0}">
									<li id="mykind4mitab"><a href="#">질병상해미결건 (${myKind4MiList.size()})</a></li>
								</c:if>
								<c:if test="${tmNoSiteList.size() > 0}">
									<li id="tmnositetab"><a href="#">팀현장미제출 (${tmNoSiteList.size()})</a></li>
								</c:if>
								<c:if test="${tmNoInterimList.size() > 0}">
									<li id="tmnointerimtab"><a href="#">팀중간미제출 (${tmNoInterimList.size()})</a></li>
								</c:if>
							</ul>
						</div>

						<c:if test="${myNoSiteList.size() > 0}">
							<!-- 나의현장미제출 -->
							<div class="guestcnt4" style="display:block;">
								<c:import url="../top_individual/my_no_site_list.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${myNoInterimList.size() > 0}">
							<!-- 나의중간미제출 -->
							<div class="guestcnt4" style="display:block;">
								<c:import url="../top_individual/my_no_interim_list.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${myNoInterimList2.size() > 0}">
							<!-- 나의진행경과미제출 -->
							<div class="guestcnt4" style="display:block;">
								<c:import url="../top_individual/my_no_interim_list2.jsp"></c:import>
							</dsv>
						</c:if>
						<c:if test="${myKind4MiList.size() > 0}">
							<!-- 4종 접수 3일 지난 미결 -->
							<div class="guestcnt4" style="display:block;">
								<c:import url="../top_individual/my_kind4_mi_list.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${tmNoSiteList.size() > 0}">
							<!-- 팀현장미제출 -->
							<div class="guestcnt4" style="display:block;">
								<c:import url="../top_individual/tm_no_site_list.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${tmNoInterimList.size() > 0}">
							<!-- 팀중간미제출 -->
							<div class="guestcnt4" style="display:block;">
								<c:import url="../top_individual/tm_no_interim_list.jsp"></c:import>
							</div>
						</c:if>

		<form action="./myNoSiteList" name="myNoMainPagingForm" method="get">
			<input type="hidden" id="reqPgNo" name="reqPgNo" >
			<input type="hidden" id="presentPage" name="presentPage" >
		</form>

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
