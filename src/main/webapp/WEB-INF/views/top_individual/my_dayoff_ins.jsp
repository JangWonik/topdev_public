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
	function dayoff_btn(user_no,user_name,team_id,toServerYear,work_level){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이

		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('myDayoffPop?user_no='+user_no+'&user_name='+user_name+'&team_id='+team_id+'&toServerYear='+toServerYear+'&work_level='+work_level,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	function myDayoffUdt_btn(user_no,user_name,team_id,toServerYear,work_level,serial_no){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이

		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('myDayoffUdtPop?toServerYear='+toServerYear+'&serial_no='+serial_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		if('${mbrVo_Session.user_no}' == null){
			window.location.assign("./logout");
		}
		
		
		$(".delMyDayoff_btn").click(function(){
			$.post("./myDayoffDelOK",
					{
						serial_no					:$("#serial_no").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("나의 월차내역 삭제가 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("삭제되었습니다.");
								//window.opener.location.assign("./primBizInvDtl?rpt_invoice_no=${rpt_invoice_no}");
								//window.opener.location.reload();
								window.location.reload();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
					
			);//post

		});/* $("#popptnrsave").click */
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
								<li class="on"><a href="#">나의 휴가내역</a></li>
							</ul>
							
						</div>
						<%-- <c:set value="cost_class_no" var="cost_class_no"/> --%>
						<div style ="text-align:left; margin-top:5px;">
							<input type="hidden" id="viewFromDate" name="fromdate" value="${fromdate}"/>
							<input type="hidden" id="viewToDate" name="todate" value="${todate}"/>
							<%@include file="../top_individual/my_dayoff_top.jsp"%>
						</div>
						<div class="guestcnt4" style="display:block;">
						 <b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 나의 휴가 내역</b>
						 <%--  
						 <img src="./resources/ls_img/btn_request.gif" onclick="dayoff_btn('<c:out value='${mbrVo_Session.user_no}'/>','<c:out value='${mbrVo_Session.user_name}'/>','<c:out value='${team_id}'/>','<c:out value='${toServerYear}'/>','<c:out value='${work_level}'/>');" style="cursor:pointer; margin-left:5px;"/>
						 --%>	
							<%-- <div class= "tableStyle2">
								<table>
									<colgroup>
										<col width="10%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="9%">
										<col width="9%">
									</colgroup>
									<tr>
										<th>${toServerYear}년</th>
										<th>1월</th>
										<th>2월</th>
										<th>3월</th>
										<th>4월</th>
										<th>5월</th>
										<th>6월</th>
										<th>7월</th>
										<th>8월</th>
										<th>9월</th>
										<th>10월</th>
										<th>11월</th>
										<th>12월</th>
										<th>사용</th>
										<th>미사용</th>
									</tr>
									<tr>
										<td>사용개수</td>
										<c:forEach items="${getMyDayoffCount}" var="getMyDayoffVO" begin="0" end="12" step="1" varStatus="status">
											<td>
												<c:out value="${getMyDayoffVO.getDayoffMonthCnt()}"/>
											</td>
										</c:forEach>
										<td><c:out value="${myDayoffsel.used}"/></td>
										<td><c:out value="${myDayoffsel.notUsed}"/></td>
									</tr>
									
								</table>
									
								</div> --%>
								<br>
								<div class= "tableStyle2">
									<table>
										<thead>
											<colgroup>
												<col width="5%">
												<col width="18%">
												<col width="35%">
												<col width="20%">
												<col width="7%">
<%-- 												<col width="10%"> --%>
												<col width="5%">
											</colgroup>
											<tr>
												<th>no</th>
												<th>신청일시</th>
												<th>사유</th>
												<th>기간</th>
												<!-- <th>사용개수</th> -->
												<th>상태</th>
												<th>비고</th>
											</tr>
											<%-- <c:set value="${getMyCostInsList}" var="getMyCostInsList"/> --%>
											<c:forEach items="${getMyDayoff}" var="getMyDayoff" varStatus="status" >
											<tr>
											<td>${status.index +1}</td>
											<td>${getMyDayoff.getReg_date()}</td>
											<td>${getMyDayoff.getTitle()}</td>
											<td>${getMyDayoff.getDayoff_start_date()} ~ ${getMyDayoff.getDayoff_end_date()}</td>
											<%-- <td>${getMyDayoff.getDayoff_count()}</td> --%>
											<td>
												<c:if test="${getMyDayoff.getState() eq '1'}">신청</c:if>
												<c:if test="${getMyDayoff.getState() eq '5'}">팀장승인</c:if>
												<c:if test="${getMyDayoff.getState() eq '10'}">승인</c:if>
												<c:if test="${getMyDayoff.getState() eq '2'}">반려</c:if>
												<c:if test="${getMyDayoff.getState() eq '0'}">취소</c:if>
											</td>
											<c:choose>
											<c:when test="${getMyDayoff.getState() eq '1'}">
												<td>
													<input type="image" src="./resources/ls_img/btn_edit_s.gif" value="${status.index}" onclick="myDayoffUdt_btn('<c:out value='${mbrVo_Session.user_no}'/>','<c:out value='${mbrVo_Session.user_name}'/>','<c:out value='${team_id}'/>','<c:out value='${toServerYear}'/>','<c:out value='${work_level}'/>','<c:out value='${getMyDayoff.getSerial_no()}'/>')" alt="수정" style ="cursor:pointer" />
													<input type="image" src="./resources/ls_img/btn_del_s.gif" class="delMyDayoff_btn" alt="삭제" style ="cursor:pointer" />
													<input type="hidden" id="serial_no" name="serial_no" value="${getMyDayoff.getSerial_no()}"/>
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
							</div><!-- //tableStyle2 -->
						</div>
					</div>
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
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
