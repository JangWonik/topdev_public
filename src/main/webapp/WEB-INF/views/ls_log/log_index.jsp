<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
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
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<div id="header">
		<div class="inner clear_v2">
			<h1>
				<a href="./"><img src="./resources/wm_img/common/logo.gif" alt="top - TRUST OBLIGATION PASSION" /></a>
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
						<li><a href="./search_state">보고서현황</a></li>
						<li class="depth1">
							<a href="#;">팀&개인</a>
							<ul>
								<li><a href="./getMisTmBsc">기본통계</a></li>
								<li><a href="./log_nsc_team">통합매출<!-- 기본통계2 (농작물, 적부 & 통합매출) --></a></li>
								<li><a href="./end_team">종결현황</a></li>
								<li><a href="./result_team">청구내용</a></li>
								<li><a href="./save_log">정산내역</a></li>
								<li><a href="./work_team">업무처리현황</a></li>
							</ul>
						</li>
						<li class="depth1">
							<a href="#;">팀&개인&보험사</a>
							<ul>
								<li><a href="./reg_team;">수임현황</a></li>
							</ul>
						</li>
						<li class="depth1">
							<a href="#;">보험사별</a>
							<ul>
								<li><a href="./log_ig">기본통계</a></li>
								<li><a href="./reg_ig">수임현황</a></li>
								<li><a href="./end_ig">종결현황</a></li>
								<li><a href="./result_ig">청구내용</a></li>
							</ul>
						</li>
						<li><a href="./accept_team">일일배당현황</a></li>
						<li><a href="./getReportMidList">현장및중간보고현황</a></li>
						<li class="depth1">
							<a href="#;">적부</a>
							<ul>
								<li><a href="./contract_team">적부(삼성)팀</a></li>
								<li><a href="./contract_unit">적부(삼성)개인</a></li>
								<li><a href="./suitability_team">적부(KB)팀</a></li>
								<li><a href="./suitability_unit">적부(KB)개인</a></li>
								<li><a href="./suitability_12_team">적부(한화)팀</a></li>
								<li><a href="./suitability_12_unit">적부(한화)개인</a></li>
								<li><a href="./suitability_17_team">적부(흥국)팀</a></li>
								<li><a href="./suitability_17_unit">적부(흥국)개인</a></li>
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
	<!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns2">
			<div class="center_cnt2">

				<c:choose>
					<c:when test="${pgid == 'log_team'}">
						<c:import url="./log_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'log_member'}">
						<c:import url="./log_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'log_member2_main'}">
						<c:import url="./log_member2_main.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'ls_report_pop'}">
						<c:import url="./ls_report_pop.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'log_nsc_team'}">
						<c:import url="./log_nsc_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'log_nsc_member'}">
						<c:import url="./log_nsc_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'log_ig'}">
						<c:import url="./log_ig.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'reg_ig'}">
						<c:import url="./reg_ig.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'reg_ig_month'}">
						<c:import url="./reg_ig_month.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'reg_ig_team'}">
						<c:import url="./reg_ig_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'reg_ig_member'}">
						<c:import url="./reg_ig_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'reg_team'}">
						<c:import url="./reg_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'reg_team_ig'}">
						<c:import url="./reg_team_ig.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'reg_member'}">
						<c:import url="./reg_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'end_team'}">
						<c:import url="./end_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'end_member'}">
						<c:import url="./end_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'end_ig'}">
						<c:import url="./end_ig.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'end_ig_team'}">
						<c:import url="./end_ig_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'result_team'}">
						<c:import url="./result_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'result_member'}">
						<c:import url="./result_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'result_ig'}">
						<c:import url="./result_ig.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'result_ig_team'}">
						<c:import url="./result_ig_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'result_ig_member'}">
						<c:import url="./result_ig_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'save_log'}">
						<c:import url="./save_log.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'save_log_team'}">
						<c:import url="./save_log_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'accept_team'}">
						<c:import url="./accept_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'accept_member'}">
						<c:import url="./accept_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'work_team'}">
						<c:import url="./work_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'contract_team'}">
						<c:import url="./contract_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'contract_member'}">
						<c:import url="./contract_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'contract_member2'}">
						<c:import url="./contract_member2.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'contract_unit'}">
						<c:import url="./contract_unit.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_team'}">
						<c:import url="./suitability_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_member'}">
						<c:import url="./suitability_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_member2'}">
						<c:import url="./suitability_member2.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_unit'}">
						<c:import url="./suitability_unit.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_12_team'}">
						<c:import url="./suitability_12_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_12_member'}">
						<c:import url="./suitability_12_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_12_member2'}">
						<c:import url="./suitability_12_member2.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_12_unit'}">
						<c:import url="./suitability_12_unit.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_17_team'}">
						<c:import url="./suitability_17_team.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_17_member'}">
						<c:import url="./suitability_17_member.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_17_member2'}">
						<c:import url="./suitability_17_member2.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'suitability_17_unit'}">
						<c:import url="./suitability_17_unit.jsp"></c:import>
					</c:when>
					<c:when test="${pgid == 'search_state'}">
						<c:import url="./search_state.jsp"></c:import>
					</c:when>
					<c:otherwise>
						<c:import url="./log_body.jsp"></c:import>
					</c:otherwise>
				</c:choose>

			</div><!-- //center_cnt -->

		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<div class="logfooter">
		<!-- inner -->
		<div class="inner">
			<ul class="infolist">
				<li>서울특별시 마포구 마포대로 63-8, 301(도화동, 삼창프라자 빌딩) </li>
				<li>전화 070-8255-3000</li>
				<li>팩스 02-338-3234</li>
				<li><a href="javascript:history.back(-1);"><img src="./resources/ls_img/icon_copy_back.gif"></a></li>
				<li><a href="#"><img src="./resources/ls_img/icon_copy_top.gif"></a></li>
			</ul>
		</div>
		<!-- //inner -->
	</div>
	<!-- //footer -->
</div>
<!-- //wrapper -->

</body>
</html>