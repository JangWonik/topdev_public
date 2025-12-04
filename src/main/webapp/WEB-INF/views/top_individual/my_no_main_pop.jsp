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
// 				$("#mynositetab").click();

				if ('${myNoSiteList.size()}' > 0){//현장제출 3일전
					$("#mynositetab").click();
				}else if('${myNoInterim5DayList.size()}' > 0){//중간제출 5일전	
					$("#mynointerim5daytab").click();
				}else if('${myNoInterim5DayList2.size()}' > 0){//진행경과 5일전
					$("#mynointerim5day2tab").click();
				}else if('${myNoSiteOverList.size()}' > 0){//현장제출 3일초과
					$("#mynositeovertab").click();
				}else if('${myNoInterimList.size()}' > 0){//중간제출 초과
					$("#mynointerimtab").click();
				}else if('${myNoInterimList2.size()}' > 0){//진행경과 초과
					$("#mynointerim2tab").click();
				}else if('${myNoSagoListPop.size()}' > 0){//사고처리
					$("#mynosagotab").click();
				}else if('${myNoNowListPop.size()}' > 0){//미결사유
					$("#mynonowtab").click();
				}else if('${myNoPrbListPop.size()}' > 0){//문제점
					$("#mynoprbtab").click();
				}else if('${myNoPlnListPop.size()}' > 0){//향후처리방안
					$("#mynoplntab").click();
				}else if('${myKind4MiList.size()}' > 0){//질병상해
					$("#mykind4mitab").click();
				}else{
					$("#emptyNoPopDiv").show();
					$("#emptyNoPopLi").show();
				}
			
			}else{
				$("#${presentPage}").click();
			}

			
			
			if('${myNoSiteList.size()}' =='0' && '${myNoInterimList.size()}' =='0'
				&& '${myNoInterimList2.size()}' =='0' && '${myKind4MiList.size()}' =='0'){
				window.self.close();
			}
		});//ready
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">

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
							<ul>
								<c:if test="${myNoSiteList.size() > 0}">
									<li id="mynositetab" ><a href="#" style="font-size:11px;">현장제출 3일전 (${myNoSiteList.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoInterim5DayList.size() > 0}">
									<li id="mynointerim5daytab"><a href="#" style="font-size:11px;">중간제출 5일전(${myNoInterim5DayList.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoInterim5DayList2.size() > 0}">
									<li id="mynointerim5day2tab"><a href="#" style="font-size:11px;">진행경과제출 5일전 (${myNoInterim5DayList2.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoSiteOverList.size() > 0}">
									<li id="mynositeovertab"><a href="#" style="font-size:11px;">현장제출 3일초과 (${myNoSiteOverList.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoInterimList.size() > 0}">
									<li id="mynointerimtab"><a href="#" style="font-size:11px;">중간제출 초과 (${myNoInterimList.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoInterimList2.size() > 0}">
									<li id="mynointerim2tab"><a href="#" style="font-size:11px;">진행경과제출 초과 (${myNoInterimList2.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoSagoListPop.size() > 0}">
									<li id="mynosagotab"><a href="#">사고처리 (${myNoSagoListPop.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoNowListPop.size() > 0}">
									<li id="mynonowtab"><a href="#">미결사유 (${myNoNowListPop.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoPrbListPop.size() > 0}">
									<li id="mynoprbtab"><a href="#">문제점 (${myNoPrbListPop.size()})</a></li>
								</c:if>
								
								<c:if test="${myNoPlnListPop.size() > 0}">
									<li id="mynoplntab"><a href="#">향후처리 (${myNoPlnListPop.size()})</a></li>
								</c:if>
								
								<c:if test="${myKind4MiList.size() > 0}">
									<li id="mykind4mitab"><a href="#">질병상해미결건 (${myKind4MiList.size()})</a></li>
								</c:if>
								
								<!-- 진행사항 중 걸리는게 1개도 없을 경우, li는 없는게 나은것 같다고 판단. -->
<!-- 								<li id="emptyNoPopLi" style="display: none;"><a href="#"></a></li> -->
								
							</ul>
						</div>
						
						<c:set var="cntFlag" value="0" /> 
						<c:if test="${myNoSiteList.size() > 0}">
							<!-- 나의 현장 미제출(3일 이전) -->
							<c:set var="cntFlag" value="1" />
							<div class="guestcnt4" style="display:block;">
								<c:import url="../top_individual/my_no_site_list.jsp"></c:import>
							</div>
						</c:if>
						
						<c:if test="${myNoInterim5DayList.size() > 0}">
							<!-- 나의 중간미제출 (5일 이전) -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_interim_5day_list.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_interim_5day_list.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>						
						
						<c:if test="${myNoInterim5DayList2.size() > 0}">
							<!-- 나의 진행경과미제출 (5일이전) -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_interim_5day_list2.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_interim_5day_list2.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>						
						
						<c:if test="${myNoSiteOverList.size() > 0}">
							<!-- 나의 현장 미제출(3일 초과) -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_site_over_list.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_site_over_list.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
						
						
						<c:if test="${myNoInterimList.size() > 0}">
							<!-- 나의중간미제출 -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_interim_list.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_interim_list.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
						
						<c:if test="${myNoInterimList2.size() > 0}">
							<!-- 나의진행경과미제출 -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_interim_list2.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_interim_list2.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
						
						<c:if test="${myNoSagoListPop.size() > 0}">
							<!-- 나의 사고처리 미제출 -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_sago_list.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_sago_list.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>		
						
						<c:if test="${myNoNowListPop.size() > 0}">
							<!-- 나의 미결사유 미제출 -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_now_list.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_now_list.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>						

						<c:if test="${myNoPrbListPop.size() > 0}">
							<!-- 나의 문제점 미제출 -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_prb_list.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_prb_list.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>		
						
						<c:if test="${myNoPlnListPop.size() > 0}">
							<!-- 나의 향후처리 미제출 -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_no_pln_list.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_no_pln_list.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>					
											
						
						<c:if test="${myKind4MiList.size() > 0}">
							<!-- 4종 접수 3일 지난 미결 -->
							<c:choose>
								<c:when test="${cntFlag == 1}">
									<div class="guestcnt4" style="display:none;">
										<c:import url="../top_individual/my_kind4_mi_list.jsp"></c:import>
									</div>
								</c:when>
								<c:otherwise>
									<c:set var="cntFlag" value="1" />
									<div class="guestcnt4" style="display:block;">
										<c:import url="../top_individual/my_kind4_mi_list.jsp"></c:import>
									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
						
						<!-- 진행사항 중 걸리는게 1개도 없을 경우 -->
						<div class="guestcnt4" id="emptyNoPopDiv" style="display:none;">
							<c:import url="../top_individual/my_no_empty.jsp"></c:import>
						</div>
						

					<form action="./myNoSiteListPop" name="myNoMainPagingForm" method="get">
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

</div>
<!-- //wrapper -->

</body>
</html>
