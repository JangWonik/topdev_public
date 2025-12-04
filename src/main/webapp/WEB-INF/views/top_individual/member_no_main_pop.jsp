<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar-rptinv.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
			
			//탭메뉴 지정
			if( '${menuType}' == 'sub3In' ){				
				$("#suimTab").attr('class','');
				$("#sub3In").attr('class','on');
				$("#sub3Over").attr('class','');
				$("#not3In").attr('class','');				
				$("#not3Over").attr('class','');
				$("#not30Over").attr('class','');
				$("#endAverage").attr('class','');				
				
				$("#suimTabList").hide();
				$("#sub3InList").show();
				$("#sub3OverList").hide();
				$("#not3InList").hide();
				$("#not3OverList").hide();
				$("#not30OverList").hide();
				$("#endAverageList").hide();
			}else if( '${menuType}' == 'sub3Over' ){
				$("#suimTab").attr('class','');
				$("#sub3In").attr('class','');
				$("#sub3Over").attr('class','on');
				$("#not3In").attr('class','');
				$("#not3Over").attr('class','');
				$("#not30Over").attr('class','');
				$("#endAverage").attr('class','');
				
				$("#suimTabList").hide();
				$("#sub3InList").hide();
				$("#sub3OverList").show();
				$("#not3InList").hide();
				$("#not3OverList").hide();
				$("#not30OverList").hide();
				$("#endAverageList").hide();
			}else if( '${menuType}' == 'not3In' ){
				$("#suimTab").attr('class','');
				$("#sub3In").attr('class','');
				$("#sub3Over").attr('class','');
				$("#not3In").attr('class','on');
				$("#not3Over").attr('class','');
				$("#not30Over").attr('class','');
				$("#endAverage").attr('class','');
				
				$("#suimTabList").hide();
				$("#sub3InList").hide();
				$("#sub3OverList").hide();
				$("#not3InList").show();
				$("#not3OverList").hide();
				$("#not30OverList").hide();
				$("#endAverageList").hide();
			}else if( '${menuType}' == 'not3Over' ){
				$("#suimTab").attr('class','');
				$("#sub3In").attr('class','');
				$("#sub3Over").attr('class','');
				$("#not3In").attr('class','');
				$("#not3Over").attr('class','on');
				$("#not30Over").attr('class','');
				$("#endAverage").attr('class','');
				
				$("#suimTabList").hide();
				$("#sub3InList").hide();
				$("#sub3OverList").hide();
				$("#not3InList").hide();
				$("#not3OverList").show();
				$("#not30OverList").hide();
				$("#endAverageList").hide();
			}else if( '${menuType}' == 'not30Over' ){
				$("#suimTab").attr("class","");
				$("#sub3In").attr('class','');
				$("#sub3Over").attr('class','');
				$("#not3In").attr('class','');
				$("#not3Over").attr('class','');
				$("#not30Over").attr('class','on');
				$("#endAverage").attr('class','');
				
				$("#suimTabList").hide();
				$("#sub3InList").hide();
				$("#sub3OverList").hide();
				$("#not3InList").hide();
				$("#not3OverList").hide();
				$("#not30OverList").show();
				$("#endAverageList").hide();
			}else if( '${menuType}' == 'endAverage' ){
				$("#suimTab").attr("class","");
				$("#sub3In").attr('class','');
				$("#sub3Over").attr('class','');
				$("#not3In").attr('class','');
				$("#not3Over").attr('class','');
				$("#not30Over").attr('class','');
				$("#endAverage").attr('class','on');
				
				$("#suimTabList").hide();
				$("#sub3InList").hide();
				$("#sub3OverList").hide();
				$("#not3InList").hide();
				$("#not3OverList").hide();
				$("#not30OverList").hide();
				$("#endAverageList").show();
			}else{
				$("#suimTab").attr("class","on");
				$("#sub3In").attr('class','');
				$("#sub3Over").attr('class','');
				$("#not3In").attr('class','');
				$("#not3Over").attr('class','');
				$("#not30Over").attr('class','');
				$("#endAverage").attr('class','');
				
				$("#suimTabList").show();
				$("#sub3InList").hide();
				$("#sub3OverList").hide();
				$("#not3InList").hide();
				$("#not3OverList").hide();
				$("#not30OverList").hide();
				$("#endAverageList").hide();
			}			
		});//ready
		
		function popSuimDtl(suim_rpt_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			//var sh=screen.availHeight;  //띄울 창의 높이
			var sh=780;  //띄울 창의 높이(고정값으로 변경)
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>
</head>

<body>
<!-- wrapper -->
<div id="wrapper">

	<!-- contents -->
	<div id="container">
		<div class="contetnsMiPop">

			<!-- center_cnt -->
			<div class="center_cnt_1500">

				<!-- centercnt_bot -->
				<div class="center_cnt_1500_bot">
					<div class="guest">
							<div style="height: 25px; float: left;">
					       		<img width="12" height="12" src="./resources/ls_img/dotte.gif" border="0">&nbsp;
					       		<b>${title_teamname} ${title_username}</b>
							</div>
							<div class="guestPopTap">
							<ul>
								<li class="on" id="suimTab"><a href="#">수임건 (${suim30List.size()})</a></li>
								<li id="sub3In"><a href="#">3영업일내 제출건 (${sub3InList.size()})</a></li>
								<li id="sub3Over"><a href="#">3영업일초과 제출건 (${sub3OverList.size()})</a></li>
								<li id="not3In"><a href="#">3영업일내 미제출건 (${not3InList.size()})</a></li>
								<li id="not3Over"><a href="#">3영업일초과 미제출건 (${not3OverList.size()})</a></li>
								<li id="not30Over"><a href="#">30일초과 미제출건 (${not30OverList.size()})</a></li>
								<li id="endAverage"><a href="#">평균처리일 (${end_average_cnt}<%-- ${endAverageList.size()} --%>)</a></li>
							</ul>							
						</div>
						<div class="guestcnt4" id="suimTabList" style="display:block;">
							<c:import url="../top_individual/member_suim_site_list.jsp"></c:import>
						</div>
						<div class="guestcnt4" id="sub3InList" style="display:none;">
							<c:import url="../top_individual/member_sub_3_in_list.jsp"></c:import>
						</div>
						<div class="guestcnt4" id="sub3OverList" style="display:none;">
							<c:import url="../top_individual/member_sub_3_over_list.jsp"></c:import>
						</div>
						<div class="guestcnt4" id="not3InList" style="display:none;">
							<c:import url="../top_individual/member_not_3_in_list.jsp"></c:import>
						</div>
						<div class="guestcnt4" id="not3OverList" style="display:none;">
							<c:import url="../top_individual/member_not_3_over_list.jsp"></c:import>
						</div>
						<div class="guestcnt4" id="not30OverList" style="display:none;">
							<c:import url="../top_individual/member_not_30_over_list.jsp"></c:import>
						</div>
						<div class="guestcnt4" id="endAverageList" style="display:none;">
							<c:import url="../top_individual/member_end_average_list.jsp"></c:import>
						</div>						
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- //contents -->
</div>
<!-- //wrapper -->

</body>
</html>
