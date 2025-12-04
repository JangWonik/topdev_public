<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<%--<html>--%>

<%--<head>--%>
	<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
	<script type="text/javascript">
		function openGroupSMS(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=700; //띄울 창의 넓이
			var sh=533;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('groupSMSForm','groupSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function goSearchMain(){
			$("#searchMainForm").attr("action","searchMain");
		}

		function goSearchMainQuery(){
			$("#searchMainForm").attr("action","searchMainQuery");
		}
		
		function goNewTotal(){
			$("#top_loading").show();
			location.href="./statistics_basic_team_list";
		}
		
		function goQuickTotal(){			
			$("#top_loading").show();
			location.href="./statistics_basic_team_list_quick";
		}
		
		function goReportTm( p_param ){
			$("#top_loading").show();
			//location.href="./getSuimReportTm";
			$("#menuId").val( p_param );
			$("#menuForm").attr("action","getSuimReportTm");
			$("#menuForm").submit();
		}
	</script>
	<style>
		td{
			letter-spacing: 0px !important;
		}
		
		#header .inner #gnb>ul>li{
			width:140px !important;
		}
		#header .inner #gnb>ul>li ul{
			width:200px !important;
		} 
		
		#header .inner #gnb>ul>li ul li{
			width:200px !important;
		}
	</style>
<%--</head>--%>

<%--<body>--%>


	<!-- header -->
	<div id="header">
		<div class="inner clear_v2">
			<h1>
				<a href="./"><img id="menuLogoImg"  src="./resources/wm_img/common/logo.gif" alt="top - TRUST OBLIGATION PASSION" /></a>
				<div class="logobg"></div>
			</h1>
			<div class="hcont">
				<div class="header_top">
					<!-- 검색하기 -->
					<div class="h_schA">
						<form id="searchMainForm" name="searchMainForm" method="post">
							<fieldset>
								<legend>검색하기</legend>
								<ul>
									<li><input type="image" src="./resources/wm_img/common/btn_sch.gif" alt="상세검색" onclick="goSearchMain()" /></li>
									<li class="ipt"><input type="text" id="searchMainSimpleQueryTxt" name="searchMainSimpleQueryTxt" value="${searchMainSimpleQueryTxt}" /></li>
									<li><input type="image" src="./resources/wm_img/common/bg_btnbg01.gif" alt="검색하기" onclick="goSearchMainQuery()" /></li>
								</ul>
							</fieldset>
						</form>
					</div>
					<!-- //검색하기 -->
					<ul class="logArea">
						<li class="team">${mbrVo_Session.user_name} @ ${mbrVo_Session.team_name}</li>
						<li><a href="javascript:openGroupSMS();"><img src="./resources/wm_img/common/ico_mobile.gif" alt="" /></a></li>
						<li class="bgbt"><a href="./logout">Logout</a></li>
					</ul>
				</div>

				<!-- gnb -->
				<div id="gnb">
					<ul>
<!-- 						<li><a href="./search_state">보고서현황</a></li> -->
						<li class="depth1">
							<!-- <a href="#;">팀&개인</a> -->
							<a href="#;">기본통계</a>
							<ul>
							<%-- 180611 기존 통계 주석
								<li><a href="./getMisTmBsc">기본통계</a></li>
								<li><a href="./getMisTmBscPrim">기본통계2(통합매출)</a></li>
 							--%>
 							
<%--							NEW기본통계 권한 주석
								<c:if test="${mbrVo_Session.team_id_main == '7'
											|| mbrVo_Session.user_state == '9'
											|| mbrVo_Session.user_no =='252'
											|| mbrVo_Session.user_no =='215'
											|| mbrVo_Session.user_no =='975'
											|| mbrVo_Session.user_no =='966'
											|| mbrVo_Session.user_no =='6'
											|| mbrVo_Session.user_no =='1265'
											|| mbrVo_Session.user_no =='770'
											|| mbrVo_Session.user_no =='62'
											|| mbrVo_Session.user_no =='916'
											}">
                                </c:if>
 --%>											
                                <!-- <li><a href="./statistics_basic_team_list">NEW 기본통계</a></li> -->
                                <!-- 인사기록 권한이 있는 사람만 전체통계 조회 가능 -->
                                <c:if test="${mbrAuthVo_Session.user_no != null && mbrAuthVo_Session.mbr_pms_46 == 1}">
                                	<li><a href="javascript:goNewTotal();">기본통계(전체)</a></li>
                                </c:if>
                                <li><a href="javascript:goQuickTotal();">기준업무량 미포함통계</a></li>

								<li><a href="./MisEndTm">종결현황</a></li>
<!-- 								<li><a href="#;">종결현황</a></li> -->
 								<li><a href="./statistics_result_team_list">청구내용</a></li>
 								<%--<li><a href="./statistics_calc_team_list">정산내역</a></li>--%>
								<li><a href="./statistics_work_team_list">업무처리현황</a></li>
								<!-- <li><a href="./getSiteReportAll">현장보고서 제출현황</a></li> -->
								<li><a href="./getEndIntervalSearch">평균처리일현황</a></li>
							</ul>
						</li>
						<!-- <li><a href="./getMisAllotTm">일일배당현황</a></li> -->
						<li class="depth1">
							<!-- <a href="#;">팀&개인&보험사</a> -->
							<a href="#;">일일배당현황</a>
							<ul>
								<c:if test="${mbrVo_Session.user_state eq '9'}">
									<li><a href="./getMisAllotTm">기존방식</a></li>
								</c:if>
								<li><a href="./getMisAllotTmNew">일일배당현황</a></li>								
							</ul>
						</li>						
						<li class="depth1">
							<!-- <a href="#;">팀&개인&보험사</a> -->
							<a href="#;">수임현황</a>
							<ul>
								<li><a href="./getMisRegTm">수임현황</a></li>
								<!-- <li><a href="javascript:goReportTm();">손해사정서교부현황</a></li> -->
							</ul>
						</li>						
<!-- 						<li><a href="#;">현장및중간보고현황</a></li> -->
						<!-- 현장보고서 통계 시작 -->
						<li class="depth1">							
							<a href="#;">현장보고서</a>
							<ul>
								<li><a href="./getSiteReportAll">실시간 제출현황</a></li>
								<li><a href="./getSiteReportDaily">일자별 제출현황</a></li>								
							</ul>
						</li>						
						<!-- 현장보고서 통계 끝 -->

						<li class="depth1">
							<!-- <a href="#;">보험사별</a> -->
							<a href="#;">보험사별 통계</a>
							<ul>
								<li><a href="./MisBscPtnr">기본통계</a></li>
								<li><a href="./MisRegPtnr">수임현황</a></li>
								<li><a href="./MisEndPtnr">종결현황</a></li>
<!-- 								<li><a href="#;">수임현황</a></li> -->
<!-- 								<li><a href="#;">종결현황</a></li> -->
								<li><a href="./MisResultPtnr">청구내용</a></li>
								<li><a href="./ptnrStatMain">부서별 실적현황(신규)</a></li>
							</ul>
						</li>
						<!-- 현장보고서 통계 시작 -->
						<!-- <li class="depth1">							
							<a href="#;">현장관리 현황</a>
							<ul>
								<li><a href="./MisBscPtnr">현장보고서 제출현황</a></li>								
							</ul>
						</li> -->						
						<!-- 현장보고서 통계 끝 -->
						<!-- <li class="depth1">
							<a href="#;">적부</a>
							<ul>
								<li><a href="./getMisContractTm">적부(삼성)팀</a></li>
								<li><a href="./getMisContractUnitMbr">적부(삼성)개인</a></li>
								<li><a href="./getMisSuitabilityTm">적부(KB)팀</a></li>
								<li><a href="./getMisSuitabilityUnitMbr">적부(KB)개인</a></li>
								<li><a href="./getMisSuitability12Tm">적부(한화)팀</a></li>
								<li><a href="./getMisSuitability12UnitMbr">적부(한화)개인</a></li>
								<li><a href="./getMisSuitability17Tm">적부(흥국)팀</a></li>
								<li><a href="./getMisSuitability17UnitMbr">적부(흥국)개인</a></li>
							</ul>
						</li> -->						
						<c:if test="${mbrVo_Session.team_type ne 4}">
							<li class="depth1">
								<a href="#;">평가기준 달성도</a>
								<ul>
									<c:choose>
										<c:when test="${mbrVo_Session.user_no eq '966' 
													 || mbrVo_Session.user_no eq '215' 
													 || mbrVo_Session.user_no eq '1265'
													 || mbrVo_Session.user_no eq '1421'
													 || mbrVo_Session.user_no eq '551'
													 || mbrVo_Session.user_no eq '670'
													 || mbrVo_Session.work_job_cd eq '5'
													 || mbrVo_Session.user_state eq '9'}">
											<li><a href="./workloadStatistics?gubun=member&type=3">평가기준 달성도 (개인)</a></li>
											<li><a href="./workloadStatistics?gubun=adm&type=2">평가기준 달성도 (팀)</a></li>
											<li><a href="./workloadStatistics?gubun=adm&type=1">평가기준 달성도 (센터)</a></li>												
										</c:when>
										<c:otherwise>
											<c:if test="${mbrVo_Session.work_type_cd eq '3' or mbrVo_Session.work_type_cd eq '14'}">
												<li><a href="./workloadStatistics?gubun=team&type=2">평가기준 달성도 (팀)</a></li>
											</c:if>
											<c:if test="${mbrVo_Session.work_type_cd eq '14'}">
												<li><a href="./workloadStatistics?gubun=center&type=1">평가기준 달성도 (센터)</a></li>
											</c:if>
											<c:if test="${mbrVo_Session.work_type_cd eq '2'}">
												<li><a href="./workloadStatistics?gubun=center&type=2&extra=1">평가기준 달성도(팀)</a></li>
												<li><a href="./workloadStatistics?gubun=center&type=1&extra=1">평가기준 달성도(센터)</a></li>
											</c:if>
										</c:otherwise>
									</c:choose>
								</ul>
							</li>			
						</c:if>						
						<!-- <li class="depth1">
							<a href="#;">손해사정서</a>
							<ul>								
								<li><a href="javascript:goReportTm();">교부현황</a></li>
							</ul>
						</li> -->
						<li class="depth1">
							<a href="#;">기타관리</a>
							<ul>								
								<li><a href="javascript:goReportTm('old');"><font style="font-size:10px;">손해사정서 교부현황 (2025.09.31이전)</font></a></li>
								<li><a href="javascript:goReportTm('new');"><font style="font-size:10px;">손해사정서 교부현황 (2025.09.31이후)</font></a></li>
								<%--센터장만 체크하는 로직을 향후에 추가해야함. --%>
								<c:if test="${mbrVo_Session.user_no eq '1786' || mbrVo_Session.user_no eq '670'}">
								<li><a href="./writtenReviewManageOne">서면심사(물) 실적관리</a></li>
								</c:if>
								
								<c:if test="${mbrAuthVo_Session.mbr_pms_32 eq '1'}">
								<li><a href="./writtenReviewManage">서면심사(물) 실적등록</a></li>
								<li><a href="./writtenReviewManageNew">서면심사(물) 실적통계</a></li>
								</c:if>
								
								<c:if test="${mbrVo_Session.user_no eq '1265' || mbrVo_Session.user_no eq '215' || mbrVo_Session.user_no eq '966' || mbrVo_Session.user_state eq '9'}">													
								<!-- <li><a href="./writtenReviewManage">서면심사(물) 실적등록</a></li>
								<li><a href="./writtenReviewManageOne">서면심사(물) 실적관리</a></li>			
								<li><a href="./writtenReviewManageNew">서면심사(물) 실적통계</a></li> -->
								<li><a href="./expenseMain">이재조사비&middot;실시간조회</a></li>
								<li><a href="./expenseList">이재조사비&middot;결과목록</a></li>
								<li><a href="./expenseTeamList">이재조사비&middot;팀인원조회</a></li>								
								</c:if>
								<li><a href="#">---------적 부---------</a></li>
								<!-- 적부메뉴 이전 시작-->
								<li><a href="./getMisContractTm">적부(삼성)팀</a></li>
								<li><a href="./getMisContractUnitMbr">적부(삼성)개인</a></li>
								<li><a href="./getMisSuitabilityTm">적부(KB)팀</a></li>
								<li><a href="./getMisSuitabilityUnitMbr">적부(KB)개인</a></li>
								<li><a href="./getMisSuitability12Tm">적부(한화)팀</a></li>
								<li><a href="./getMisSuitability12UnitMbr">적부(한화)개인</a></li>
								<li><a href="./getMisSuitability17Tm">적부(흥국)팀</a></li>
								<li><a href="./getMisSuitability17UnitMbr">적부(흥국)개인</a></li>
								<!-- 적부메뉴 이전 끝-->
							</ul>
						</li>						
					</ul>
				</div>
				<!-- //gnb -->
			</div>
		</div>
		<div class="h_leftbg">
		</div>
	</div>
	<form id="menuForm" name="menuForm">
		<input id="menuId" name="menuId" type="hidden"/>
	</form>
	<!-- //header -->

<%--</body>--%>

<%--</html>--%>
