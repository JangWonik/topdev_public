<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


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
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script type="text/javascript">
	function PopApplicationForm(){
		var lectureRoomDate = "${lecture_room_date}";
		var url = "./lectureRoomApplication?lecture_room_date="+lectureRoomDate;
		var winWidth = 1000;
		var winHeight = 500;
		var popupOption = "width=" + winWidth + ", height=" + winHeight;
		window.open(url,"",popupOption);			
	}
	</script>
</head>
<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->
	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<!-- left_cnt -->
			<c:import url="/top_main_left"></c:import>
			<!-- //left_cnt -->
			<!-- centercnt_top -->
			<div class="center_cnt" >
				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2" style="height:722px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">강의실 사용 현황</a></li>
								<img src="./resources/ls_img/btn_request.gif" onclick="PopApplicationForm();" style="cursor:pointer;float:right;" >
							</ul>
<!-- 							<img src="./resources/ls_img/btn_request.gif" onclick="PopApplicationForm();" style="cursor:pointer;float:right;" > -->
						</div>
						<div style ="text-align:left; margin-top:5px;"></div>
						<div class="guestcnt4" style="display:block;width:960px;">
						 <b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/>${lecture_room_date}일자 강의실 사용 현황</b><br />
							<input type="hidden" id="lecture_room_date" name="lecture_room_date" value="${lecture_room_date}"><br>
								<div class= "tableStyle2">
									<table>
										<thead>
											<colgroup>
												<col width="5%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="7%">
												<col width="58%">
											</colgroup>
											<tr>
												<th>no</th>
												<th>시간</th>
												<th>부서</th>
												<th>신청자</th>
												<th>참여인원</th>
												<th>내용</th>
											</tr>
											
											<c:forEach items="${lectureRoomList}" var="item" varStatus="status" >
<%-- 												<c:if test="${item.state == 1}"> --%>
													<tr>
														<td>${status.count}</td>
														<td>${item.startTime} ~ ${item.endTime}</td>
														<td>${item.teamName}</td>
														<td>${item.userName}</td>
														<td>${item.participationPersonnel}</td>
														<td>${item.content}</td>
													</tr>
<%-- 												</c:if> --%>
											</c:forEach>	
									</table>
							</div><!-- //tableStyle2 -->
						</div>
					</div>
				</div>
				<!-- //centercnt_bot -->
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
</div>
<!-- //wrapper -->
</body>
</html>