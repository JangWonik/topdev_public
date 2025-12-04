<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js?v=201706141814"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>
	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>
	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
		
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
    <script src="./resources/cmm/js/common.js?v=201707311012"></script>	
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_state}' != 9){
				window.location.assign("./logout");
			}
		});//ready
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
			<!-- centercnt_top -->
			<div class="center_cnt_1300_ds">
				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">삭제파일관리대장</a></li>
							</ul>
						</div>
						<div class="guestcnt_1300_ds" style="display:block; height:700px !important;">
							<div class="tableStyle4"><!--tableStyle4--><!--2016.01.14.rjh.수정.삽입.-->
								<form name="delForm" id="delForm" action="delFileReportList" method="post">
									<table>
										<tr>
											<th>담당자</th>
											<td>
												<input type="text" id="writer" name="writer" value="홍기헌"/>
											</td>
										</tr>	
										<tr>
											<th>작성일자</th>
											<td>
												<input type="text" id="writeDate" name="writeDate" class="classCalendar" value="${sToday}">  
											</td>
										</tr>
										<tr>
											<th>탬플릿 종류</th>
											<td>
												<select name="tempSel" id="tempSel">
													<option value="email">메일</option>
													<option value="fax">웹팩스</option>
													<option value="mobile">핸드폰</option>
													<option value="scan">스캔</option>
												</select>
											</td>
										</tr>			
										<tr>
											<td colspan="2" align="center">
												<input type="submit" value="확인" />
											</td>
										</tr>										
									</table>
								</form>
							</div>
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
<script>
	$(document).ready(function () {
	    //_initButton();
	});	
</script>
</body>
</html>