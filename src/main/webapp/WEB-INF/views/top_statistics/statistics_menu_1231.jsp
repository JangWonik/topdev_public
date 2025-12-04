<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

</body>

</html>
