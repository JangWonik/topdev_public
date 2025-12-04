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
				$("#mynositeovertab").click();
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
		<div class="contetnsMiPop">

			<!-- center_cnt -->
			<div class="center_cnt_1500">

				<!-- centercnt_bot -->
				<div class="center_cnt_1500_bot">
					<div class="guest">

						<p style="margin-top:5px;text-align:right;"></p>

						<div class="guestPopTap">
							<c:set var="myNoSiteStyle" value="style='display:none;'" />
							<c:set var="myNoInterim5DayStyle" value="style='display:none;'" />
							<c:set var="myNoInterim5DayStyle2" value="style='display:none;'" />
							<c:set var="myNoSiteOverStyle" value="style='display:none;'" />
							<c:set var="myNoInterimStyle" value="style='display:none;'" />
							<c:set var="myNoInterimStyle2" value="style='display:none;'" />
							<c:set var="myNoSagoStylePop" value="style='display:none;'" />
							<c:set var="myNoPrbStylePop" value="style='display:none;'" />
							<c:set var="myNoPlnStylePop" value="style='display:none;'" />
							
							<c:set var="tmNoSiteStyle" value="style='display:none;'" />
							<c:set var="tmNoSiteOverStyle" value="style='display:none;'" />
							<c:set var="tmNoInterim5DayStyle" value="style='display:none;'" />
							<c:set var="tmNoInterimStyle" value="style='display:none;'" />
							
							<c:set var="myKind4MiStyle" value="style='display:none;'" />
							
							<c:choose>
								<c:when test="${myNoSiteList.size() > 0}">
									<c:set var="myNoSiteStyle" value="style='display:block;'" />
									<c:set var="myNoSiteClass" value="class='on'" />
								</c:when>
								<c:when test="${myNoInterim5DayList.size() > 0}">
									<c:set var="myNoInterim5DayStyle" value="style='display:block;'" />
									<c:set var="myNoInterim5DayClass" value="class='on'" />
								</c:when>
								<c:when test="${myNoInterim5DayList2.size() > 0}">
									<c:set var="myNoInterim5DayStyle2" value="style='display:block;'" />
									<c:set var="myNoInterim5DayClass2" value="class='on'" />									
								</c:when>  
								<c:when test="${myNoSiteOverList.size() > 0}">
									<c:set var="myNoSiteOverStyle" value="style='display:block;'" />
									<c:set var="myNoSiteOverClass" value="class='on'" />
								</c:when>
								<c:when test="${myNoInterimList.size() > 0}">
									<c:set var="myNoInterimStyle" value="style='display:block;'" />
									<c:set var="myNoInterimClass" value="class='on'" />
								</c:when>
								<c:when test="${myNoInterimList2.size() > 0}">
									<c:set var="myNoInterimStyle2" value="style='display:block;'" />
									<c:set var="myNoInterimClass2" value="class='on'" />
								</c:when>
								<c:when test="${myNoSagoListPop.size() > 0}">
									<c:set var="myNoSagoStylePop" value="style='display:block;'" />
									<c:set var="myNoSagoClassPop" value="class='on'" />
								</c:when>
								<c:when test="${myNoNowListPop.size() > 0}">
									<c:set var="myNoNowListPop" value="style='display:block;'" />
									<c:set var="myNoNowListPop" value="class='on'" />
								</c:when>
								<c:when test="${myNoPrbListPop.size() > 0}">
									<c:set var="myNoPrbStylePop" value="style='display:block;'" />
									<c:set var="myNoPrbClassPop" value="class='on'" />
								</c:when>
								<c:when test="${myNoPlnListPop.size() > 0}">
									<c:set var="myNoPlnStylePop" value="style='display:block;'" />
									<c:set var="myNoPlnClassPop" value="class='on'" />
								</c:when>
								
								<c:when test="${tmNoSiteList.size() > 0}">
									<c:set var="tmNoSiteStyle" value="style='display:block;'" />
									<c:set var="tmNoSiteClass" value="class='on'" />
								</c:when>
								
								<c:when test="${tmNoSiteOverList.size() > 0}">
									<c:set var="tmNoSiteOverStyle" value="style='display:block;'" />
									<c:set var="tmNoSiteOverClass" value="class='on'" />
								</c:when>								
								
								<c:when test="${tmNoInterim5DayList.size() > 0}">
									<c:set var="tmNoInterim5DayStyle" value="style='display:block;'" />
									<c:set var="tmNoInterim5DayClass" value="class='on'" />
								</c:when>
								
								<c:when test="${tmNoInterimList.size() > 0}">
									<c:set var="tmNoInterimStyle" value="style='display:block;'" />
									<c:set var="tmNoInterimClass" value="class='on'" />
								</c:when>

								<c:when test="${myKind4MiList.size() > 0}">
									<c:set var="myKind4MiStyle" value="style='display:block;'" />
									<c:set var="myKind4MiClass" value="class='on'" />
								</c:when>
							</c:choose>						
						
							<ul>
								<c:if test="${myNoSiteList.size() > 0}">
									<li id="mynositetab" ${myNoSiteClass}><a href="#" style="font-size:11px;">현장제출 3일전 (${myNoSiteList.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoInterim5DayList.size() > 0}">
									<li id="mynointerim5daytab" ${myNoInterim5DayClass} ><a href="#" style="font-size:11px;">중간제출 5일전(${myNoInterim5DayList.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoInterim5DayList2.size() > 0}">
									<li id="mynointerim5day2tab" ${myNoInterim5DayClass2} ><a href="#" style="font-size:11px;">진행경과제출 5일전 (${myNoInterim5DayList2.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoSiteOverList.size() > 0}">
									<li id="mynositeovertab" ${myNoSiteOverClass} ><a href="#" style="font-size:11px;">현장제출 3일초과 (${myNoSiteOverList.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoInterimList.size() > 0}">
									<li id="mynointerimtab" ${myNoInterimClass} ><a href="#" style="font-size:11px;">중간제출 초과 (${myNoInterimList.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoInterimList2.size() > 0}">
									<li id="mynointerim2tab" ${myNoInterimClass2} ><a href="#" style="font-size:11px;">진행경과제출 초과 (${myNoInterimList2.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoSagoListPop.size() > 0}">
									<li id="mynosagotab" ${myNoSagoClassPop} ><a href="#">사고처리 (${myNoSagoListPop.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoNowListPop.size() > 0}">
									<li id="mynonowtab" ${myNoNowClassPop} ><a href="#">미결사유 (${myNoNowListPop.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoPrbListPop.size() > 0}">
									<li id="mynoprbtab" ${myNoPrbClassPop} ><a href="#">문제점 (${myNoPrbListPop.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoPlnListPop.size() > 0}">
									<li id="mynoplntab" ${myNoPlnClassPop} ><a href="#">향후처리 (${myNoPlnListPop.size()})</a></li>
								</c:if>
								
								<c:if test="${myKind4MiList.size() > 0}">
									<li id="mykind4mitab" ${myKind4MiClass} ><a href="#">질병상해미결건 (${myKind4MiList.size()})</a></li>
								</c:if>
								
								
								<c:if test="${tmNoSiteList.size() > 0}">
									<li id="tmnositetab" ${tmNoSiteClass} ><a href="#">팀현장제출 3일전 (${tmNoSiteList.size()})</a></li>
								</c:if>
								<c:if test="${tmNoSiteOverList.size() > 0}">
									<li id="tmnositeovertab" ${tmNoSiteOverClass} ><a href="#">팀현장제출 3일초과(${tmNoSiteOverList.size()})</a></li>
								</c:if>
								<c:if test="${tmNoInterim5DayList.size() > 0}">
									<li id="tmnointerim5daytab" ${tmNoInterim5DayClass} ><a href="#">팀중간제출 5일전(${tmNoInterim5DayList.size()})</a></li>
								</c:if>								
								<c:if test="${tmNoInterimList.size() > 0}">
									<li id="tmnointerimtab" ${tmNoInterimClass} ><a href="#">팀중간제출 초과(${tmNoInterimList.size()})</a></li>
								</c:if>
								
							</ul>
						</div>

						<c:set var="cntFlag" value="0" />
						
						<c:if test="${myNoSiteList.size() > 0}">
							<!-- 나의 현장 미제출(3일 이전) -->
							<div class="guestcnt4" ${myNoSiteStyle}>
								<c:import url="../top_individual/my_no_site_list.jsp"></c:import>
							</div>
						</c:if>
						
						<c:if test="${myNoInterim5DayList.size() > 0}">
							<!-- 나의 중간미제출 (5일 이전) -->
							<div class="guestcnt4" ${myNoInterim5DayStyle}>
								<c:import url="../top_individual/my_no_interim_5day_list.jsp"></c:import>
							</div>
						</c:if>						
						
						<c:if test="${myNoInterim5DayList2.size() > 0}">
							<!-- 나의 진행경과미제출 (5일이전) -->
							<div class="guestcnt4" ${myNoInterim5DayStyle2}>
								<c:import url="../top_individual/my_no_interim_5day_list2.jsp"></c:import>
							</div>
						</c:if>						
						
						<c:if test="${myNoSiteOverList.size() > 0}">
							<!-- 나의 현장 미제출(3일 초과) -->
							<div class="guestcnt4" ${myNoSiteOverStyle}>
								<c:import url="../top_individual/my_no_site_over_list.jsp"></c:import>
							</div>
						</c:if>
						
						
						<c:if test="${myNoInterimList.size() > 0}">
							<!-- 나의중간미제출 -->
							<div class="guestcnt4" ${myNoInterimStyle}>
								<c:import url="../top_individual/my_no_interim_list.jsp"></c:import>
							</div>
						</c:if>
						
						<c:if test="${myNoInterimList2.size() > 0}">
							<!-- 나의진행경과미제출 -->
							<div class="guestcnt4" ${myNoInterimStyle2}>
								<c:import url="../top_individual/my_no_interim_list2.jsp"></c:import>
							</div>
						</c:if>
						
						<c:if test="${myNoSagoListPop.size() > 0}">
							<!-- 나의 사고처리 미제출 -->
							<div class="guestcnt4" ${myNoSagoStylePop}>
								<c:import url="../top_individual/my_no_sago_list.jsp"></c:import>
							</div>
						</c:if>		
						
						<c:if test="${myNoNowListPop.size() > 0}">
							<!-- 나의 미결사유 미제출 -->
							<div class="guestcnt4" ${myNoNowStylePop}>
								<c:import url="../top_individual/my_no_now_list.jsp"></c:import>
							</div>
						</c:if>						

						<c:if test="${myNoPrbListPop.size() > 0}">
							<!-- 나의 문제점 미제출 -->
							<div class="guestcnt4" ${myNoPrbStylePop}>
								<c:import url="../top_individual/my_no_prb_list.jsp"></c:import>
							</div>
						</c:if>		
						
						<c:if test="${myNoPlnListPop.size() > 0}">
							<!-- 나의 향후처리 미제출 -->
							<div class="guestcnt4" ${myNoPlnStylePop}>
								<c:import url="../top_individual/my_no_pln_list.jsp"></c:import>
							</div>
						</c:if>		
						
						
						<c:if test="${tmNoSiteList.size() > 0}">
							<!-- 팀현장제출 3일전 -->
							<div class="guestcnt4" ${tmNoSiteStyle}>
								<c:import url="../top_individual/tm_no_site_list.jsp"></c:import>
							</div>
						</c:if>
						
						<c:if test="${tmNoSiteOverList.size() > 0}">
							<!-- 팀현장제출 초과 -->
							<div class="guestcnt4" ${tmNoSiteOverStyle}>
								<c:import url="../top_individual/tm_no_site_over_list.jsp"></c:import>
							</div>
						</c:if>						

						<c:if test="${tmNoInterim5DayList.size() > 0}">
							<!-- 팀중간 미제출 -->
							<div class="guestcnt4" ${tmNoInterim5DayStyle}>
								<c:import url="../top_individual/tm_no_interim_5day_list.jsp"></c:import>
							</div>
						</c:if>		
										
					
						<c:if test="${tmNoInterimList.size() > 0}">
							<!-- 팀중간미제출 -->
							<div class="guestcnt4" ${tmNoInterimStyle}>
								<c:import url="../top_individual/tm_no_interim_list.jsp"></c:import>
							</div>
						</c:if>		
											
						<c:if test="${myKind4MiList.size() > 0}">
							<!-- 4종 접수 3일 지난 미결 -->
							<div class="guestcnt4" ${myKind4MiStyle}>
								<c:import url="../top_individual/my_kind4_mi_list.jsp"></c:import>
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
