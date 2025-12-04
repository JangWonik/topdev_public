<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->

    <script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<style>
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
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #E0F2F7;			
		}
		
		.tableStyle2 td{
			letter-spacing:0px;
		}		
	</style>
	<script language="javascript">
		$(document).ready( function(){
			$("#srchYear").select2();
			$("#srchQuarter").select2();
			
			$("#srchBaseYearCenter").select2();
			$("#srchCenterYear").select2();
			$("#srchCenterQuarter").select2();
			
			$("#srchBaseYear").select2();
			$("#srchStatus").select2();
			$("#srchStatusCenter").select2();
			$("#srchSectorList").select2();
			$("#srchCenterList").select2();
			$("#srchCenterListCenter").select2();
			$("#tmSearchMain").select2();
			$("#srchQuarterFlag").select2();
			$("#srchQuarterFlagCenter").select2();
			
			if( '${param.viewType}' == 'Center'){
				$("#viewtype").val("Center");
			}else{
				$("#viewtype").val("Team");
			}
			
		});
		
		//팀장 목록 수정 
		function fnTeamModifyModal( p_mkey, p_manager_name ){
			
			var url = "/modifyBonusManagerQuarterInfoModal";
			
			var param = {};
			param.mkey = p_mkey;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#manager-detail-dialog").html();
		        	$("#manager-detail-dialog").html(data);
					$("#manager-detail-dialog").dialog({
						height: 480,
						width: 630,
						closeOnEscape : true,
						draggable : true,
						title: p_manager_name+" 분기정보 수정",						
						modal: true,
						buttons:{
							"수정 및 실적 재계산" : function(){
								var action = fnTeamCalAction('U');
								if (action){
									$(this).dialog("close");
								}
							},
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
		
		function fnTeamCalAction( p_action ){
			
			$("#actionFlag").val(p_action);
			
			var sdate = $("#editSDate").val();
			var edate = $("#editEDate").val();
			
			if( sdate == '' ){
				alert("시작 기준일을 입력해주세요.");
				$("#editSDate").focus();
				return;
			}
			
			if( edate == '' ){
				alert("종료 기준일을 입력해주세요.");
				$("#editEDate").focus();
				return;
			}
			
			var formData = $("#managerActionFrm").serialize();
			
			$("#top_loading").show();
			
			$.ajax({
				type : "post",
				url : "/updateBonusManagerInfoActionCal",
				data : formData,
				timeout: 20000,
       	        async: false,
       	        dataType: "JSON",				
				success : function(data){	 				
					//창 닫고 새로고침
					alert("수정 및 재계산 하였습니다.");
					$("#manager-detail-dialog").dialog('close');					
					
					//검색창 갱신
       	        	fnTeamSearch();
       	        	$("#top_loading").hide();
       	        	
       	        	//수정 했던 창 다시 열기
       	        	fnTeamModifyModal(data.mkey, data.manager_name);
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
		}
		
		//팀장 목록 삭제
		function fnTeamDel( p_mkey, p_manager_name ){
			
			if( !confirm( p_manager_name+"의 분기정보를 삭제하시겠습니까?") ){
				alert("취소");
				return;
			}
			
			var url = "deleteBonusManagerQuarterInfo";
			
			var param = {};			
			param.mkey = p_mkey;
			
			$("#top_loading").show();
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "JSON", 
       	        success: function(data){      
       	        	 if( data == 1 ){
       	        		alert( p_manager_name + " 정보를 삭제하였습니다.");
       	        	 }else{
       	        		 alert("삭제에 실패하였습니다.");
       	        	 }
       	        	
       	        	//검색창 갱신
       	        	fnTeamSearch();
       	        	$("#top_loading").hide();
       	        }
				,error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
       	    });
			
			
		}
		
		//센터장 목록 검색
		function fnCenterSearch(){
			
			var formData = $("#searchCenterFrm").serialize();
			
			$("#top_loading").show();
			
			$.ajax({
	 			type : "post",	 			
	 			url : "/getSchBonusManagerListByQuarterAjax",
	 			data : formData,
	 			success : function(result){			
	 				//날짜수정 페이지를 가져온다.	 				
	 				$("#divCenterList").html(result);
	 				$("#top_loading").hide();
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
		}
		
		//팀장 목록 검색
		function fnTeamSearch(){
			
			var formData = $("#searchTeamFrm").serialize();
			
			$("#top_loading").show();
			
			$.ajax({
	 			type : "post",	 			
	 			url : "/getSchBonusManagerListByQuarterAjax",
	 			data : formData,
	 			success : function(result){			
	 				//날짜수정 페이지를 가져온다.	 				
	 				$("#divTeamList").html(result);
	 				$("#top_loading").hide();
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
		}
		
		//팀장 탭 선택시 실행
		function doTeamTab(){
			$("#teamTab").attr("class","on");
			$("#teamView").show();
			$("#centerTab").attr("class","");
			$("#centerView").hide();			
			
			$("#viewType").val("Team");
		}
		
		//센터장 탭 선택시 실행
		function doCenterTab(){
			$("#teamTab").attr("class","");
			$("#teamView").hide();
			$("#centerTab").attr("class","on");
			$("#centerView").show();			
			
			$("#viewType").val("Center");
		}
		
		//팀장 분기 셋업
		function fnTeamSetup(){
			
			var selYear = $("#srchYear").val();
			var selQuarter = $("#srchQuarter").val();
			var viewType = $("#viewType").val();
			
			if( selYear == 9999 ){
				alert("연도를 선택해주세요.");
				$("#srchYear").focus();
				return;
			}
			
			
			if( selQuarter == 9999 ){
				alert("분기를 선택해주세요.");
				$("#srchQuarter").focus();
				return;
			}			
			
			var param = {};
			
			param.view_type = viewType;
			param.base_year = selYear;
			param.quarter_flag = selQuarter;
			
			$("#top_loading").show();
									
			var url = "/getBonusManagerQuarterInfo";
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "JSON", 
       	        success: function(data){      
       	        	if( data.result == 'success' ){
       	        		alert( data.insertCnt+"건이 등록되었습니다." );
       	        	}else{
       	        		alert("등록에 실패하였습니다.");	
       	        	}
       	        	
       	        	//검색창 갱신
       	        	fnTeamSearch();       	        	
       	        	$("#top_loading").hide();
       	        }
				,error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
       	    });
			
			
		}
		
		//센터장 분기 셋업
		function fnCenterSetup(){
			
			var selYear = $("#srchCenterYear").val();
			var selQuarter = $("#srchCenterQuarter").val();
			var viewType = $("#viewType").val();
			
			if( selYear == 9999 ){
				alert("연도를 선택해주세요.");
				$("#srchCenterYear").focus();
				return;
			}
			
			
			if( selQuarter == 9999 ){
				alert("분기를 선택해주세요.");
				$("#srchCenterQuarter").focus();
				return;
			}			
			
			var param = {};
			
			param.view_type = viewType;
			param.base_year = selYear;
			param.quarter_flag = selQuarter;
			
			$("#top_loading").show();
									
			var url = "/getBonusManagerQuarterInfo";
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "JSON", 
       	        success: function(data){      
       	        	if( data.result == 'success' ){
       	        		alert( data.insertCnt+"건이 등록되었습니다." );
       	        	}else{
       	        		alert("등록에 실패하였습니다.");	
       	        	}
       	        	
       	        	//검색창 갱신
       	        	fnCenterSearch();       	        	
       	        	$("#top_loading").hide();
       	        }
				,error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
       	    });
		}
		
		//팀장 목록 다운로드
		function fnTeamExcelDown(){
			$("#searchTeamFrm").attr("action","schBonusManagerListByExcel");
			$("#searchTeamFrm").submit();
		}
		
		//센터장 목록 다운로드
		function fnCenterExcelDown(){
			$("#searchCenterFrm").attr("action","schBonusManagerListByExcel");
			$("#searchCenterFrm").submit();
		}
		
		//스케줄러 수동 실행
		function fnSchRun(){
			
			if( !confirm("분기별 팀(센터)원 실적계산 스케줄러를 실행하시겠습니까?") ){				
				return;
			}			
			
			var param = {};
			
			$("#top_loading").show();			

			var url = "/doSchBonusQuarterMemberCal";
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 200000,
       	        /* async: false, 비동기로 처리하면 로딩시계가 안나온다. */
       	        dataType: "JSON", 
       	        success: function(data){
       	        	
       	        	alert("관리자 갱신 : "+data.manager+" 건\n관리자 기준 직원 실적 등록 완료 : "+data.result+" 건")       	        	
       	        	
       	        	$("#top_loading").hide();
       	        }
				,error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
       	    });
		}
	</script>
	
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
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
								<li class="on" id="teamTab" onclick="javascript:doTeamTab();"><a href="#">분기별 팀장 설정</a></li>
								<li id="centerTab" onclick="javascript:doCenterTab();"><a href="#">분기별 센터장 설정</a></li>
							</ul>
						</div>
						
						<!-- 팀장 설정 시작 -->
						<div id="teamView">							
							<div class="guestcnt4" style="display:block;height:800px;">
								<div class="tableStyle2">
									<table>									
										<tr>
											<th width="180px;">연도 분기별 팀장 불러오기</th>
											<td width="320px;" style="text-align:left;padding-left:10px;">
												<select id="srchYear" name="srchYear" style="width:100px;text-align:left;">
													<option value="9999"> - 연도선택 - </option>
													<option value="2023">2023년</option>
													<option value="2024">2024년</option>
													<option value="2025">2025년</option>
													<option value="2026">2026년</option>
												</select>
												&nbsp;												
												<select id="srchQuarter" name="srchQuarter" style="width:100px;text-align:left;">
													<option value="9999"> - 분기선택 - </option>
													<option value="1">1분기</option>
													<option value="2">2분기</option>
													<option value="3">3분기</option>
													<option value="4">4분기</option>
												</select>
												&nbsp;
												<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#D0F5A9;" onclick='javascript:fnTeamSetup();'>불러오기</a>
											</td>
											<td width="580px;" style="text-align:left;padding-left:10px;">
												&#8251; 연도와 분기 선택 후 불러오기 실행 시 해당연도 퇴사자 포함된 팀장정보를 불러옵니다. (기 등록 데이터 제외)
											</td>
											<%-- <c:if test="${mbrVo_Session.user_no eq 1786}"> --%>
											<td width="90px;">
													<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#F5BCA9;" onclick='javascript:fnSchRun();'>스케줄러</a>
											</td>
											<%-- </c:if> --%>																						
										</tr>
									</table>
									<br/>	
									<!-- 팀장 검색 창 시작 -->
									<form id="searchTeamFrm" name="searchTeamFrm">
										<input type="hidden" id="viewType" name="viewType" value="Team"/>
										<table style="width:100%;height:30px;" align="center">
											<tr>
												<th width="70px">기준연도</th>
												<td width="90px">
													<select id="srchBaseYear" name="srchBaseYear" style="width:80px;text-align:left;">
														<option value="9999"> - 전체 - </option>
														<option value="2023">2023년</option>
														<option value="2024">2024년</option>
														<option value="2025">2025년</option>
														<option value="2026">2026년</option>
													</select>												
												</td>
												<th width="70px">재직상태</th>
												<td width="90px">
													<select id="srchStatus" name="srchStatus" style="width:80px;text-align:left;">
														<option value="9999"> - 전체 - </option>
														<option value="0">재직자</option>
														<option value="1">퇴사자</option>
													</select>												
												</td>
												<th width="70px">센터명</th>
												<td width="160px">
													<select id="srchCenterList" name="srchCenterList" style="width:150px;text-align:left;">
														<option value=""> - 전체 - </option>													
														<c:forEach items="${centerList}" var="centerVo">
															<option value="${centerVo.teamCenter}">${centerVo.centerName}</option>
														</c:forEach>
													</select>
												</td>
												<th width="60px">팀명</th>
												<td width="180px">
													<select id="tmSearchMain" name="tmSearchMain" style="width:160px;text-align:left;">
														<option value="" <c:if test="${empty tmSearchMain}">selected</c:if> > - 전체 - </option>													
														<c:forEach items="${teamList}" var = "teamVo">
															<option value="${teamVo.teamId}"
																<c:if test="${tmSearchMain eq teamVo.teamId}">selected</c:if>>
																<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
																<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																${teamVo.teamName}
															</option>
														</c:forEach>
													</select>
												</td>
												<th width="60px">이름</th>
												<td width="140px">
													<input type="text" id="srchUserName" name="srchUserName" onkeydown="javascript:enterKey();" style="width:120px;"/>
													<input type="text" style="display:none;"/>												
												</td>
												<th width="70px">분기구분</th>
												<td>													
													<select id="srchQuarterFlag" name="srchQuarterFlag" style="width:80px;text-align:center;display:block;">
														<option value="9999"> - 전체 - </option>
														<option value="1">1분기</option>
														<option value="2">2분기</option>
														<option value="3">3분기</option>
														<option value="4">4분기</option>															
													</select>									
												</td>										
												<td>
													<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:fnTeamSearch();'>검 색</a>
												</td>
											</tr>
										</table>
										<div style="text-align:right;padding:5px 0 5px 0;">											
											<img src="./resources/ls_img/btn_excel.gif" onclick="javascript:fnTeamExcelDown();" style="cursor:pointer;">
										</div>										
										<!-- 팀장목록 시작 -->
										<div style="width:1260px;">
										<table>									
											<tr>
												<th width="40px;">순번</th>
												<th width="60px;">기준연도</th>
												<th width="40px;">분기</th>
												<th width="90px;">센터명</th>
												<th width="90px;">팀명</th>
												<th width="90px;">성명</th>
												<th width="50px;">직급</th>
												<th width="100px;">실적</th>
												<th width="90px;">목표건</th>
												<th width="90px;">실적건</th>
												<th width="90px;">성과율</th>
												<th width="70px;">시작일</th>
												<th width="70px;">종료일</th>
												<th width="70px;">입사일</th>												
												<th width="100px;"></th>													
												<th width="15px;"></th>													
											</tr>
										</table>
										</div>									
										<div id="divTeamList" style="overflow:auto;width:1260px; height:650px;"></div>						
									</form>
								</div>
							</div>
						</div>
						
						<!-- 센터장 설정 시작 -->
						<div id="centerView">							
							<div class="guestcnt4" style="display:none;height:800px;">
								<div class="tableStyle2">
									<table>									
										<tr>											
											<th width="200px;">연도 분기별 센터장 불러오기</th>
											<td width="400px;" style="text-align:left;padding-left:10px;">
												<select id="srchCenterYear" name="srchCenterYear" style="width:100px;text-align:left;">
													<option value="9999"> - 연도선택 - </option>
													<option value="2023">2023년</option>
													<option value="2024">2024년</option>
													<option value="2025">2025년</option>
													<option value="2026">2026년</option>
												</select>
												&nbsp;												
												<select id="srchCenterQuarter" name="srchCenterQuarter" style="width:100px;text-align:left;">
													<option value="9999"> - 분기선택 - </option>
													<option value="1">1분기</option>
													<option value="2">2분기</option>
													<option value="3">3분기</option>
													<option value="4">4분기</option>
												</select>
												&nbsp;
												<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#D0F5A9;" onclick='javascript:fnCenterSetup();'>불러오기</a>												
											</td>
											<td style="text-align:left;padding-left:10px;">
												&#8251; 연도와 분기 선택 후 불러오기 실행 시 해당연도 퇴사자 포함된 센터장정보를 불러옵니다. (기 등록 데이터 제외)
											</td>																						
										</tr>
									</table>
									<br/>	
									<!-- 센터장 검색 창 시작 -->
									<form id="searchCenterFrm" name="searchCenterFrm">
										<input type="hidden" id="viewType" name="viewType" value="Center"/>
										<table style="width:100%;height:30px;" align="center">
											<tr>
												<th width="70px">기준연도</th>
												<td width="90px">
													<select id="srchBaseYearCenter" name="srchBaseYearCenter" style="width:80px;text-align:left;">
														<option value="9999"> - 전체 - </option>
														<option value="2023">2023년</option>
														<option value="2024">2024년</option>
														<option value="2025">2025년</option>
														<option value="2026">2026년</option>
													</select>												
												</td>
												<th width="70px">재직상태</th>
												<td width="90px">
													<select id="srchStatusCenter" name="srchStatusCenter" style="width:80px;text-align:left;">
														<option value="9999"> - 전체 - </option>
														<option value="0">재직자</option>
														<option value="1">퇴사자</option>
													</select>												
												</td>
												<th width="70px">부문명</th>
												<td width="160px">
													<select id="srchSectorList" name="srchSectorList" style="width:150px;text-align:left;">
														<option value=""> - 전체 - </option>													
														<c:forEach items="${sectorList}" var="sectorVo">
															<option value="${sectorVo.teamSector}">${sectorVo.sectorName}</option>
														</c:forEach>
													</select>
												</td>
												<th width="70px">센터명</th>
												<td width="160px">
													<select id="srchCenterListCenter" name="srchCenterListCenter" style="width:150px;text-align:left;">
														<option value=""> - 전체 - </option>													
														<c:forEach items="${centerList}" var="centerVo">
															<option value="${centerVo.teamCenter}">${centerVo.centerName}</option>
														</c:forEach>
													</select>
												</td>												
												<th width="60px">이름</th>
												<td width="140px">
													<input type="text" id="srchUserNameCenter" name="srchUserNameCenter" onkeydown="javascript:enterKey();" style="width:130px;"/>
													<input type="text" style="display:none;"/>												
												</td>
												<th width="70px">분기구분</th>
												<td>													
													<select id="srchQuarterFlagCenter" name="srchQuarterFlagCenter" style="width:80px;text-align:center;display:block;">
														<option value="9999"> - 전체 - </option>
														<option value="1">1분기</option>
														<option value="2">2분기</option>
														<option value="3">3분기</option>
														<option value="4">4분기</option>															
													</select>									
												</td>										
												<td>
													<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:fnCenterSearch();'>검 색</a>
												</td>
											</tr>
										</table>
										<div style="text-align:right;padding:5px 0 5px 0;">											
											<img src="./resources/ls_img/btn_excel.gif" onclick="javascript:fnCenterExcelDown();" style="cursor:pointer;">
										</div>	
										<!-- 센터장목록 시작 -->
										<div style="width:1260px;">
										<table>									
											<tr>
												<th width="40px;">순번</th>
												<th width="60px;">기준연도</th>
												<th width="40px;">분기</th>													
												<th width="90px;">센터명</th>
												<th width="90px;">팀명</th>
												<th width="90px;">성명</th>
												<th width="50px;">직급</th>
												<th width="100px;">실적</th>
												<th width="90px;">목표건</th>
												<th width="90px;">실적건</th>
												<th width="90px;">성과율</th>
												<th width="80px;">시작일</th>
												<th width="80px;">종료일</th>
												<th width="80px;">입사일</th>												
												<th width="100px;"></th>													
												<th width="15px;"></th>													
											</tr>
										</table>
										</div>									
										<div id="divCenterList" style="overflow:auto;width:1260px; height:650px;"></div>						
									</form>
								</div>
							</div>
						</div>
																								
					</div>
				</div>
				<div id="manager-detail-dialog" title="분기별 설정 수정" style="font-size: 15px;display:none;" align="center"></div>															
				<!-- //centercnt_bot -->				
				<!-- //center_cnt -->
			</div>
		</div>
		<!-- //contents -->
	</div>	
</div>
<!-- //wrapper -->
</body>
</html>