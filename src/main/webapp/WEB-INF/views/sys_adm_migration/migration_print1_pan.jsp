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
								<li class="on"><a href="#">MigrationPrint1</a></li>
								<li><a href="#">MigrationPrint9</a></li>
								<li><a href="#">MigrationPrint16</a></li>
								<li><a href="#">MigrationPrint17</a></li>
								<li><a href="#">MigrationPrint1700</a></li>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;">
							ls_report_1 테이블의 복수 Data를 가진 컬럼을<br />
							print_1_2 / print_1_5 / print_1_6_1 / print_1_6_2 / print_1_8의 5개 테이블로 마이그레이션 합니다.<br />
							<br /><br />
							<form action="./migrationPrint12">
								<input type="submit" value="make print_1_2" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint15">
								<input type="submit" value="make print_1_5" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint161">
								<input type="submit" value="make print_1_6_1" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint162">
								<input type="submit" value="make print_1_6_2" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint18">
								<input type="submit" value="make print_1_8" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
						</div><!-- //guestcnt4 -->

						<div class="guestcnt4" style="display:block;">
							ls_report_9 테이블의 복수 Data를 가진 컬럼을<br />
							print_9_5_1 / print_9_5_2 / print_9_6 / print_9_8의 4개 테이블로 마이그레이션 합니다.<br />
							<br /><br />
							<form action="./migrationPrint951">
								<input type="submit" value="make print_9_5_1" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint952">
								<input type="submit" value="make print_9_5_2" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint96">
								<input type="submit" value="make print_9_6" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint98">
								<input type="submit" value="make print_9_8" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
						</div><!-- //guestcnt4 -->

						<div class="guestcnt4" style="display:block;">
							ls_report_16 테이블의 복수 Data를 가진 컬럼을<br />
							print_16_3 / print_16_4의 2개 테이블로 마이그레이션 합니다.<br />
							추 후, e_1 마이그레이션 필요, 2016.07.20. 현재는 데이터 없어서 마이그레이션 보류.<br />
							<br /><br />
							<form action="./migrationPrint163">
								<input type="submit" value="make print_16_3" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint164">
								<input type="submit" value="make print_16_4" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
						</div><!-- //guestcnt4 -->

						<div class="guestcnt4" style="display:block;">
							ls_report_17 테이블의 복수 Data를 가진 컬럼을<br />
							print_17_2 / print_17_4 / print_17_7 / print_17_13의 4개 테이블로 마이그레이션 합니다.<br />
							<br /><br />
							<form action="./migrationPrint172">
								<input type="submit" value="make print_17_2" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint174">
								<input type="submit" value="make print_17_4" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint177">
								<input type="submit" value="make print_17_7" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
							<br /><br />
							<form action="./migrationPrint1713">
								<input type="submit" value="make print_17_13" /> 주의! 기존의 Data가 모두 삭제됩니다!
							</form>
						</div><!-- //guestcnt4 -->

						<div class="guestcnt4" style="display:block;">
							ls_report_1700 테이블의 복수 Data를 가진 컬럼을<br />
							print_1700_7의 1개 테이블로 마이그레이션 합니다.<br />
							<br /><br />
							<form action="./migrationPrint17007">
								<input type="submit" value="make print_1700_7" /> 주의! 기존의 Data가 모두 삭제됩니다!
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
