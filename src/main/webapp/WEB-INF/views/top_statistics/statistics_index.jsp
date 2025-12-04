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
</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_statistics/statistics_menu.jsp"></c:import>
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
					<c:when test="${pgid == 'log_member2'}">
						<c:import url="./log_member2.jsp"></c:import>
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
					<c:when test="${pgid == 'report_mid_list'}">
						<c:import url="./report_mid_list.jsp"></c:import>
					</c:when>
					<c:otherwise>
						<c:import url="./statistics_default.jsp"></c:import>
					</c:otherwise>
				</c:choose>

			</div><!-- //center_cnt -->

		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>