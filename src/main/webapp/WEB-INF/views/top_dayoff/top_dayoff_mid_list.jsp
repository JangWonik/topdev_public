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
		$(document).ready(function(){
	
			$.ajaxSetup({cache:false});
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
		
		function dayoffMidSignBtn(){
			var r = confirm("선택한 휴가내역을 승인하시겠습니까?");
			if (!r){
				return;
			}
			dayoffMidSignFrom.action = "./topDayoffMidSign";
			dayoffMidSignFrom.submit();
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
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">${team_name} 휴가내역</a></li>
							</ul>
						</div>
						<div style="text-align: right;">
							<input type="image" src="./resources/ls_img/ls_report/btn_rch_2.gif" onclick="dayoffMidSignBtn();" style="margin-top: 8px;"/>
						</div>
							<form name="dayoffMidSignFrom" id="dayoffMidSignFrom" method="GET" action="./topDayoffMidSign">
							<div class= "tableStyle2">
								<table>
									<colgroup>
										<col width="3%">
										<col width="3%">
										<col width="6%">
										<col width="10%">
										<col width="5%">
										<col width="6%">
										<col width="13%">
										<col width="3%">
										<col width="25%">
										<col width="6%">
										<col width="3%">
									</colgroup>
									<tr>
										<th><input type="checkbox" id="allChk" name="allChk" onclick="fnAllChk(this);"/></th>
										<th>No.</th>
										<th>이름</th>
										<th>팀명</th>
										<th>직급</th>
										<th>신청일</th>
										<th>사용기간</th>
										<th>일수</th>
										<th>사유 간략히 기재<br/>(단 "월차","정기휴가" 라고 입력하지 말 것)</th>
										<th>상태</th>
										<th>비고</th>
									</tr>
									<c:forEach items="${getTopDayoff}" var="TopDayoffmid" varStatus="status" >
										<tr>
										<c:choose>
											<c:when test="${TopDayoffmid.getState() eq '1'}">
												<td><input type="checkbox" id="chkdayoff" name="chkdayoff" value="${TopDayoffmid.getSerial_no()}"/></td>
											</c:when>
											<c:otherwise>
												<td></td>
											</c:otherwise>
										</c:choose>
											<td>${totCntIntForListNo1 - (18 * (reqPgNoInt1 - 1)) - status.index}</td>
											<td>${TopDayoffmid.getUser_name()}</td>
											<td>${TopDayoffmid.getTeam_name()}</td>
											<td>${TopDayoffmid.getWork_level_Nm()}</td>
											<td>${TopDayoffmid.getReg_date()}</td>
											<td>${TopDayoffmid.getDayoff_start_date()} ~ ${TopDayoffmid.getDayoff_end_date()}</td>
											<td>${TopDayoffmid.getDayoff_count()}</td>
											<td>${TopDayoffmid.getTitle()}</td>
											<td>
												<c:if test="${TopDayoffmid.getState() eq '1'}">신청</c:if>
												<c:if test="${TopDayoffmid.getState() eq '5'}">팀장승인</c:if>
												<c:if test="${TopDayoffmid.getState() eq '10'}">인사총무팀승인</c:if>
												<c:if test="${TopDayoffmid.getState() eq '2'}">반려</c:if>
											</td>
											<td>
												-
<%-- 												<input type="button" src="./resources/ls_img/btn_edit_s.gif" value="${status.index}" class="udtMyCost" alt="수정" style ="cursor:pointer" /> --%>
											</td>
										</tr>
									</c:forEach>
								</table>
									
								</div>
								</form>
								
							
							<div class= "tableStyle2">
							<!-- page start -->
							<c:if test="${pgNm2 != null}">
								<p style="text-align:center;">
									<c:if test="${startPgNoInt2 > 10}">
										<a href="javascript:reqPgNoClickSuit10(${startPgNoInt2 - 1});">&lt;</a>
									</c:if>
									<c:forEach var="pageNo" begin="${startPgNoInt2}" end="${endPgNoInt2}" step="1">
										<c:choose>
											<c:when test="${reqPgNoInt2 != pageNo}">
												<a href="javascript:reqPgNoClickSuit10(${pageNo});"><c:out value="${pageNo}" /></a>
												&nbsp;&nbsp;
											</c:when>
											<c:otherwise>
												<font color="red"><c:out value="${pageNo}" /></font>
												&nbsp;&nbsp;
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${totPgCntInt2 >= endPgNoInt2 + 1}">
										<a href="javascript:reqPgNoClickSuit10(${endPgNoInt2 + 1});">&gt;</a>
									</c:if>
								</p>
							</c:if>
						<!-- //page end -->
						<!-- 현재 진행 상황 입력 --> 
						<br>
						
						</div><!-- //guestcnt4 -->
						<div class="guestcnt4" style="display:none;">
						</div>
						<div class="guestcnt4" style="display:none;">
						</div>
						<div class="guestcnt4" style="display:none;">
						</div>
					</div>
					
					
					
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
<%-- 				<c:import url="../top_main/top_main_banner.jsp"></c:import> --%>
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
