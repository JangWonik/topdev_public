<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
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
		
		function doMasterList(){
			$("#salaryMasterForm").submit();	
		}
		
		function doMemberList(){
			$("#salaryMemberForm").submit();	
		}
		
		function doSalesRegist(){
			$("#salarySalesRegistForm").submit();
		}
		
		function doSalarySetup(){
			$("#salaryManageForm").submit();
		}
		
		function doSalaryIncentiveSetup(){
			$("#salaryIncentiveManageForm").submit();
		}
	</script>
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
	</style>
	<!-- header -->
	<div id="header">
		<div class="inner clear_v2">
			<h1>
				<a href="./"><img id="menuLogoImg"  src="./resources/wm_img/common/logo.gif" alt="top - TRUST OBLIGATION PASSION" /></a>				
			</h1>
			<div class="hcont">
				<div class="header_top">
					<!-- 검색하기 -->
					<div class="h_schA">
						<ul>
							<li style="padding-top:5px;">
								<marquee>
									<font style="font-size:14px;color:#00fdfa;letter-spacing:1px;font-weight:bold;">
									:::: 인보험 급여관리 페이지 입니다. 관계자 외 접근을 금합니다. ::::								
									</font>
								</marquee>
							</li>
						</ul>
					</div>
					<!-- //검색하기 -->
					<ul class="logArea">												
						<li class="team">${mbrVo_Session.user_name} @ ${mbrVo_Session.team_name}</li>
						<li class="bgbt"><a href="./logout">Logout</a></li>
					</ul>					
				</div>

				<!-- gnb -->
				<div id="gnb">
					<ul>						
						<li class="depth1">							
							<a href="#;">관리자</a>
								<ul>
									<li><a href="#" onclick="javascript:doMasterList();">급여 통합조회</a></li>
									<li><a href="#" onclick="javascript:doMemberList();">기본급 및 직무설정</a></li>
									<li><a href="#" onclick="javascript:doSalesRegist();">월별 실적등록</a></li>
									<li><a href="#" onclick="javascript:doSalarySetup();">기본급 환경설정</a></li>
									<li><a href="#" onclick="javascript:doSalaryIncentiveSetup();">성과급 환경설정</a></li>
								</ul>								
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
							<a href="#;"></a>							
						</li>
						<li class="depth1">
							<a href="#;"></a>							
						</li>
						<li class="depth1">
							<a href="/TopSalay4Main" style="text-align:right;">&#8657; 급여관리 홈</a>
						</li>
					</ul>					
				</div>
				<!-- //gnb -->
			</div>
		</div>
		<div class="h_leftbg">
		</div>
	</div>
	<!-- //header -->
	<!-- 인보험 급여 통합조회 폼 -->
	<form id="salaryMasterForm" name="salaryMasterForm" action="salaryMasterList" method="post">
	</form>
	<!-- 인보험 급여 관리 이동 폼 -->
	<form id="salaryMemberForm" name="salaryMemberForm" action="salaryMemberList" method="post">
	</form>
	<!-- 인보험 월별 실적 등록 폼 -->
	<form id="salarySalesRegistForm" name="salarySalesRegistForm" action="salarySalesRegistList" method="post">
	</form>
	<form id="salaryManageForm" name="salaryManageForm" action="salaryManagerList" method="post">
	</form>
	<form id="salaryIncentiveManageForm" name="salaryIncentiveManageForm" action="salaryIncentiveManagerList" method="post">
	</form>
	
<%--</body>--%>

<%--</html>--%>
