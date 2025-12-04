<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
	<style>
		td{
			letter-spacing: 0px !important;
		}
		
		#header .inner #gnb>ul>li{
			width:140px !important;
		}
		#header .inner #gnb>ul>li ul{
			width:140px !important;
		} 
		
		#header .inner #gnb>ul>li ul li{
			width:140px !important;
		}
			
		.buttonAssistanceLec{
			width:80px;
			height:23px;
		    background-color:#FFA500;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }		
		.buttonAssistanceEdu{
			width:100px;
			height:23px;
		    background-color:#FF0099;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		.buttonAssistance{
			width:70px;
			height:23px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		
		.buttonAssistanceEmail{
			width:60px;
			height:23px;
		    background-color:darkCyan;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
	
		.buttonEduView{
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
			color:#FFFFFF  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3232FF;
		    }
		    
		.buttonEduDown{
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
			color:#FFFFFF  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF0099;
		    }
		    
		/*보기 회색 버튼*/
		.btn-equipment-gray {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #666666;
		}
		
		/*수정 버튼*/
		.btn-equipment-mod {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #0033FF;
		}
		
		.buttonMenuLec{
			width:275px;
			height:30px;
		    /* background-color:#2E7EE8; */
		    background-color:#013469;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 14px;
		    font-weight:bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		.buttonMenuLec:hover{
			background-color:#FFA500;
		}
		
		.buttonIngFlag{
			width:70px;
			height:23px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
	    }
	    
		.buttonReadyFlag{
			width:70px;
			height:23px;
		    background-color:#FFA500;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		    
		.buttonEndFlag{
			width:70px;
			height:23px;
		    background-color:#666;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		
		.buttonDoneFlag{
			width:70px;
			height:23px;
		    background-color:#00a000;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		
		.buttonShowFlag{
			width:70px;
			height:23px;
		    background-color:#3232FF;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		
		.buttonShowQna{
			width:50px;
			height:23px;
		    background-color:#FFA500;
		    color:#000000;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
				    
		.buttonRejectFlag{
			width:70px;
			height:23px;
		    background-color:#FF4040;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
		
		.buttonMiniView{
			width:80px;
			height:20px;
		    background-color:#F7F7F7;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#EFF8FB;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}		
	</style>
	<script type="text/javascript">
		function openGroupSMS(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=700; //띄울 창의 넓이
			var sh=533;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('groupSMSForm','groupSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function goSearchMain(){			
			$("#searchMainForm").attr("action","searchMain");
		}
		
		function goSearchMainQuery(){
			$("#searchMainForm").attr("action","searchMainQuery");
		}

		//관리자 교육관리 메뉴
		function goLectureManagerList(){
			$("#lectureManagerForm").submit();			
		}
		
		//관리자 교육 결재 메뉴
		function goLectureManagerApprovalList(){
			$("#lectureManagerApprovalForm").submit();
		}
		
		//관리자 교육 통계메뉴
		function goLectureManagerStatistics(){
			$("#lectureManagerStatisticsForm").submit();
		}
		
		//관리자 공개교육관리
		function goOpenLectureManager(){
			$("#lectureOpenManagerForm").submit();
		}
		
		//사용자 수강신청 및 조회 메뉴
		function goLectureUserApply(){
			$("#lectureUserApplyForm").submit();
		}
		
		//사용자 교육 Q&A 메뉴
		function goLectureQna(){
			$("#boardType").val(0);
			$("#eduQnaForm").submit();
		}
		
		//교육자료실 이동
		function goLectureData(){
			$("#boardType").val(1);
			$("#eduQnaForm").submit();
		}
		
		//공개강의실 이동
		function goLectureOpen(){
			$("#lectureOpenForm").submit();
		}
		
		function goLecClass(){
			$("#lecForm").submit();
		}
		
		//공개 강의실 강의시청
		function doOpenClassView( p_okey ){
			
			//교육키 설정
			$("#okey").val(p_okey);
			
			var viewForm = document.openClassViewForm;
			
			var url = 'lectureOpenClassView';
			window.open('', 'popOpenClassView','width=1620,height=870,scrollbars=no,resizable=no,status=yes,menubar=no,toolbar=no,top=50,left=50');		
			viewForm.action = url;
			viewForm.method = 'post';
			viewForm.target = 'popOpenClassView';
			viewForm.submit();
		}
		
		//공개 강의실 조회로그 조회
		function doOpenLectureLogView( p_okey ){
			
			var url = "./openLectureLogModal";
			
			var param = {};
			param.okey = p_okey;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#open-user-dialog").html();
		        	$("#open-user-dialog").html(data);
					$("#open-user-dialog").dialog({
						height: 500,
						width: 700,
						closeOnEscape : true,
						draggable : true,
						title: "공개 강의실 조회로그",
						modal: true,
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
		
		//공개 강의실 정보조회
		function doOpenLectureView( p_okey ){
			
			var url = "./openLectureUserModal";
			
			var param = {};
			param.okey = p_okey;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#open-user-dialog").html();
		        	$("#open-user-dialog").html(data);
					$("#open-user-dialog").dialog({
						height: 280,
						width: 700,
						closeOnEscape : true,
						draggable : true,
						title: "공개 강의실 정보보기",
						modal: true,
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
	<!-- header -->
	<div id="header">
		<div class="inner clear_v2">
			<h1>
				<a href="./"><img id="menuLogoImg"  src="./resources/wm_img/common/logo.gif" alt="top - TRUST OBLIGATION PASSION" /></a>
				<div class="logobg"></div>
			</h1>
			<div class="hcont">
				<div class="header_top">
					<!-- 검색하기 -->
					<div class="h_schA">
						<%-- <form id="searchMainForm" name="searchMainForm" method="post">
							<fieldset>
								<legend>검색하기</legend>
								<ul>
									<li>
										<a href="#" onclick="javascript:goSearchMain();">
											<img alt="상세검색" src="./resources/wm_img/common/btn_sch.gif" alt="상세검색">
										</a>
									</li>
									<li class="ipt"><input type="text" id="searchMainSimpleQueryTxt" name="searchMainSimpleQueryTxt" value="${searchMainSimpleQueryTxt}" /></li>									
									<li>
										<a href="#" onclick="javascript:goSearchMainQuery();">										
											<img alt="검색하기" src="./resources/wm_img/common/bg_btnbg01.gif">
										</a>										
									</li>
								</ul>
							</fieldset>
						</form> --%>
					</div>
					<!-- //검색하기 -->
					<ul class="logArea">
						<!-- 교육(신규) 바로가기 -->
						<li><input type="button" value="TOP Edu" class="buttonAssistanceLec" onclick="javascript:goLecClass();"></li>
						<!-- 교육(동영상) 바로가기-->
						<li><a href="https://939.co.kr/tophelp"><input type="button" value="원격지원" class="buttonAssistance"></a></li>
						<!-- <li><a href="#"><input type="button" value="탑 메일" class="buttonAssistanceEmail" onclick="javascript:goMail();"></a></li> -->
						<li class="team">${mbrVo_Session.user_name} @ ${mbrVo_Session.team_name}</li>						
						<li><a href="javascript:openGroupSMS();"><img src="./resources/wm_img/common/ico_mobile.gif" alt="" /></a></li>						
						<li class="bgbt"><a href="./logout">Logout</a></li>
					</ul>					
				</div>

				<!-- gnb -->
				<div id="gnb">
					<ul>
						<li class="depth1">
							<a href="TopLecture">My Menu</a>
							<ul>								
                                <li><a href="#" onclick="goLectureUserApply();">수강신청 &middot; 내역</a></li>
                                <li><a href="#" onclick="goLectureOpen();">공개 강의실</a></li>
                                <li><a href="#" onclick="goLectureData();">교육 자료실</a></li>
                                <li><a href="#" onclick="goLectureQna();">Q&#38;A</a></li>                                								
							</ul>							
						</li>						
						<!-- <li class="depth1">
							<a href="#;">교육 통계</a>
							<ul>
								<li><a href="./MisBscPtnr">기본통계</a></li>								
							</ul>
						</li> -->
						<c:if test="${mbrAuthVo_Session.mbr_pms_36 != 0}">
						<li class="depth1">							
							<a href="#;">관리자</a>
							<ul>
								<li><a href="#" onclick="goLectureManagerList();">교육관리</a></li>
								<li><a href="#" onclick="goLectureManagerApprovalList();">교육결재</a></li>
								<li><a href="#" onclick="goLectureManagerStatistics();">교육통계</a></li>
								<li><a href="#" onclick="goOpenLectureManager();">공개교육관리</a></li>								
							</ul>							
						</li>						
						</c:if>
						<li class="depth1">
							<a href="#;"></a>							
						</li>
						<li class="depth1">
							<a href="#;"></a>							
						</li>
						<li class="depth1">
							<a href="#;"></a>							
						</li>
						<li class="depth1">
							<a href="#;"></a>							
						</li>
						<li class="depth1">
							<a href="./TopLecture" style="text-align:right;">&#8657; 교육 홈</a>
						</li>
					</ul>					
				</div>
				<!-- //gnb -->
			</div>
		</div>
		<div class="h_leftbg"></div>		
		</div>	
	<!-- //header -->
	<form id="lectureManagerForm" name="lectureManagerForm" action="lectureManagerList" method="post">
	</form>
	<form id="lectureManagerApprovalForm" name="lectureManagerApprovalForm" action="lectureManagerApprovalList" method="post">
	</form>
	<form id="lectureUserApplyForm" name="lectureUserApplyForm" action="lectureUserApplyList" method="post">
	</form>	
	<form id="lecForm" name="lecForm" method="post" action="TopLecture">
	</form>
	<form id="lectureManagerStatisticsForm" name="lectureManagerStatisticsForm" method="post" action="lectureManagerStatisticsList">
	</form>
	<form id="lectureOpenManagerForm" name="lectureOpenManagerForm" method="post" action="lectureOpenManager">
	</form>
	<!-- Qna 이동 -->
	<form id="eduQnaForm" name="eduQnaForm" action="brdLectureBoardList">
		<input type="hidden" id="titleSearch" name="titleSearch"/>
		<input type="hidden" id="boardType" name="boardType"/>
	</form>	
	<form id="eduViewForm" name="eduViewForm">
		<input type="hidden" id="ekey" name="ekey"/>
	</form>
	<!-- 공개 강의실 이동 -->
	<form id="lectureOpenForm" name="lectureOpenForm" action="lectureOpenList">
	</form>
	<!-- 공개강의실 시청하기 폼 -->
	<form id="openClassViewForm" name="openClassViewForm">
		<input type="hidden" id="okey" name="okey"/>
	</form>