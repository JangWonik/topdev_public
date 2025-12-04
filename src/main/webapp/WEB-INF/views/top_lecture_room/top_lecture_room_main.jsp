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
	<link rel="stylesheet" href="./resources/jquery/themes/smoothness/jquery-ui.css">
	<script src="./resources/jquery/jquery.js"></script>
	<script src="./resources/jquery/jquery-ui.js"></script>
	<script>
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$(".selectDate").change(function(){
				searchMonthForm.submit();
			});
		});//ready
	</script>
</head>
<body>
	<script>
		function fnViewLectureRoomApplication(day){
			year						= $("#year").val();
			month					= $("#month").val();
			
			if(day.length == 1){
				day = "0" + day;
			}
			
			var lecture_room_date =   year + "-" + month + "-" + day;
			$("#lecture_room_date").val(lecture_room_date);
			
			$("#lectureRoomDateFrm").submit();
			return;
			
		}
	</script>
<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">
			
			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">강의실 사용 신청 현황</a></li>
								<c:if test="${mbrAuthVo_Session.mbr_pms_27 == '1'}">
<!-- 									<li style="text-align:right;float:right;"> -->
										<input type="button" value=" 결재내역 " class="button" style="float:right;" onclick="window.location.href='/lectureRoomApproveList'">
<!-- 									</li> -->
								</c:if>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;">

							<form id="searchMonthForm" name="searchMonthForm" action="./lectureRoomCalendar" >
								<p style="margin-bottom:5px;text-align:left;">
									${selectedYear}년 ${selectedMonth}월
									
									<select class="selectDate" id="selectYear" name="selectYear">
										<c:forEach items="${yearList}" var = "yearVo">
											<option value="${yearVo}"
												<c:if test="${yearVo == selectedYear}">selected</c:if> >
												${yearVo}
											</option>
										</c:forEach>
									</select>
									
									<select class="selectDate" id="selectMonth" name="selectMonth">
										<c:forEach begin="1" end="12" step="1" var="monthVo">
											<option value="${monthVo}"
												<c:if test="${monthVo == selectedMonth}">selected</c:if> >
												${monthVo}
											</option>
										</c:forEach>
									</select>
								</p>
							</form>

							<div class= "tableStyle2" style="height:450px;">
								<form id="lectureRoomDateFrm" action="/lectureRoomList" method="POST">
									<input type="hidden" id="year" name="year" value="${selectedYear}">
									<input type="hidden" id="month" name="month" value="${selectedMonth}">
									<input type="hidden" id="lecture_room_date" name="lecture_room_date" value="">
									
									<table>
										<tr>
											<th><font color="red">일</font></th>
											<th>월</th>
											<th>화</th>
											<th>수</th>
											<th>목</th>
											<th>금</th>
											<th><font color="blue">토</font></th>
										</tr>
										<tr>
											<c:forEach var="blankTdVar" begin="1" end="7" step="1">
												<c:if test="${blankTdVar < startYoil}">
													<td style="height:70px;"></td>
												</c:if>
											</c:forEach><!-- //make blank td -->
											<c:forEach items="${oneMonthList}" var="oneMonthVo" varStatus="status">
												<td style="height:95px;text-align:left;cursor:pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
												valign="top" onclick="fnViewLectureRoomApplication('${status.index + 1}');">
													<c:choose>
														<c:when test="${oneMonthVo.holiday_code == 0}">
															<font color="red">
																<b><span class="holidayDialogOpenBtn">${status.index + 1}</span>
																<br />${oneMonthVo.holiday_basis}</b>
															</font>
														</c:when>
														<c:when test="${oneMonthVo.holiday_yoil == 1}">
															<font color="red">
																<b><span class="holidayDialogOpenBtn">${status.index + 1}</span></b>
															</font>
														</c:when>
														<c:when test="${oneMonthVo.holiday_yoil == 7}">
															<font color="blue">
																<b><span class="holidayDialogOpenBtn">${status.index + 1}</span></b>
															</font>
														</c:when>
														<c:otherwise>
															<b><span class="holidayDialogOpenBtn" style="text-align:left;vertical-align:top;">${status.index + 1}</span></b>
														</c:otherwise>
													</c:choose>
													<br />
													
													<c:set var="sum" value="0" />
													<c:forEach items="${lectureRoomList}" var="item" varStatus="subStatus">
														<c:if test="${item.day == status.index + 1 && item.state == 1 && sum < 3}">
															ㆍ${item.startTime} ~ ${item.endTime} ${item.userName} 
															<c:set var="sum" value="${ sum + 1 }" />
															<c:choose>
																<c:when test="${item.teamType != 4}">
																	<font color="red">
																		[1종]
																	</font>
																</c:when>
																<c:otherwise>
																	<font color="blue">
																		[4종]
																	</font>																	
																</c:otherwise>
															</c:choose>
															 <br />
														</c:if>
													</c:forEach>					
																		
												</td>
												<c:if test="${oneMonthVo.holiday_yoil == 7}">
											</tr>
											<tr>
												</c:if>
											</c:forEach><!-- //oneMonthList -->
										</tr>
									</table>
								
								</form>
								
								
							</div><!-- //tableStyle2 -->
							<br />
						</div><!-- //guestcnt4 -->

					</div><!-- //guest -->
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
<style type="text/css">
.button{
	width:60px;
	hight:20px;
    background-color: #D7F1FA;
    color:#4C4C4C;
    text-align: center;
	border-radius:5px;
    font-size: 13px;
    cursor: pointer;
    text-decoration:none;
    border: 1px solid #A6A6A6;
    }
</style>
