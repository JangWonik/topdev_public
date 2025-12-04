<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_sysadm_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">MigrationRptCtrl</a></li>
								<li><a href="#">MigrationRptFile</a></li>
								<li><a href="#">MigrationLsAdmin</a></li>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;">
							ls_report_body 테이블의 복수 Data를 가진 컬럼을<br />
							top_rpt_ctrl / top_rpt_ctrl16의 2개 테이블로 마이그레이션 합니다.<br />
							<br /><br />
							<form action="./migrationRptCtrl">
								<input type="submit" value="make rpt_ctrl 메리츠 3 4 제외" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationRptCtrl16">
								<input type="submit" value="make rpt_ctrl16 메리츠 3 4 only" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
						</div><!-- //guestcnt4 -->

						<div class="guestcnt4" style="display:block;">
							ls_report_data 테이블의 복수 Data를 가진 컬럼을<br />
							top_rpt_file의 1개 테이블로 마이그레이션 합니다.<br />
							<br /><br />
							<form action="./migrationRptFile">
								<input type="submit" value="make rpt_file" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
						</div><!-- //guestcnt4 -->

						<div class="guestcnt4" style="display:block;">
							ls_admin 테이블의 복수 Data를 가진 컬럼을<br />
							sysadm_aprv_user 테이블로 마이그레이션 합니다.<br />
							<br /><br />
							<form action="./migrationLsAdmin34">
								<input type="submit" value="make admin_34" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationLsAdmin35">
								<input type="submit" value="make admin_35" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationLsAdmin38">
								<input type="submit" value="make admin_38" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
						</div><!-- //guestcnt4 -->

					</div><!-- //guest -->
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
