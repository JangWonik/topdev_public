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
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.css">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery-ui.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}

			if('${presentPage}' == null || '${presentPage}' == ''){
				$("#suimrpttab").click();
			}else{
				$("#${presentPage}").click();
			}

			var $tabCate = $('.guestTap ul li');
			$tabCate.click(function(){
				var idx = $('.guestTap ul li').index(this);
				$tabCate.removeClass('on');
				$(".guestcntSearch").hide().eq(idx).show();
				$tabCate.eq(idx).addClass('on');
				return false;
			});// Tab Menu JS
		});//ready
	</script>
	
	<style>
		.srchSelect { width : 100%; }
		.srchTxt { width : 140px; }
		#regDateToSearch, #cancelDateToSearch, #minwonDateToSearch, #closeDateToSearch{ margin-left: 3px; }
		
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

			<!-- center_cnt -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot_search">
					<div class="guest">

						<c:import url="../search_main/search_query.jsp"></c:import>

						<p style="margin-top:5px;text-align:right;"></p>

						<div class="guestTap">
							<ul>
								<c:if test="${suimRptListTotCnt > 0}">
									<li id="suimrpttab"><a href="#">수임대장 (${suimRptListTotCnt})</a></li>
								</c:if>
								<c:if test="${primbizRptListTotCnt > 0}">
									<li id="primbizrpttab"><a href="#">농작물수임대장 (${primbizRptListTotCnt})</a></li>
								</c:if>
								<c:if test="${suit10RptListTotCnt > 0}">
									<li id="suit10rpttab"><a href="#">적부KB (${suit10RptListTotCnt})</a></li>
								</c:if>
								<c:if test="${suit12RptListTotCnt > 0}">
									<li id="suit12rpttab"><a href="#">적부한화 (${suit12RptListTotCnt})</a></li>
								</c:if>
								<c:if test="${suit17RptListTotCnt > 0}">
									<li id="suit17rpttab"><a href="#">적부흥국 (${suit17RptListTotCnt})</a></li>
								</c:if>
								<c:if test="${suit18RptListTotCnt > 0}">
									<li id="suit18rpttab"><a href="#">적부삼성 (${suit18RptListTotCnt})</a></li>
								</c:if>
							</ul>
						</div>

						<c:if test="${suimRptListTotCnt > 0}">
							<!-- 수임대장 -->
							<div class="guestcntSearch" style="display:block;">
								<c:import url="../search_main/search_result_suim.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${primbizRptListTotCnt > 0}">
							<!-- 농작물수임대장 -->
							<div class="guestcntSearch" style="display:block;">
								<c:import url="../search_main/search_result_prim_biz.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${suit10RptListTotCnt > 0}">
							<!-- 적부KB -->
							<div class="guestcntSearch" style="display:block;">
								<c:import url="../search_main/search_result_suit10.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${suit12RptListTotCnt > 0}">
							<!-- 적부한화 -->
							<div class="guestcntSearch" style="display:block;">
								<c:import url="../search_main/search_result_suit12.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${suit17RptListTotCnt > 0}">
							<!-- 적부흥국 -->
							<div class="guestcntSearch" style="display:block;">
								<c:import url="../search_main/search_result_suit17.jsp"></c:import>
							</div>
						</c:if>
						<c:if test="${suit18RptListTotCnt > 0}">
							<!-- 적부삼성 -->
							<div class="guestcntSearch" style="display:block;">
								<c:import url="../search_main/search_result_suit18.jsp"></c:import>
							</div>
						</c:if>

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
