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
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script>
		$(document).ready(function(){
			$.ajaxSetup({cache:false});
			$("#tid").select2();
			$("#ustat").select2();
			
		});//ready
		
	</script>
	
	<script>
	function dayoff_btn(user_no,user_name,team_id,toServerYear,work_level){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이

		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('myDayoffPop?user_no='+user_no+'&user_name='+user_name+'&team_id='+team_id+'&toServerYear='+toServerYear+'&work_level='+work_level,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	function dayoffReturn(serial_no){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이

		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('DayoffReturnPop?serial_no='+serial_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	function dayoffUserList(user_no){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이

		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('DayoffUserListPop?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	function dayoffSignBtn(){
		var r = confirm("선택한 휴가내역을 승인하시겠습니까?");
		if (!r){
			return;
		}
		
		dayoffSignFrom.action = "./topDayoffSign";
		dayoffSignFrom.submit();
	}
	/* function dayoffReturnBtn(){
		dayoffSignFrom.action = "./topDayoffReturn";
		dayoffSignFrom.submit();
	} */
	function fnGoPage(n) {
		var frm = document.dayoffSignFrom;
		frm.reqPgNo.value = n;
		frm.submit();
	}
	
	function fnGoSearch(){
		var frm = document.dayoffSignFrom;
		frm.reqPgNo.value = "";
		frm.submit();
	}
	
	function fnAllChk(that){
		if ( $(that).is(":checked") ){
			 $('input:checkbox[name="chkdayoff"]').each(function() {
				this.checked = true; //checked 처리
			 });
		}else{
			 $('input:checkbox[name="chkdayoff"]').each(function() {
				this.checked = false; //checked 처리
			});
		}
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

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2" style="height: 720px !important;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">휴가내역</a></li>
							</ul>
						</div>
						<div style="text-align: right;">
							<input type="image" src="./resources/ls_img/ls_report/btn_rch_2.gif" onclick="javascript:dayoffSignBtn();" style="margin-top: 8px; cursor: pointer;"/>
							<!-- <input type="image" src="./resources/ls_img/ls_report/btn_rch_return.gif" onclick="javascript:dayoffReturnBtn();"/> -->
						</div>
						<div class="guestcnt4" style="display:block; height: 635px !important;">
							<form name="dayoffSignFrom" id="dayoffSignFrom" method="GET" action="./topDayoffList">
								<input type="hidden" id="reqPgNo" name="reqPgNo" value="${reqPgNo}">
								<div class= "tableStyle2">
									<table>
										<colgroup>
											<col width="7%">
											<col width="10%">
											<col width="7%">
											<col width="15%">
											<col width="7%">
											<col width="15%">
											<col width="10%">
										</colgroup>
										<tr>
											<th>상태</th>
											<td>
												<span style="text-align: left !important;">
													<select id="ustat" name="ustat">
														<option value="0" <c:if test="${ustat eq '0' || ustat eq 'null'}"> selected</c:if>>전체</option>
														<option value="1" <c:if test="${ustat eq '1'}"> selected</c:if>>신청</option>
														<option value="5" <c:if test="${ustat eq '5'}"> selected</c:if>>팀장승인</option>
														<option value="10" <c:if test="${ustat eq '10'}"> selected</c:if>>인사총무팀승인</option>
														<option value="2" <c:if test="${ustat eq '2'}"> selected</c:if>>반려</option>
													</select>
												</span>
											</td>
											<th>팀</th>
											<td>
												<span style="text-align: left !important;">
													<select id="tid" name="tid" >
														<option value="0" <c:if test="${tid eq '0' || tid eq 'null'}"> selected</c:if>>전체</option>
														<c:forEach items="${teamList}" var = "teamVo">
															<option value="${teamVo.team_id}" <c:if test="${tid eq teamVo.team_id}"> selected</c:if>>
																<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
																<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																${teamVo.team_name}
															
														</c:forEach>
													</select>
												</span>
											</td>
											<th>이름</th>
											<td><input type="text" id="searchStr" name="searchStr" size="25" value="${searchStr}" /></td>
											<td>
												<img src="./resources/ls_img/btn_src.gif" style="cursor:pointer;" onclick="fnGoSearch();">
											</td>
										</tr>
									</table>
								</div>
<!-- 							<form name="dayoffSignFrom" id="dayoffSignFrom" method="GET" action="./topDayoffList"> -->
							<div class= "tableStyle2">
								<table>
									<colgroup>
									<col width="3%">
										<col width="3%">
										<col width="6%">
										<col width="8%">
										<col width="3%">
										<col width="6%">
										<col width="6%">
										<col width="13%">
										<col width="3%">
										<col width="25%">
										<col width="8%">
										<col width="3%">
									</colgroup>
									<tr>
										<th><input type="checkbox" id="allChk" name="allChk" onclick="fnAllChk(this);"/></th>
										<th>No.</th>
										<th>이름</th>
										<th>팀명</th>
										<th>직급</th>
										<th>입사일</th>
										<th>신청일</th>
										<th>사용기간</th>
										<th>일수</th>
										<th>사유 간략히 기재<br/>(단 "월차","정기휴가" 라고 입력하지 말 것)</th>
										<th>상태</th>
										<th>비고</th>
									</tr>
									<c:forEach items="${getTopDayoff}" var="getTopDayoff" varStatus="status" >
										<tr>
										<c:choose>
											<c:when test="${getTopDayoff.getState() eq '5'}">
												<td><input type="checkbox" id="chkdayoff" name="chkdayoff" value="${getTopDayoff.getSerial_no()}"/></td>
											</c:when>
											<c:when test="${getTopDayoff.sub_user == mbrVo_Session.user_no and getTopDayoff.getState() == '1'}">
												<td><input type="checkbox" id="chkdayoff" name="chkdayoff" value="${getTopDayoff.getSerial_no()}"/></td>
											</c:when>
											<c:otherwise>
												<td></td>
											</c:otherwise>
										</c:choose>
											<td>${totCntIntForListNo1 - (18 * (reqPgNoInt1 - 1)) - status.index}</td>
											<td><a href="#noloc" onclick="dayoffUserList('<c:out value='${getTopDayoff.getUser_no()}'/>');">${getTopDayoff.getUser_name()}</a></td>
											<td>${getTopDayoff.getTeam_name()}</td>
											<td>${getTopDayoff.getWork_level_Nm()}</td>
											<td>${getTopDayoff.getJoin_date()}</td>
											<td>${getTopDayoff.getReg_date()}</td>
											<td>${getTopDayoff.getDayoff_start_date()} ~ ${getTopDayoff.getDayoff_end_date()}</td>
											<td>${getTopDayoff.getDayoff_count()}</td>
											<td>${getTopDayoff.getTitle()}</td>
											<td>
												<c:if test="${getTopDayoff.getState() eq '1'}">신청</c:if>
												<c:if test="${getTopDayoff.getState() eq '5'}">팀장승인</c:if>
												<c:if test="${getTopDayoff.getState() eq '10'}">인사총무팀승인</c:if>
												<c:if test="${getTopDayoff.getState() eq '2'}">반려</c:if>
											</td>
											<td>
											    <a href="#noloc" onclick="dayoffReturn('<c:out value='${getTopDayoff.getSerial_no()}'/>');">
											    	<img src="./resources/ls_img/btn_edit_s.gif">
											    </a>
<%-- 												<input type="image" src="./resources/ls_img/btn_edit_s.gif" value="${status.index}"  alt="비고" style ="cursor:pointer" /> --%>
											</td>
										</tr>
									</c:forEach>
								</table>
									
								</div>
								</form>
						
							
							<div class= "tableStyle2">
							<c:import url="../util_page/page_bsc_3.jsp" charEncoding="UTF-8"></c:import>
							</div>
							<br>
						</div><!-- //tableStyle2 -->
					</div>
				</div>	
			</div>		
				<!-- //centercnt_bot -->

				<!-- banner -->
<%-- 				<c:import url="../top_main/top_main_banner.jsp"></c:import> --%>
				<!-- //banner -->

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
