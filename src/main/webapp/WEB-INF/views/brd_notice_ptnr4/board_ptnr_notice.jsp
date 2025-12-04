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
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_12}' == 0){
				window.location.assign("./logout");
			}
		});//ready
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">보험사공지(4종)</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class="tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="20%"> 그 룹 </th>
											<th width="10%"> 보 종 </th>
											<th width="50%"> 회 사 명 </th>
											<th width="10%"> 공 지 사 항 </th>
											<th width="10%"> 비 고 </th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${ptnrBoardlist}" var="ptnrBoardlist">
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<c:choose>
													<c:when test="${ptnrBoardlist.ptnr_level == 0}">
														<td bgcolor="#e7ecf1" rowspan="${ptnrBoardlist.ptnr_group_order_cnt}">${ptnrBoardlist.ptnr_name}</td>
													</c:when>
													<c:otherwise>
														<td> 4 종 </td>
														<td>
															<c:choose>
																<c:when test="${ptnrBoardlist.ptnr_name != ''}">${ptnrBoardlist.ptnr_name}</c:when>
																<c:otherwise>-</c:otherwise>
															</c:choose>
														</td>
														<td>
															<c:if test="${ptnrBoardlist.ptnr_notice_cnt > 0}"> 있 음 </c:if>
														</td>
														<td>
															<a href="./noticePtnr4BoardList?insu=${ptnrBoardlist.ptnr_id}"><img alt="" src="./resources/ls_img/ls_board/btn_edite.gif"></a>
														</td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->
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
