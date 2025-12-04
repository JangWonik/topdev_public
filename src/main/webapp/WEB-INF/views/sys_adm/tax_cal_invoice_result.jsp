<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
</head>

<script type="text/javascript">
	$(document).ready(function(){	
		
		$("#loading").hide();
		
		$("#doList").click( function(){
			$("#doTaxList").submit();
		});
		
	});
	
</script>

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
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<!-- 상단버튼시작 -->
						<div style="text-align:right;">							
							<input type="button" style="width:50px;" value="목록으로" id="doList" style="cursor:pointer"/>
						</div>						
						<!-- 탭메뉴 시작 -->
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">세금계산서자동등록결과</a></li>
							</ul>
						</div>
						<form id="doTaxList" name="doTaxList" method="get" action="taxCalInvoice">
						</form>
						<div class="guestcnt4" style="display:block;">
							<!-- 팝업목록 시작 -->
							<div class= "tableStyle2">
								<table>									
									<tr>
										<th>처리결과</th>
										<td>총 0 건의 세금계산서정보가 등록되었습니다.</td>											
									</tr>
								</table>
							</div>
							<!-- 팝업목록 끝 -->
						</div>

					</div>
				</div>
				<!-- //centercnt_bot -->

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
