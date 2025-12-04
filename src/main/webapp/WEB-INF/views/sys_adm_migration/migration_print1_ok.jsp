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
								<li class="on"><a href="#">After Migration Work</a></li>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;">
							Data 마이그레이션이 완료 되었습니다.<br />
							<br />
							**********************************************************************<br />
							make print_1_5 추가 수기 작업<br />
							select serial_no, CHAR_LENGTH(process_date_s), process_date_s from top_rpt_print_1_5<br />
							where CHAR_LENGTH(process_date_s) > 11;<br />
							select serial_no, CHAR_LENGTH(process_date_e), process_date_e from top_rpt_print_1_5<br />
							where CHAR_LENGTH(process_date_e) > 11;<br />
							수기 작업 전 process_date_s -> varchar(50)<br />
							수기 작업 후 process_date_s -> varchar(20)<br />
							**********************************************************************<br />
							<br />
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
