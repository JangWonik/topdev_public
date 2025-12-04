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
								<li class="on"><a href="#">인사정보 별도조회</a></li>
							</ul>
						</div>
						<div class="tableStyle2">
							<table>
								<tr>
									<th width="5%">순번</th>
									<th>센터명</th>
									<th>팀명</th>
									<th>이름</th>
									<th width="25%">회사명</th>
									<th>경력개월수</th>
									<th width="2%"></th>
								</tr>										
							</table>								
						</div>
						<div class="tableStyle2" style="height:600px;overflow:auto;">								
							<table>															
								<c:forEach items="${memberList}" var="item" varStatus="status">																				
									<tr>
										<td width="5%">${memberList.size()-status.index}</td>
										<td>${item.center_name}</td>										
										<td>${item.team_name}</td>
										<td>${item.user_name}</td>
										<td width="25%">${item.career_corporate_name}</td>
										<td>${item.career_date_val} (${item.career_date})</td>																																							
									</tr>									
								</c:forEach>								
							</table>
						</div>

					</div>
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