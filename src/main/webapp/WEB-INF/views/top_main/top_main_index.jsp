<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js?v=4"></script>
    <script src="./resources/cmm/js/common.js"></script>
    
    <script src="./resources/jquery/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<style>
		button{
		  background:#0033FF;
		  color:#fff;
		  border:none;
		  position:relative;
		  height:25px;
		  font-size:0.8em;
		  padding:0 2em;
		  cursor:pointer;
		  transition:800ms ease all;
		  outline:none;
		}
		button:hover{
		  background:#fff;
		  color:#0033FF;
		}
		button:before,button:after{
		  content:'';
		  position:absolute;
		  top:0;
		  right:0;
		  height:2px;
		  width:0;
		  background: #0033FF;
		  transition:400ms ease all;
		}
		button:after{
		  right:inherit;
		  top:inherit;
		  left:0;
		  bottom:0;
		}
		button:hover:before,button:hover:after{
		  width:100%;
		  transition:800ms ease all;
		}
		.ui-widget-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: #AAA; opacity: .90; filter:Alpha(Opacity=30); }
	</style>	
	<script>
		$(document).ready(function(){
			
			if("${firstLogin}" == "1"){
				if( ("${timeDifferForPwAlert}" >= 90) && ("${fromLogInPage}" == 1) ){  // if("${timeDifferForPwAlert}" > 90 ){
					//alertPwChange();
				}
			}
				
			//팝업 차단 disable
			$('div').removeClass('ui-widget-overlay ui-front');
				
			if("${mbrVo_Session.work_type_cd}" == "1"
				|| "${mbrVo_Session.work_type_cd}" == "2" || "${mbrVo_Session.work_type_cd}" == "3"
				|| "${mbrVo_Session.work_type_cd}" == "6" || "${mbrVo_Session.work_type_cd}" == "7" || "${mbrVo_Session.work_type_cd}" == "14"
				|| "${mbrVo_Session.user_no}" == "966" || "${mbrVo_Session.user_no}" == "215"
				|| "${mbrVo_Session.user_no}" == "1117" || "${mbrVo_Session.user_no}" == "882"
				|| "${mbrVo_Session.user_no}" == "670" || "${mbrVo_Session.user_no}" == "975" || "${mbrVo_Session.user_no}" == "1786"){//백다혜사원 추가 17.04.18

				if("${mbrVo_Session.team_type}" == "1" || "${mbrVo_Session.team_type}" == "0" || "${mbrVo_Session.user_state}" == "9"){
					$("#rptMiPop").show();
				}
			}

			if("${fromLogInPage}" == "1") {
				if("${mainLeftMySuimVO.suimState0Cnt - mainLeftMySuimVO.siteCnt}" != "0"
						|| "${mainLeftMySuimVO.interimCnt}" != "0"
						|| "${mainLeftMySuimVO.interimCnt2}" != "0"
						|| "${mbrVo_Session.team_type}" == "4"){
					alertMyNoSiteList();
				}
				if("${mbrVo_Session.work_type_cd}" == "1"
						|| "${mbrVo_Session.work_type_cd}" == "2" || "${mbrVo_Session.work_type_cd}" == "3"
						|| "${mbrVo_Session.work_type_cd}" == "6" || "${mbrVo_Session.work_type_cd}" == "7" || "${mbrVo_Session.work_type_cd}" == "14" 
						|| "${mbrVo_Session.user_no}" == "966" || "${mbrVo_Session.user_no}" == "215"
						|| "${mbrVo_Session.user_no}" == "1117" || "${mbrVo_Session.user_no}" == "882"
						|| "${mbrVo_Session.user_no}" == "670" || "${mbrVo_Session.user_no}" == "975" || "${mbrVo_Session.user_no}" == "1786"){//백다혜사원 추가 17.04.18

					if("${mbrVo_Session.team_type}" == "1" || "${mbrVo_Session.team_type}" == "0" || "${mbrVo_Session.user_state}" == "9"){
						alertNoSiteMngList();
						$("#rptMiPop").show();
					}
						
					if("${mbrVo_Session.team_type}" == "4"){
						alertKind4MiMngList();						
					}
				}
				
				//현장보고서 팝업체크시작
				if( "${sitePopAuth}" == "1" ){
					//alert("전체 현장보고서 팝업");
					openSiteReportCenter( 0 );
				}else if( "${sitePopAuth}" == "2" ){
					//alert("센터장 현장보고서 팝업");
					openSiteReportCenter( 0 );
				}else if( "${sitePopAuth}" == "3" ){
					//alert("팀장 현장보고서 팝업");
					//openSiteReportTeam( 0 );
					openSiteReportCenter( ${mbrVo_Session.team_center} );
				}else if( "${sitePopAuth}" == "4" ){
					//alert("개인 현장보고서 팝업");
					openSiteReportUser( ${mbrVo_Session.user_no} );
				}
			}

			/* 공지사항 팝업창
            if (!Boolean(fnGetCookie('evapop'))) {
                var cw=screen.availWidth;
                var ch=screen.availHeight;
                var sw=700; //띄울 창의 넓이
                var sh=450;  //띄울 창의 높이
                var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
                var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
                if ("${mbrVo_Session.team_type}" != 4){
                    window.open('./mainNoticePop','mainNoticePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
                }
			}
			 */			 
			 
			 //휴가 공지 체크시작 by top3009
			 if("${mbrVo_Session.team_type}" == "4"){		//4종 체크
				 getCookieToday4();	 
			 }else{															//1종 체크
				 getCookieToday();	 
			 }			 
			 //휴가 공지 체크 끝
			 
			 //손해사정서 미교부현황 목록 가져오기	by top3009 오픈전까지 주석처리			 
			 //getCookieTeamList();			
			 
			 //금일 휴가자 공지 체크	by top3009
			 getCookieTodayMember();
			 
			//회사만족도 및 상향평가 실시 시작 by top3009			
			var surveyFlagVal = $("#survey_flag").val();			
			if( 'enable' == surveyFlagVal ){
				getCookieRatingToday();
			}			
			//회사만족도 및 상향평가 실시 끝 by top3009
		});
		
		function alertPwChange(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=540; //띄울 창의 넓이
			var sh=200;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('pwdEditeRec','pwChange','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

 		// 나의 보고서 제출 현황 팝업
		function alertMyNoSiteList(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1520; //띄울 창의 넓이
			var sh=742;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('myNoSiteListPop','myNoSiteListPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		// 제출현황 관리 팝업
		function alertNoSiteMngList(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1120; //띄울 창의 넓이
			var sh=ch;  //띄울 창의 높이
// 			var sh=735;  //띄울 창의 높이
			
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('noSiteMngListPop','noSiteMngListPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		// 제출현황 관리 팝업
		function alertWorkloadPop(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1350; //띄울 창의 넓이
			var sh=ch;  //띄울 창의 높이
// 			var sh=735;  //띄울 창의 높이
			
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('workloadMemberPop','workloadPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		

		function alertKind4MiMngList(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=295; //띄울 창의 넓이
			var sh=735;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('kind4MiMngListPop','kind4MiMngListPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=no');
		}
		
		function setCookieTodayMember(){
			var name = "vacatonInfoMember";
			var value = "done";
			var expiredays = 1;
			var todayDate = new Date();
		    todayDate.setDate( todayDate.getDate() + expiredays );
		    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
		    $("#popup-vacation-member").dialog('close');
		}

		function getCookieTodayMember() {
		    var cookiedata = document.cookie;	    
		    if ( cookiedata.indexOf("vacatonInfoMember=done") < 0 ){	    	
		    	$("#popup-vacation-member").dialog('open'); 
		    }else {	    	
		    	$("#popup-vacation-member").dialog('close');	        
		    }
		}
		
		//손해사정서 팝업 하룻동안 열지않기
		function setCookieTeamList(){
			var name = "sendTeamList";
			var value = "done";
			var expiredays = 1;
			var todayDate = new Date();
		    todayDate.setDate( todayDate.getDate() + expiredays );
		    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
		    $("#popup-send-teamlist").dialog('close');
		}
		
		//손해사정서 팝업 쿠키가져오기
		function getCookieTeamList() {
		    var cookiedata = document.cookie;	    
		    if ( cookiedata.indexOf("sendTeamList=done") < 0 ){	    	
		    	$("#popup-send-teamlist").dialog('open'); 
		    }else {	    	
		    	$("#popup-send-teamlist").dialog('close');	        
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
				<!-- centercnt_top -->
				<c:import url="../top_main/top_main_board.jsp"></c:import>
				<!-- //centercnt_top -->
				<!-- centercnt_bot -->
				<div class="centercnt_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">일반수임(${mainIndexSuimList.size()})</a></li>
								<li><a href="#">농작물(${mainIndexPrimbizList.size()})</a></li>
								<li><a href="#">삼성계약적부(${mainIndexSuit18List.size()})</a></li>
								<li><a href="#">KB계약적부(${mainIndexSuit10List.size()})</a></li>
								<li><a href="#">한화 계약적부(${mainIndexSuit12List.size()})</a></li>
								<li><a href="#">흥국 계약적부(${mainIndexSuit17List.size()})</a></li>
							</ul>
						</div>
						<div class="guestcnt" style="display:block;">
							<c:import url="../top_main/top_main_index101.jsp"></c:import>
						</div>
						<div class="guestcnt" style="display:none;">
							<c:import url="../top_main/top_main_index201.jsp"></c:import>
						</div>
						<div class="guestcnt" style="display:none;">
							<c:import url="../top_main/top_main_index318.jsp"></c:import>
						</div>
						<div class="guestcnt" style="display:none;">
							<c:import url="../top_main/top_main_index310.jsp"></c:import>
						</div>
						<div class="guestcnt" style="display:none;">
							<c:import url="../top_main/top_main_index312.jsp"></c:import>
						</div>
						<div class="guestcnt" style="display:none;">
							<c:import url="../top_main/top_main_index317.jsp"></c:import>
						</div>
					</div><!-- //guest -->					
 					<c:if test="${param.fromLogInPage == 1 && (salFlag == 1 || internSalFlag == 1)}">
						<c:import url="../top_individual/member_sal_index.jsp"></c:import>
					</c:if>					
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
	<input type="hidden" id="survey_flag" name="survey_flag" value="disable"/>

</div>
<!-- //wrapper -->
<!-- 로그인 후 팝업 시작 -->
<c:forEach items="${divPopupList}" var="popup" varStatus="status">

	<div id="popup-${popup.popup_no}" title="미리보기" style="font-size: 12px;">
		<span id="previewContent">${popup.contents}</span>								 
	</div>	
	
	<script>
		var p_height = '${popup.popup_width}';
		var p_width = '${popup.popup_height}';
		var preSubject = '${popup.subject}';			
		
		$("#popup-${popup.popup_no}").dialog({
			height: p_height,
			width: p_width,
			closeOnEscape : true,
			draggable : true,					
			title: preSubject,				
			modal: true,
			buttons:{				
				"닫기" : function(){
					$(this).dialog("close");
				}
			},
			position: { 'at' : 'right top' }		
		});
	</script>		
	
</c:forEach>	
<!-- 로그인 후 팝업 끝 -->

<!-- 회사만족도 및 상향평가 실시 시작 by top3009-->
<jsp:useBean id="now" class="java.util.Date" />
<fmt:parseDate value="202510270000" pattern="yyyyMMddHHmm" var="startUpperSurveyDate" />
<fmt:parseDate value="202511010000" pattern="yyyyMMddHHmm" var="endUpperSurveyDate" />

<fmt:formatDate value="${now}" pattern="yyyyMMddHHmm" var="nowDate" />             <!-- 오늘날짜 -->
<fmt:formatDate value="${startUpperSurveyDate}" pattern="yyyyMMddHHmm" var="openUpperSurveyDate"/>       <!-- 시작날짜 -->
<fmt:formatDate value="${endUpperSurveyDate}" pattern="yyyyMMddHHmm" var="closeUpperSurveyDate"/>        <!-- 마감날짜 -->

<c:if test="${openUpperSurveyDate < nowDate && closeUpperSurveyDate > nowDate}">

<div id="popup-rating" title="회사만족도 평가" style="font-size: 12px;" >
	<br/>
	<div style="text-align:center;">
		<b><font size="5">회사만족도 및 상향평가 실시</font></b>
	</div>	
	<br/>
	<br/>
	<div class="tableStyle2" style="width: 680px;">	
		<table class="vacation-ins-table">
			<tr>			
				<td style="font-size:14px;text-align:left;padding-left:10px;">
				<b><br/>본 설문 및 상향평가는 임직원의 회사만족도 및 고충사항에 대한 직원들의 소중한 의견을 반영하여 보다
					활기찬 일터조성과 바람직한 인사관리 발전 방향을 수립하기 위한 자료로 활용될 예정입니다.<br/>					
				</b>
				<br/>
				<i><u><b>응답내용에 대한 응답자의 비밀은 철저히 지켜질 것이며, 피평가자에게 누가 어떠한 내용을 응답했는지
					구체적인 피드백 또한 없을 것을 절대 보장합니다.
				</b></u></i><br/>
				<span style="font-size:12px;font-weight:bold;">
				<br/>
					본 설문 및 평가에 끝까지 관심을 가지고 한 문항도 빠짐없이 평소 본인이 가지고 있는 생각을 솔직하게 응답해
					주시기 바랍니다.<br/><br/>				
					◆ 설문 및 평가기간 : 2025.10.27.(월) ~ 10.31.(금)(5일간) <br/>
					◆ 설문 및 평가 바로가기 : <span id="survey_url">${upperSurvey}</span>
				</span>							
				</td>
			</tr>
		</table>
	</div>	
	<br/>
	<br/>
	<div align="right"><button onclick="setCookieRatingToday();">오늘 하루 열지 않음</button></div>	
</div>

<script>
	$("#survey_flag").val("enable");
	
	var r_height = 480;
	var r_width = 700;
	var r_preSubject = '회사만족도 및 상향평가 실시';			
	
	var r_flag = '${upperSurvey}';
	
	$("#popup-rating").dialog({
		height: r_height,
		width: r_width,
		closeOnEscape : true,
		draggable : true,					
		title: r_preSubject,				
		modal: true,
		position: { 'at' : 'right top' }		
	});	
	
	
	function setCookieRatingToday(){
		var name = "ratingInfo";
		var value = "done";
		var expiredays = 1;
		var todayDate = new Date();
	    todayDate.setDate( todayDate.getDate() + expiredays );
	    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	    $("#popup-rating").dialog('close');
	}
	
	function getCookieRatingToday () {		
	    var cookiedata = document.cookie;
	    var rating_url = "";
	    
	    if( r_flag == 'Z' || r_flag == '' ){
	    	$("#popup-rating").dialog('close');
	    }else{
	    	if ( cookiedata.indexOf("ratingInfo=done") < 0 ){
	    		//url 셋팅 (2025.10.16 수정)
	    		if( r_flag == 'A' ){
	    			rating_url = "https://naver.me/xQiHIen8";	    			
	    		}else if( r_flag == 'B' ){
	    			rating_url = "https://naver.me/5gYNsFmY";
	    		}else if( r_flag == 'C' ){
	    			rating_url = "https://naver.me/xGF6aIzI";
	    		}else if( r_flag == 'D' ){
	    			rating_url = "https://naver.me/Gf0wjCnd";
	    		}else if( r_flag == 'E' ){
	    			rating_url = "https://naver.me/GIGQcGxJ";
	    		}else if( r_flag == 'F' ){
	    			rating_url = "https://naver.me/GJ5LG5YZ";
	    		}	    		
	    		
	    		var survey_tag = "<a href='"+rating_url+"' target='_blank'><font color='blue'>[클릭하세요]</font></a>";	    		
	    		
	    		$("#survey_url").html(survey_tag);
	    		
		    	$("#popup-rating").dialog('open');	    	
		    }else {
		    	$("#popup-rating").dialog('close');	        
		    }	
	    }	    
	}
</script>

</c:if>

<!-- 회사만족도 및 상향평가 실시 끝 -->

<!-- 교육수요조사 실시 시작 by top3009-->
<%-- 교육수요조사 사용안함
<fmt:parseDate value="202011020000" pattern="yyyyMMddHHmm" var="startEduDate" />
<fmt:parseDate value="202011042359" pattern="yyyyMMddHHmm" var="endEduDate" />
<fmt:formatDate value="${startEduDate}" pattern="yyyyMMddHHmm" var="openEduDate"/>       <!-- 시작날짜 -->
<fmt:formatDate value="${endEduDate}" pattern="yyyyMMddHHmm" var="closeEduDate"/>        <!-- 마감날짜 -->
<c:if test="${openEduDate < nowDate && closeEduDate > nowDate && (mbrVo_Session.team_type == 0 or mbrVo_Session.team_type == 1) }">

<div id="popup-edu-rating" title="교육수요조사 실시" style="font-size: 12px;" >
	<br/>
	<div style="text-align:center;">
		<b><font size="5">교육수요조사 실시</font></b>
	</div>	
	<br/>
	<br/>
	<div class="tableStyle2" style="width: 680px;">	
		<table class="vacation-ins-table">
			<tr>			
				<td style="font-size:14px;text-align:left;padding-left:10px;">
					<b><br/>
						인사총무팀에서는물보험본부 직원들의 동영상 교육을 준비하고 있습니다. 온라인 교육과정 개발을 위해 설문을 실시하오니 성의있는 답변을 해주시면 양질의 교육을 만드는데 참고하도록 하겠습니다.<br/><br/>
					</b>				
				<span style="font-size:12px;font-weight:bold;">								
					◆ 설문 및 평가기간 : 2020.11.02.(월) ~ 11.04.(수)(3일간) <br/>
					◆ 설문 및 평가 바로가기 : <a href="http://naver.me/xSjxyMym" target="_blank"><font color="blue">http://naver.me/xSjxyMym</font></a>
				</span>							
				</td>
			</tr>
		</table>
	</div>	
	<br/><br/><br/>
	<div align="right"><button onclick="setCookieRatingEduToday();">오늘 하루 열지 않음</button></div>	
</div>

<script>
	var r_height = 320;
	var r_width = 700;
	var r_preSubject = '교육수요조사 실시';			
	
	$("#popup-edu-rating").dialog({
		height: r_height,
		width: r_width,
		closeOnEscape : true,
		draggable : true,					
		title: r_preSubject,				
		modal: true,
		position: { 'at' : 'center top' }		
	});	
	
	
	function setCookieRatingEduToday(){
		var name = "ratingEduInfo";
		var value = "done";
		var expiredays = 1;
		var todayDate = new Date();
	    todayDate.setDate( todayDate.getDate() + expiredays );
	    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	    $("#popup-edu-rating").dialog('close');
	}
	
	function getCookieRatingToday () {
	    var cookiedata = document.cookie;
	    var rating_url = "";	    
	    
    	if ( cookiedata.indexOf("ratingEduInfo=done") < 0 ){
    		$("#popup-edu-rating").dialog('open');	    	
	    }else {
	    	$("#popup-edu-rating").dialog('close');	        
	    }	    
	}
</script>

</c:if>
 --%>
<!-- 교육수요조사 실시 종료 by top3009-->

<!-- 1종 휴가 공지 팝업 시작 -->
<%-- 1,4종 휴가 공지 팝업 사용안함
<fmt:parseDate value="201911080800" pattern="yyyyMMddHHmm" var="startVacationDate" />
<fmt:parseDate value="201911152359" pattern="yyyyMMddHHmm" var="endVacationDate" />
<fmt:formatDate value="${startVacationDate}" pattern="yyyyMMddHHmm" var="openVacationDate"/>       <!-- 시작날짜 -->
<fmt:formatDate value="${endVacationDate}" pattern="yyyyMMddHHmm" var="closeVacationDate"/>        <!-- 마감날짜 -->
<!--마감일자와 1종만 표시 -->
<c:if test="${openVacationDate < nowDate && closeVacationDate > nowDate && (mbrVo_Session.team_type == 0 or mbrVo_Session.team_type == 1) }">

<div id="popup-vacation" title="미리보기" style="font-size: 12px;">
	<br/>
	<b>연차유급휴가 발생, 사용내역(기준일 : 2019. 11. 11)을 아래와 같이 안내합니다.</b>
	<br/>
	<br/>
	<div class="tableStyle2" style="width: 1050px;">	
		<table class="vacation-ins-table">
			<tr>
				<th colspan="4" width="40%"> 2018년 (2018년 입사일 ~ 2019년 입사 전일)</th>
				<th colspan="6" width="60%"> 2019년 (2019년 입사일 ~ 2020년 입사 전일)</th>
			</tr>			
			<tr>
				<th><sup><b><font color="red" size="1">1)</font></b></sup> 2018년 입사일<br/>발생연차</th>
				<th><sup><b><font color="red" size="1">2)</font></b></sup> 2018년 대체<br/>사용연차</th>
				<th><sup><b><font color="red" size="1">3)</font></b></sup> 휴가신청<br/>사용연차</th>
				<th><sup><b><font color="red" size="1">4)</font></b></sup> 2018년<br/>잔여연차</th>			
				<th><sup><b><font color="red" size="1">5)</font></b></sup> 2018년<br/>이월연차</th>
				<th><sup><b><font color="red" size="1">6)</font></b></sup> 2019년<br/>발생<u>(예상)</u>연차</th>
				<th><sup><b><font color="red" size="1">7)</font></b></sup> 사용가능<br/>연차유급휴가</th>
				<th><sup><b><font color="red" size="1">8)</font></b></sup> 공휴일 대체<br/>사용연차</th>
				<th><sup><b><font color="red" size="1">9)</font></b></sup> 휴가신청<br/>사용연차</th>
				<th><sup><b><font color="red" size="1">10)</font></b></sup><font color="blue">2019년 입사일 ~<br/>2020년 입사전일<br/>잔여연차</font></th>
			</tr>
			<tr>
				<c:choose>
					<c:when test="${empty vacationTemp}">						
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
					</c:when>
					<c:otherwise>
						<td>${vacationTemp.col_1}</td>
						<td>${vacationTemp.col_2}</td>
						<td>${vacationTemp.col_3}</td>
						<td>${vacationTemp.col_4}</td>
						<td>${vacationTemp.col_5}</td>
						<td>${vacationTemp.col_6}</td>
						<td>${vacationTemp.col_7}</td>
						<td>${vacationTemp.col_8}</td>
						<td>${vacationTemp.col_9}</td>
						<td><font color="blue"><b>${vacationTemp.col_10}</b></font></td>
					</c:otherwise>
				</c:choose>
			</tr>
		</table>
	</div>
	<br/><br/>
	1) 2017년 입사일~2018년 입사 전일 1년간 소정근로일 80% 이상 출근한 근로자에게 2018년 입사일 부여된 연차유급휴가로, 부여일부터 1년간(2018년 입사일~2019년 입사 전일)<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;사용가능한 연차유급휴가 일수 [근로기준법에 따른 연차유급휴가]<br/>
	&nbsp;&nbsp;&#9312; 입사 1년미만 근로자 또는 1년간 80% 미만 출근한 근로자는 1개월 개근 시 1일의 유급휴가 부여<br/>
	&nbsp;&nbsp;&#9313; 최초 입사 후 1년 경과 시 유급휴가 15일 부여, 3년 이상 계속근로 시 최초 1년 초과하는 계속 근로 연수 매 2년마다 1일 가산한 연차유급휴가 부여<br/><br/>
	2) 2018년 입사일~2019년 입사 전일 연차유급휴가 사용가능기간(소정근로일)에 속해 있는 <sup><b><font color="red" size="1">※</font></b></sup>공휴일(일요일 제외)로, 회사와 근로자 대표 간 합의를 통해 연차유급휴가로 사용 대체한 <br/>
	&nbsp;&nbsp;&nbsp;&nbsp;연차유급휴가 일수	&nbsp;&nbsp;<b><a href="http://www.law.go.kr/법령/근로기준법/(20191101,16415,20190430)/제62조" target="_blank"><font color="red">[근로기준법 제 62조(유급휴가의 대체)]</font></a></b><br/>
	<b><a href="http://www.law.go.kr/lsInfoP.do?lsiSeq=197878&efYd=20171017#0000" target="_blank"><font color="red"><u>※ 『관공서의 공휴일에 관한 규정(대통령령)』참조 &larr; Click</u></font></a></b><br/><br/>
	3) 근로자가 당해기간 중 인트라넷 "휴가 신청"을 통해 신청, 사용한 연차유급휴가 일수<br/><br/>
	4) 2019년 입사 전일까지 사용가능한 연차유급휴가 일수로, "1) 2018년 발생연차"에서 "2)공휴일 대체 사용연차"와 "3)휴가신청 사용연차"를 차감하고 남은 연차유급휴가 일수<br/><br/>
	5) "4)2018년 잔여연차"가 양수인 경우 2019년에 사용가능하도록 이월된 연차유급휴가 일수<br/>
	&nbsp;&nbsp;&#9312; "4)2018년 잔여연차"가 양수인 경우 이월<br/>
	&nbsp;&nbsp;&#9313; "4)2018년 잔여연차"가 음수인 경우 "0"으로 적용<br/><br/>
	6) 2018년 입사일~2019년 입사 전일 1년간 소정근로일 80% 이상 출근한 근로자에게 2019년 일사일 부여된 연차유급휴가로, 부여일부터 1년간(2019년 입사일~2020년 입사 전일)<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;사용가능한 연차유급휴가 일수 [근로기준법에 따른 연차유급휴가]<br/><br/>
	7) "5)2018년 이월 연차"와 "6)2019년 발생연차"를 합산한 연차유급휴가 일수<br/><br/>
	8) 2019년 입사일~2019.12.31. 연차유급휴가 사용가능기간(소정근로일)에 속해 있는 공휴일(일요일 제외)로, 회사와 근로자 대표 간 합의를 통해 연차유급휴가로 사용 대체한<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;연차유급휴가 일수<br/><br/>
	<b><font color="red"><u>※ 2019.12.25.(성탄절) 공휴일 대체 사용연차일수 미포함</u></font></b><br/><br/>
	9) 근로자가 당해기간 중 인트라넷 "휴가 신청"을 통해 신청, 사용한 연차유급휴가 일수<br/><br/>
	10) 2019년 입사일 ~ 2020년 입사 전일까지 사용가능한 연차유급휴가 일수로, "7) 사용가능 연차유급휴가"에서 "8)공휴일 대체 사용연차"와 "9)휴가신청 사용연차"를 차감하고 남은<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;연차유급휴가 일수	&nbsp;&nbsp;단, "10)2019년 입사일 ~ 2020년 입사전일 잔여연차"가 음수인 경우 "0"으로 적용<br/><br/>	
	<b><font color="red">∴ 10) 2019년 입사일 ~ 2020년 입사전일까지 사용 가능한 잔여연차가 음수 or "0"인 경우 사용자, 근로자간 합의(동의)하에 2020년 입사일 부여받을 연차유급휴가 미리<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;사용 가능	(연차유급휴가 선사용)</font></b>	
	<br/><br/>
	상기 연차유급휴가 발생, 사용내역관련 문의사항은 <b><u><font color="blue">인사총무팀 김두현부장(02-6077-4605)</font></u></b>에게 문의 바랍니다.<br/><br/>
	<div align="right"><button onclick="setCookieToday();">오늘 하루 열지 않음</button></div>	
</div>

</c:if>
<!--마감일자와 4종만 표시 -->
<c:if test="${openVacationDate < nowDate && closeVacationDate > nowDate && mbrVo_Session.team_type == 4 }">

<div id="popup-vacation4" title="미리보기" style="font-size: 12px;">
	<br/>
	<b>연차유급휴가 발생, 사용내역(기준일 : 2019. 11. 11)을 아래와 같이 안내합니다.</b>
	<br/>
	<br/>
	<div class="tableStyle2" style="width: 1030px;">	
		<table class="vacation-ins-table">
			<tr>
				<th colspan="4" width="42%"> 2018년 (2018년 입사일 ~ 2019년 입사 전일)</th>
				<th colspan="5" width="58%"> 2019년 (2019년 입사일 ~ 2020년 입사 전일)</th>
			</tr>			
			<tr>
				<th><sup><b><font color="red" size="1">1)</font></b></sup> 2018년 입사일<br/>발생연차</th>
				<th><sup><b><font color="red" size="1">2)</font></b></sup> 공휴일 대체<br/>사용연차</th>
				<th><sup><b><font color="red" size="1">3)</font></b></sup> 휴가신청<br/>사용연차</th>
				<th><sup><b><font color="red" size="1">4)</font></b></sup> 2018년<br/>잔여연차</th>
							
				<th><sup><b><font color="red" size="1">5)</font></b></sup> 2018년<br/>이월연차</th>
				<th><sup><b><font color="red" size="1">6)</font></b></sup> 2019년 입사일<br/>발생<u>(예상)</u>연차</th>
				<th><sup><b><font color="red" size="1">7)</font></b></sup> 사용가능<br/>연차 유급휴가</th>
				<th><sup><b><font color="red" size="1">8)</font></b></sup> 공휴일 대체<br/>사용연차</th>
				<th><sup><b><font color="red" size="1">9)</font></b></sup><font color="blue">2019년 입사일 ~ <br/>2020년 입사전일<br/>잔여연차</font></th>				
			</tr>
			<tr>
				<c:choose>
					<c:when test="${empty vacationTemp}">						
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>						
					</c:when>
					<c:otherwise>
						<td>${vacationTemp.col_1}</td>
						<td>${vacationTemp.col_2}</td>
						<td>${vacationTemp.col_3}</td>
						<td>${vacationTemp.col_4}</td>
						<td>${vacationTemp.col_5}</td>
						<td>${vacationTemp.col_6}</td>
						<td>${vacationTemp.col_7}</td>
						<td>${vacationTemp.col_8}</td>
						<!-- <td>${vacationTemp.col_9}</td> -->
						<td><font color="blue"><b>${vacationTemp.col_10}</b></font></td>
					</c:otherwise>
				</c:choose>
			</tr>
		</table>
	</div>
	<br/><br/>
	1) 2017년 입사일~2018년 입사 전일 1년간 소정근로일 80% 이상 출근한 근로자에게 2018년 입사일 부여된 연차유급휴가로, 부여일부터 1년간(2018년 입사일~2019년 입사 전일)<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;사용가능한 연차유급휴가 일수 [근로기준법에 따른 연차유급휴가]<br/>
	&nbsp;&nbsp;&#9312; 입사 1년미만 근로자 또는 1년간 80% 미만 출근한 근로자는 1개월 개근 시 1일의 유급휴가 부여<br/>
	&nbsp;&nbsp;&#9313; 최초 입사 후 1년 경과 시 유급휴가 15일 부여, 3년 이상 계속근로 시 최초 1년 초과하는 계속 근로 연수 매 2년마다 1일 가산한 연차유급휴가 부여<br/><br/>
	2) 2018년 입사일~2019년 입사 전일 연차유급휴가 사용가능기간(소정근로일)에 속해 있는 <sup><b><font color="red" size="1">※</font></b></sup>공휴일(일요일 제외)로, 회사와 근로자 대표 간 합의를 통해 연차유급휴가로 사용 대체한<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;연차유급휴가 일수 &nbsp;&nbsp;<b><a href="http://www.law.go.kr/법령/근로기준법/(20191101,16415,20190430)/제62조" target="_blank"><font color="red">[근로기준법 제 62조(유급휴가의 대체)]</font></a></b><br/>
	<b><a href="http://www.law.go.kr/lsInfoP.do?lsiSeq=197878&efYd=20171017#0000" target="_blank"><font color="red"><u>※ 『관공서의 공휴일에 관한 규정(대통령령)』참조 &larr; Click</u></font></a></b><br/><br/>
	3) 근로자가 당해기간 중 인트라넷 "휴가 신청"을 통해 신청, 사용한 연차유급휴가 일수<br/><br/>
	4) 2019년 입사 전일까지 사용가능한 연차유급휴가 일수로, "1) 2018년 발생연차"에서 "2)공휴일 대체 사용연차"와 "3)휴가신청 사용연차"를 차감하고 남은 연차유급휴가 일수<br/><br/>
	5) "4)2018년 잔여연차"가 양수인 경우 2019년에 사용가능하도록 이월된 연차유급휴가 일수<br/>
	&nbsp;&nbsp;&#9312;"4)2018년 잔여연차"가 양수인 경우 이월<br/>
	&nbsp;&nbsp;&#9313;"4)2018년 잔여연차"가 음수인 경우 "0"으로 적용<br/><br/>
	6) 2018년 입사일~2019년 입사 전일 1년간 소정근로일 80% 이상 출근한 근로자에게 2019년 일사일 부여된 연차유급휴가로, 부여일부터 1년간(2019년 입사일~2020년 입사 전일)<br> 
	&nbsp;&nbsp;&nbsp;&nbsp;사용가능한 연차유급휴가 일수 [근로기준법에 따른 연차유급휴가]<br/><br/>
	7) "5)2018년 이월 연차"와 "6)2019년 발생연차"를 합산한 연차유급휴가 일수<br/><br/>
	8) 2019년 입사일~2019.12.31. 연차유급휴가 사용가능기간(소정근로일)에 속해 있는 공휴일(일요일 제외)로, 회사와 근로자 대표 간 합의를 통해 연차유급휴가로 사용 대체한<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;연차유급휴가 일수<br/>
	<b><font color="red"><u>※ 2019.12.25.(성탄절) 공휴일 대체 사용연차일수 미포함</u></font></b><br/><br/>
	9) 2019년 입사일 ~ 2020년 입사 전일까지 사용가능한 연차유급휴가 일수로, "7) 사용가능 연차유급휴가"에서 "8)공휴일 대체 사용연차"를 차감하고 남은 연차유급휴가 일수<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;단, "9)2019년 잔여연차"가 음수인 경우 "0"으로 적용<br/><br/>
	<b><font color="red">∴ 9) 2019년 입사일 ~ 2020년 입사전일까지 사용 가능한 잔여연차가 음수 or "0"인 경우 사용자, 근로자간 합의(동의)하에 2020년 입사일 부여받을 연차유급휴가<br/>
	 &nbsp;&nbsp;&nbsp;&nbsp;미리 사용 가능	(연차유급휴가 선사용)</font></b>
	<br/><br/>
	<div align="right"><button onclick="setCookieToday4();">오늘 하루 열지 않음</button></div>	
</div>

</c:if>
--%>
<script>
	var p_height = 668;
	var p_width = 1050;
	var preSubject = '연차유급휴가 발생, 사용내역 안내 (물보험본부) ';
	var preSubject4 = '연차유급휴가 발생, 사용내역 안내 (인보험본부) ';	
	
	$("#popup-vacation").dialog({
		height: 800,
		width: 1080,
		closeOnEscape : true,
		draggable : true,					
		title: preSubject,				
		modal: true,
		position: { 'at' : 'left top' }		
	});
	
	function setCookieToday(){
		var name = "vacatonInfo";
		var value = "done";
		var expiredays = 1;
		var todayDate = new Date();
	    todayDate.setDate( todayDate.getDate() + expiredays );
	    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	    $("#popup-vacation").dialog('close');
	}
	
	function getCookieToday() {
	    var cookiedata = document.cookie;	    
	    if ( cookiedata.indexOf("vacatonInfo=done") < 0 ){	    	
	    	$("#popup-vacation").dialog('open');  
	    }else {	    		    
	    	$("#popup-vacation").dialog('close');	        
	    }
	}
		
	$("#popup-vacation4").dialog({
		height: 720,
		width: 1050,
		closeOnEscape : true,
		draggable : true,					
		title: preSubject4,				
		modal: true,
		position: { 'at' : 'left top' }		
	});
	
	function setCookieToday4(){
		var name = "vacatonInfo4";
		var value = "done";
		var expiredays = 1;
		var todayDate = new Date();
	    todayDate.setDate( todayDate.getDate() + expiredays );
	    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	    $("#popup-vacation4").dialog('close');
	}
	
	function getCookieToday4() {
	    var cookiedata = document.cookie;	    
	    if ( cookiedata.indexOf("vacatonInfo4=done") < 0 ){	    	
	    	$("#popup-vacation4").dialog('open');  
	    }else {	    	
	    	$("#popup-vacation4").dialog('close');	        
	    }
	}
	
</script>

<!-- 1종 휴가 공지 팝업 끝 -->

<!-- 센터장 팀장 휴가자 조회 팝업 시작 -->
<!-- 휴가자가 있는 경우만 팝업으로 표시한다. -->
<c:if test="${ !empty vacationMember}">
<div id="popup-vacation-member" title="미리보기" style="font-size: 12px;">
	<br/>
	<b>오늘 (${sToday}) 휴가자 명단 입니다.</b>
	<br/>
	<br/>	
	<div class="tableStyle2" style="width: 300px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="30%">이름</th>
				<th width="20%">휴가종류</th>
				<th width="50%">휴가기간</th>
			</tr>
			<c:forEach var="member" items="${vacationMember}" varStatus="status">
				<tr>
					<td>${member.user_name}</td>
					<td>${member.vacation_type_val}</td>
					<td>${member.sdate} ~ ${member.edate}</td>
				</tr>
			</c:forEach>			
		</table>
	</div>	
	<br/><br/>
	<div align="right"><button onclick="setCookieTodayMember();">오늘 하루 열지 않음</button></div>
</div>
<script>

var preSubjectMember = '오늘 휴가자 명단';
var h_size = ${vacationMember.size()}*25 + 200;

$("#popup-vacation-member").dialog({
	height: h_size,
	width: 330,
	closeOnEscape : true,
	draggable : true,					
	title: preSubjectMember,				
	modal: true,
	position: { 'at' : 'right top' }		
});

</script>
</c:if>
<!-- 센터장 팀장 휴가자 조회 팝업 끝 -->

<!-- 손해사정서 교부 통계 오픈시 주석제거 by top3009 -->
<%-- <c:choose>
	<!-- (팀기준) 손해사정서 교부 통계 팝업 시작 -->	
	<c:when test="${ !empty teamSendResult}">
		<div id="popup-send-teamlist" title="미리보기" style="font-size: 12px;">
			<div class="tableStyle2" style="width: 300px;">		
				<table class="vacation-ins-table">
					<tr>
						<th width="50%">소속</th>
						<th width="50%">손해사정서미교부건수</th>			
					</tr>
				<c:forEach var="teamlist" items="${teamSendResult}" varStatus="status">
					<tr onclick="javascript:goSendMemberList(${teamlist.teamId});" style="cursor:pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
						<td>${teamlist.teamName}</td>
						<td>${teamlist.noSendCnt}</td>								
					</tr>
				</c:forEach>			
				</table>
			</div>	
			<!-- <br/>
			<div align="right"><button onclick="setCookieTeamList();">오늘 하루 열지 않음</button></div> -->
		</div>
		<script>
		
		var preSubjectTeamList = '손해사정서 미교부현황(팀)';
		var h_size = ${teamSendResult.size()}*25 + 120;
		
		if(h_size > 800){
			h_size = 800;
		}
		
		$("#popup-send-teamlist").dialog({
			height: h_size,
			width: 330,
			closeOnEscape : true,
			draggable : true,					
			title: preSubjectTeamList,				
			modal: true,
			position: { 'at' : 'right-505 top' }		
		});
		
		function goSendMemberList(p_team_id){	
			
			//개인별 손해사정서 미교부 갯수 가져오기
			var url = "/noSendMemberListModal";
			
			var param = {};
			param.team_id = p_team_id;
			
			$.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				timeout: 20000,
				dataType: "HTML", 
				success: function(data){			
					$("#nosend-detail-dialog").html();
					$("#nosend-detail-dialog").html(data);			
						$("#nosend-detail-dialog").dialog({
							height: 380,
							width: 600,
							closeOnEscape : true,
							draggable : true,
							title: "손해사정서 미교부현황(개인)",					
							modal: true,
							position: { 'at' : 'right-975 top' },					
							buttons:{						
								"닫기" : function(){
									$(this).dialog("close");
								}
							},
							overlay:{ opacity: 0., background: '#000000'}
						});		
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
		}
		
		</script>
	</c:when>
	<!--(개인 기준) 손해사정서 교부 통계 팝업 시작-->
	<c:when test="${ !empty personSendResult}">		
		<div id="nosend-person-dialog" title="미리보기" style="font-size: 12px;">
			<div class="tableStyle2" style="width: 380px;">		
				<table class="vacation-ins-table">
					<tr>
						<th width="20%">전체</th>
						<th width="25%">계약자</th>
						<th width="25%">피보험자</th>
						<th width="30%">보험금청구권자</th>								
					</tr>					
					<tr onclick="javascript:goSendReportList('${personSendResult.user_no}','${personSendResult.user_name}');" style="cursor:pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
						<td>${personSendResult.total_cnt}</td>
						<td>${personSendResult.type1_cnt}</td>
						<td>${personSendResult.type5_cnt}</td>
						<td>${personSendResult.type10_cnt}</td>
					</tr>
				</table>
			</div>
		</div>
		
		<script>
		
		var preSubjectPersonList = '손해사정서 미교부현황';		
		
		$("#nosend-person-dialog").dialog({
			height: 130,
			width: 400,
			closeOnEscape : true,
			draggable : true,					
			title: preSubjectPersonList,				
			modal: true,
			position: { 'at' : 'center top' }		
		});
		</script>
	</c:when>
</c:choose>

<div id="nosend-detail-dialog" title="손해사정서 미교부현황(개인)" style="font-size: 15px;display:none;" align="center"></div>
<div id="nosend-report-dialog" title="손해사정서 미교부현황(보고서)" style="font-size: 15px;display:none;" align="center"></div>
<div id="nosend-person-dialog" title="손해사정서 미교부현황" style="font-size: 15px;display:none;" align="center"></div>
<!-- 팀기준 손해사정서 교부 통계 팝업 끝 -->
<script>
	//보고서 새창 띄우기	
	function popSuimDtl(suim_rpt_no){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		//손해사정서가 기본탭으로 뜨도록 수정
		localStorage.setItem('activeTab','2');
		window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	
	function goSendReportList(p_user_no, p_user_name){
		//보고서 비교부현황 목록 가져오기	
		
		var url = "/noSendReportListModal";
		
		var param = {};
		param.user_no = p_user_no;
		param.user_name = p_user_name;
		
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			timeout: 20000,
			dataType: "HTML", 
			success: function(data){			
				$("#nosend-report-dialog").html();
				$("#nosend-report-dialog").html(data);			
					$("#nosend-report-dialog").dialog({
						height: 800,
						width: 800,
						closeOnEscape : true,
						draggable : true,
						title: "손해사정서 미교부현황(보고서)",					
						modal: true,
						position: { 'at' : 'center top' },					
						buttons:{						
							"닫기" : function(){
								$(this).dialog("close");
							}
						},
						overlay:{ opacity: 0., background: '#000000'}
					});		
			},
			error: function(e){
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});			
	}
</script> --%>
</body>
</html>
