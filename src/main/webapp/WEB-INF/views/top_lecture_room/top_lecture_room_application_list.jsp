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
	<script>
		function viewPopReturnReason(serialNo){
			var url = "./popReturnReasonView?serial_no=" + serialNo;
			var winWidth = 1000;
			var winHeight = 300;
			var popupOption = "width=" + winWidth + ", height=" + winHeight;
			window.open(url,"",popupOption);			
		}
		
		function fnUpdateLectureRoomApplication(serialNo,date){
			var url = "./popMyApplicationUpdate?serial_no=" + serialNo+"&lecture_room_date="+date;
			var winWidth = 1000;
			var winHeight = 500;
			var popupOption = "width=" + winWidth + ", height=" + winHeight;
			window.open(url,"",popupOption);				
		}
		
		function fnDeleteLectureRoomApplication(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$("#serial_no").val(serialNo);
				$("#deleteFrm").submit();
			}
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
								<li class="on"><a href="#">나의 강의실 신청 현황</a></li>
							</ul>
						</div>
						<div style ="text-align:left; margin-top:5px;">
							<input type="hidden" id="viewFromDate" name="fromdate" value="${fromdate}"/>
							<input type="hidden" id="viewToDate" name="todate" value="${todate}"/>
						</div>
						<div class="guestcnt4" style="display:block;height:650px;">
						 <b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 나의 강의실 신청 현황</b>
								<br>
								<div class= "tableStyle2">
									<table>
										<thead>
											<colgroup>
												<col width="3%">
												<col width="10%">
												<col width="7%">
												<col width="10%">
												<col width="50%">
												<col width="10%">
												<col width="10%">
											</colgroup>
											<tr>
												<th>no</th>
												<th>신청일시</th>
												<th>참여인원</th>
												<th>사용기간</th>
												<th>내용</th>
												<th>상태</th>
												<th>비고</th>
											</tr>
											<c:forEach items="${myLectureRoomInfo}" var="item" varStatus="status" >
												<tr>
													<td>
														${status.count}
														<input type="hidden" id="returnReason${item.serialNo}" value="${item.returnReason}"/>
													</td>
													<td>${item.applicationDate}</td>
													<td>${item.participationPersonnel}</td>
													<td>${item.lectureRoomDate}<br />${item.startTime}~ ${item.endTime}</td>
													<td>${item.content}</td>
													<td>
														<c:if test="${item.state == 0}">결재대기</c:if>
														<c:if test="${item.state == 1}">결재승인</c:if>
														<c:if test="${item.state == 2}">반려</c:if>
													</td>
														<c:choose>
															<c:when test="${item.state == 0}">
																<td>
																	<input type="image" src="./resources/ls_img/btn_edit_s.gif" onclick="fnUpdateLectureRoomApplication('${item.serialNo}','${item.lectureRoomDate}')" style ="cursor:pointer" />
																	<input type="image" src="./resources/ls_img/btn_del_s.gif" onclick="fnDeleteLectureRoomApplication('${item.serialNo}')" style ="cursor:pointer" />
																</td>
															</c:when>
															<c:when test="${item.state == 2}">
																<td>
																	<input type="image" src="./resources/ne_img/btn/btn_search.gif" onclick="viewPopReturnReason('${item.serialNo}');" style ="cursor:pointer" />
<%-- 				 													<input type="button" value="반려사유" onclick="viewPopReturnReason('${item.serialNo}');">  --%>
																</td>
															</c:when>
															<c:otherwise>
																<td>-</td>
															</c:otherwise>
														</c:choose>
												</tr>
											</c:forEach>	
										</tbody>
									</table>
									
									<form id="deleteFrm" action="/deleteLectureRoomApplication">
										<input type="hidden" id="serial_no" name="serial_no" value="" />
									</form> 
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