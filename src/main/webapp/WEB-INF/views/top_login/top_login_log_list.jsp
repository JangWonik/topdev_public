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
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_state}' != 9){
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#userSearchBtn").click(function(){
				$("#mbrNo").val($("#mbrNo1").val());
				$("#mbrNm").val($("#mbrNm1").val());
				$("#searchForm").attr("action","topLogInLogList");
				searchForm.submit();
			});/* $("#userSearchBtn").click */

			/***** 엑셀다운로드 *****/
			$("#btn_excel").click(function(){
				$("#mbrNo").val($("#mbrNo1").val());
				$("#mbrNm").val($("#mbrNm1").val());
				$("#searchForm").attr("action","topLogInLog_Excel");
				searchForm.submit();
			});

		}); //document.ready
	</script>
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
								<li class="on"><a href="#">웹 로그인 Log</a></li>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;" id="tab_topLogInLog">

							<div class="tableStyle2">
								<c:import url="../util_etc/module_mbrpop_1.jsp"></c:import>
								<table>
									<tr>
										<th>no</th>
										<th>아이디 No</th>
										<th>아이디</th>
										<th>이름</th>
										<th>IP</th>
										<th>접속시간</th>
									</tr>
									<c:forEach items="${getLogInLogList}" var="getLogInLogList">
										<tr>
											<td>${getLogInLogList.getSerial_no()}</td>
											<td>${getLogInLogList.getUser_no()}</td>
											<td>${getLogInLogList.getUser_id()}</td>
											<td>${getLogInLogList.getUser_name()}</td>
											<td>${getLogInLogList.getIp_addr()}</td>
											<td>${getLogInLogList.getReg_date()}</td>
										</tr>
									</c:forEach>
								</table>
							</div><!-- //tableStyle2 -->

							<table border="0" style="margin-top:7px;">
								<tr>
									<td>
										<!-- page start -->
										<c:import url="../util_page/page_bsc_2.jsp" charEncoding="UTF-8"></c:import>
										<!-- //page end -->
									</td>
									<td align="right">
										<img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0" style="vertical-align:middle;" />
										이름 검색 :
										<input type="image" src='./resources/ls_img/member/icon_search.gif' class="popOpenBtn" value="1" />
										<input type="hidden" id="mbrNo1"
											value='<c:if test="${mbrNo != ''}">${mbrNo}</c:if>' />
										<input type="text" id="mbrNm1" readonly style="background-color:lightgrey;"
											value='<c:if test="${user_nm != ''}">${mbrNm}</c:if>' />
										<input type="button" id="userSearchBtn" value="로그검색" />
										<input type="image" src="./resources/ls_img/btn_excel.gif" id="btn_excel"/>&nbsp;&nbsp;
										<form action="topLogInLogList" method="get" id="searchForm">
											<input type="hidden" id="mbrNo" name="mbrNo" />
											<input type="hidden" id="mbrNm" name="mbrNm" />
										</form>
									</td>
								</tr>
							</table>

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
