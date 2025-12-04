<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>휴가 신청</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	
	<script src="./resources/ne_js/calendar.js"></script>
	<script type="text/javascript">
		function lectureRoomApply(){
			if($("#dayoffFromDate").val() == ""){
				alert("강의실 사용 날짜를 선택해주세요.");
				$("#dayoffFromDate").focus();
				return;
			}
			var selectStartHour = $("#selectStartHour option:selected").val();
			if(selectStartHour.length == 1){
				selectStartHour = "0" + selectStartHour;
			}
			var selectEndHour = $("#selectEndHour option:selected").val();
			if(selectEndHour.length == 1){
				selectEndHour = "0" + selectEndHour;
			}
			var selectStartMinute = $("#selectStartMinute option:selected").val();
			if(selectStartMinute == 0){
				selectStartMinute = "00";
			}
			var selectEndMinute = $("#selectEndMinute option:selected").val();
			if(selectEndMinute == 0){
				selectEndMinute = "00";
			}
			
			var param ={};
			param.lectureRoomDate					= $("#dayoffFromDate").val();
			param.lectureRoomStartTime 			=  selectStartHour +  selectStartMinute;
			param.lectureRoomEndTime	 			=  selectEndHour   +  selectEndMinute;
			param.contents	   							= $("#contents").val();
			param.participation_personnel	   		= $("#participation_personnel").val();
			param.user_no								= ${lectureRoomInfo.userNo};
			param.team_type							= ${lectureRoomInfo.teamType};
			
			
			
			var date = $("#dayoffFromDate").val();
			var year = date.substring(0,4);
			var month = date.substring(5,7);
			
			if(param.lectureRoomStartTime >= param.lectureRoomEndTime){
				alert("시간을 올바르게 선택해주세요.");
				return;
			}
			
			
			var url = "./lectureRoomIns";
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "JSON",
                timeout: 20000,
                success: function(data){
//                 	alert(data);
                	if(data == 1){
						alert("이미 신청된 시간입니다.");
                	}else{
						alert("신청되었습니다.");
						window.self.close();
// 						window.opener.location.assign("./lectureRoomCalendar?selectYear=" + year + "&selectMonth=" + month);					
						window.opener.location.assign("./lectureRoomApplicationList");					
                	}
                },
				error: function(xhr, status, error){
                    if(xhr.status == "901"){
                        fnWinClose();
                    }else{
                        alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                    }
				},
                beforeSend : function(xmlHttpRequest){
                    xmlHttpRequest.setRequestHeader("AJAX", "true");
                }
			});
			
			
		}
	

	
	</script>
	</head>
	<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 강의실 사용 신청 </span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">&nbsp;강의실 사용 신청</a></li>
							</ul>
						</div>
						
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
						<div class= "tableStyle2">
<!-- 							<input type="hidden" id="dayoffCnt" name="dayoffCnt" /> -->
							<input type="hidden" id="team_id" name="team_id" value="${team_id}" />
							<table cellpadding="0" cellspacing="0">
									<colgroup>
											<col width="20%">
											<col width="80%">
									</colgroup>
									<tr align="center">
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                        	<p align="center"><b><font color="#003399">기간</font></b></p>
<!-- 				                            <p align="center"><b>기간</b></p> -->
				                        </td>
				                        <td style="text-align:center;">
				                        	<input type="text" id="dayoffFromDate" name="dayoffFromDate" value="${lecture_room_date}" style="width:80px;"/>
				                        	<select id="selectStartHour" name="selectHour" style="width:50px;">
				                        		<c:forEach var="Hour" begin="0" end="23" step="1">
														<option value="${Hour}">${Hour}</option>
												</c:forEach>
				                        	</select>시
				                        	<select id="selectStartMinute" name="selectMinute" style="width:50px;">
				                        		<c:forEach var="Minute" begin="0" end="50" step="10">
													<option value="${Minute}">${Minute}</option>
												</c:forEach>
				                        	</select>분
				                        	 &nbsp;~&nbsp; 
				                        	<select id="selectEndHour" name="selectHour" style="width:50px;">
				                        		<c:forEach var="Hour" begin="0" end="23" step="1">
														<option value="${Hour}">${Hour}</option>
												</c:forEach>
				                        	</select>시
				                        	<select id="selectEndMinute" name="selectMinute" style="width:50px;">
				                        		<c:forEach var="Minute" begin="0" end="50" step="10">
														<option value="${Minute}">${Minute}</option>
												</c:forEach>
				                        	</select>분				                        	 
				                        </td>
				                    </tr>
									<tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                        	<p align="center"><b><font color="#003399">참여인원</font></b></p>
				                        </td>
				                        <td>
				                        	<input type="text" id="participation_personnel" name="participation_personnel" style="width:50px;"/>명
				                        </td>
				                    </tr>				                    
									<tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                        	<p align="center"><b><font color="#003399">내용</font></b></p>
				                        </td>
				                        <td>
				                        	<input type="text" id="contents" name="contents" style="width:95%;"/>
				                        </td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">이름</font></b></p>
				                        </td>
				                        <td>${lectureRoomInfo.userName}</td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">근무부서</font></b></p>
				                        </td>
				                        <td>${lectureRoomInfo.teamName}</td>
				                    </tr>
				                    <tr>
				                        <td bgcolor="#F8F8F8" class="td" height="28">
				                            <p align="center"><b><font color="#003399">직위</font></b></p>
				                        </td>
				                        <td>${lectureRoomInfo.workLevelNm}</td>
				                    </tr>

							</table>
						</div>
						<br>
						<p align="center">
							<img src="./resources/ls_img/btn_request.gif" onclick="lectureRoomApply();" style="cursor:pointer;"/>
						</p>
						</div>
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->
	<form action="/checkApplicationTime" id="checkFrm">
		<input type="hidden" name="lecture_room_date" value="${lecture_room_date}" >
	</form>
	<!-- footer -->
<%-- 	<c:import url="../top_main/top_pop_footer.jsp"></c:import> --%>
	<!-- //footer -->

</body>

	<script type="text/javascript">
// 		$(document).ready(function() {
// 			_initSelectBox();

// 		});
	
	
// 	function _initSelectBox(){
// 		var selectBoxHour = [];
// 		var selectBoxHourValue = "";
		
// 		for(var i = 0; i < 15; i++){
// 			value = i + 9;
			
// 			selectBoxHour[i] = "<option value=" + value + ">" + value + "</option>";
// 			console.log(selectBoxHour[i]);
// 			}	
// 		$("#selectHour").append(selectBoxHour.join(''));
// 		console.log(selectBoxHour);
// 	}
	</script>
	