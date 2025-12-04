<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<style>
		.tableStyle2 td{
			letter-spacing : 0px;
		}
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #E0F2F7;
		}
		
		.tableStyle2 td {letter-spacing: 0;}	
	</style>
	<script>
		$(document).ready(function(){
			
			$("#srchState").select2();
			$("#srchTeamId").select2();
			
			$("#srchState").val(0).trigger('change');
			
			_initCalendar();
			
			$("#searchStr").focus();
			
		});//$(document).ready
		
		
		function fnSearch(){			
			var formData = $("#searchFrm").serialize();
			$.ajax({
	 			type : "post",
	 			url : "/getTopStaffListNewAjax",
	 			data : formData,
	 			success : function(result){
	 				$("#divInfoTable").hide();
	 				$("#divMemberList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
		}
		
		function enterKey(){
			if( event.keyCode == 13 ){			
				fnSearch();			
			}
		}
		
		function doOrderJoinDate( p_order ){
			$("#joinDateOrder").val(p_order);
			$("#outDateOrder").val('');
			fnSearch();
		}
		
		function doOrderOutDate( p_order ){
			$("#joinDateOrder").val('');
			$("#outDateOrder").val(p_order);
			fnSearch();
		}
		
		function fnClear(){
			$("#joinDateOrder").val('');
			$("#outDateOrder").val('');
			fnSearch();
		}
		
		function popStaffDetail(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=880; //띄울 창의 넓이
			var sh=700;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('topStaffDetail?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function _initCalendar(){    	 
	  		$('.calendar').datepicker({
	  			showOn: 'button',
	  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	  			buttonImageOnly: true,
	  			buttonText: "달력", 
	  			changeMonth: true,
	  			changeYear: true,	    	   
	  			showButtonPanel: false,
	  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	  			dayNamesMin: ['일','월','화','수','목','금','토'],
	  			dateFormat: 'yy-mm-dd',
	  			firstDay: 0,
	  			isRTL: false,
	  			showMonthAfterYear: true
	  	    }); 		
	  		
	  	}
		
		//엑셀다운로드
		function doDownload(){
			$("#searchFrm").attr("action","topStaffListNewExcel");
			$("#searchFrm").submit();
		}
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
			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<!-- centercnt_bot -->
				<div class="center_cnt_vacation" >
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">입 / 퇴사 확인</a></li>
							</ul>
						</div>						
							<!-- 검색 테이블 시작-->
							<div class= "tableStyle2" style="padding-top: 10px;">								
								<form id="searchFrm">
								<input type="hidden" id="joinDateOrder" name="joinDateOrder" value="">
								<input type="hidden" id="outDateOrder" name="outDateOrder" value="">
									<table>										
										<tr>												
											<th width="120px;">재직상태</th>
											<th width="300px;">팀명</th>
											<th width="200px;">입사일자</th>
											<th width="200px;">퇴사일자</th>
											<th width="180px;">이름 / 전화번호 / 아이디</th>
											<th width="150px;"></th>
										</tr>										
										<tr>
											<td width="120px;">
												<select id="srchState" name="srchState" style="width:110px;">
													<option value="99">전체</option>
													<option value="0">근무중</option>
													<option value="3">휴직중</option>
													<option value="1">퇴사자</option>													
												</select>
											</td>
											<td width="300px;">
												<select id="srchTeamId" name="srchTeamId" style="width:280px;">
													<option value="" selected>전체</option>
													<c:forEach items="${teamList}" var = "teamVo">
														<c:choose>
															<c:when test="${srchArg.teamId == teamVo.team_id}" >
																<option value="${teamVo.team_id}" selected="selected">
															</c:when>
															<c:otherwise>
																<option value="${teamVo.team_id}">
															</c:otherwise>
														</c:choose>
														
														<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
														<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
														${teamVo.team_name}													
													</c:forEach>
												</select>
											</td>
											<td width="200px;">
												<input type="text" id="sJoinDate" name="sJoinDate" class="calendar" maxlength="10" style="width:70px;"/> ~ 
												<input type="text" id="eJoinDate" name="eJoinDate" class="calendar" maxlength="10" style="width:70px;"/>												
											</td>
											<td width="200px;">
												<input type="text" id="sOutDate" name="sOutDate" class="calendar" maxlength="10" style="width:70px;"/> ~ 
												<input type="text" id="eOutDate" name="eOutDate" class="calendar" maxlength="10" style="width:70px;"/>
											</td>
											<td width="180px;">
												<input type="text" id="searchStr" name="searchStr" onkeydown="javascript:enterKey();" style="width:170px;">
											</td>											
											<td>
												<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick="javascript:fnSearch();">검 색</a>
												<a href="#noloc" class="btn-vacation-aprv" style="background:#F3E2A9;" id="btn-search" onclick="javascript:fnClear();" title="목록의 정렬을 초기화합니다.">초기화</a>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
								<!-- 검색 테이블 끝-->
							</div><!-- //tableStyle2 -->
							<!-- 목록 시작 -->
							<div id="divInfoTable" class="tableStyle2" style="padding-top: 10px;border-top:0px;">
								<table>
									<tr>
										<td>검색버튼을 눌러주세요.</td>
									</tr>
								</table>
							</div>
							<div id="divMemberList"></div>															
							<!-- 목록 끝 -->
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
<!-- //wrapper -->

</body>
</html>
