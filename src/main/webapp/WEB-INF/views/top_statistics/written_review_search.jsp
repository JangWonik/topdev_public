<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>서면심사 종결 및 수임등록관리</title>
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->

    <script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
    <script src="./resources/jquery/jquery.mask.min.js"></script>

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<style>
	
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		/*상세보기 버튼*/
		.btn-equipment-view {
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
			background: #eeeeee;
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
		
		/*저장 버튼*/
		.btn-equipment-save {
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
			background: #3399FF;
		}
		
		/*취소 버튼*/
		.btn-equipment-cancel {
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
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF3333;
		}
	
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
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
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
	<script>
	$(document).ready(function(){
		$("#tmSearchMain").select2();
		$("#srchUserNoMain").select2();
		
		//사용자 검색에 퇴직자 포함할것인지 여부
		$("#outUserChk").change(function(){		
			
			if( $('input:checkbox[id="outUserChk"]').is(":checked") ){			
				$("#s_out_user").val(1);			
			}else{			
				$("#s_out_user").val(0);			
			}
			
			$('#excelForm [name="s_team_id"]').val($("#tmSearchMain").val());
			$('#excelForm [name="s_user_no"]').val($("#srchUserNoMain").val());
			$('#excelForm [name="s_out_user"]').val($("#s_out_user").val());
			$('#excelForm [name="s_base_date"]').val($("#baseDate").val());
			
			$('#excelForm').attr('action','writtenReviewSearch');
			
			//검색페이지까지 리프레쉬
			$("#excelForm").submit();
			
		});
	});
	
	function doDownLoad(){
		
		var sUrl = "./doDownWrittenList";		
		
		var sBaseDate = $("#baseDate").val();
		
		if( sBaseDate == '' ){
			alert("검색 할 기준일을 입력해 주세요.");
			$("#baseDate").focus();
			return;
		}
		
		$('#excelForm [name="s_team_id"]').val($("#tmSearchMain").val());
		$('#excelForm [name="s_user_no"]').val($("#srchUserNoMain").val());
		$('#excelForm [name="s_out_user"]').val($("#s_out_user").val());
		$('#excelForm [name="s_base_date"]').val($("#baseDate").val());
		
		$('#excelForm').attr('action','doDownWrittenList');		
		
		$("#excelForm").submit();
		
	}
		
	function doSearch(){
		
		var sUrl = "./getSearchWrittenList";
		
		if( $('input:checkbox[id="outUserChk"]').is(":checked") ){			
			$("#s_out_user").val(1);			
		}else{			
			$("#s_out_user").val(0);			
		}
		
		var param = {};		
		param.s_team_id = $("#tmSearchMain").val();
		param.s_user_no = $("#srchUserNoMain").val();
		param.s_out_user = $("#s_out_user").val();
		param.s_base_date = $("#baseDate").val();
		
		if( param.s_base_date == '' ){
			alert("검색 할 기준일을 입력해 주세요.");
			$("#baseDate").focus();
			return;
		}
		
		$("#top_loading").show();
		
		//검색결과 페이지를 가져온다.
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		timeout: 20000,    		         
    		success: function(data){
    			//console.log("data="+data);
    			$("#searchWrittenList").html(data);    			    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
		
		//alert('test='+$("#tmSearchMain").val()+" : "+$("#srchUserNoMain").val()+ " : "+$("#outUserChkVal").val() +" : "+$("#baseDate").val());
		
	}	
	</script>
</head>
<body>
<div id="wrapper">
	<!-- top menu import -->
	<c:import url="../top_statistics/statistics_menu.jsp"></c:import>
	<!-- contents -->
	<div id="container">
		<!-- <div class="contetns"> -->
		<div class="contetns2">
		<!-- centercnt_top -->
			<!-- <div class="center_cnt_1300"> -->
			<div class="center_cnt2">
				<!-- centercnt_bot -->
				<!-- <div class="center_cnt_vacation" > -->
				<div class="centercnt_bot2" >				
					<div class="guest">
						<div style="float: left;padding:10px 0 10px;">
							<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
							&nbsp;&nbsp;<b>서면심사팀 실적통계</b>								
                          	</div>
					</div>
					<!-- 검색 창 시작 -->
					<div class="guestTap">
						<form id="searchForm" name="searchForm" method="post" action="writtenReviewSearch">
						<input type="hidden" id="s_out_user" name=s_out_user value="0" />					
						<div class="tableStyle99">
							<table style="width: 100%; align="center">
								<tr>
									<th width="100px;">부 서 명</th>
									<td width="200px;" style="text-align:center;">
										<select id="tmSearchMain" name="tmSearchMain" style="width:180px;text-align:left;">
											<option value="" <c:if test="${empty s_team_id}">selected</c:if> > - 전체 - </option>										
											<c:forEach items="${teamList}" var = "teamVo">
												<option value="${teamVo.teamId}"
													<c:if test="${s_team_id eq teamVo.teamId}">selected</c:if>>
													<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
													<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
													${teamVo.teamName}
												</option>
											</c:forEach>
										</select>										
									</td>
									<th width="100px;">
										이 름
									</th>
									<td width="250px;" style="text-align:center;">
										<select id="srchUserNoMain" name="srchUserNoMain" style="width:120px;text-align:left;">
											<option value="" <c:if test="${empty s_user_no}">selected</c:if> > - 전체 - </option>											
											<c:forEach items="${memberList}" var="item" >
												<option value="${item.userNo}" <c:if test="${s_user_no == item.userNo}">selected</c:if> >${item.userName}</option>									
											</c:forEach>										
										</select>
										&nbsp;&nbsp;<input type="checkbox" id="outUserChk" <c:if test="${s_out_user eq 1}">checked</c:if>> 퇴직자포함
									</td>
									<th width="100px;">기준일</th>
									<td width="150px;" style="text-align:center;">
										<c:choose>
											<c:when test="${empty s_base_date}">
												<input type="text" class="classCalendar" id="baseDate" name="baseDate" style="width:100px;" value="${sToday}"/>
											</c:when>											
											<c:otherwise>
												<input type="text" class="classCalendar" id="baseDate" name="baseDate" style="width:100px;" value="${s_base_date}"/>
											</c:otherwise>
										</c:choose>																				 
									</td>									
									<td style="text-align:center;"  width="100px;">
										<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:doSearch();'>검색</a>
									</td>
									<td style="padding-left:5px;">
										<img id="exceldown" src="/resources/ls_img/btn_excel.gif" alt="엑셀다운로드" onclick="javascript:doDownLoad();" style="cursor:pointer;"/>																				
									</td>
								</tr>
							</table>					
							<br/>
							<div id="searchWrittenList" style="overflow:auto;"></div>
						</div>
						</form>
					</div>
					<!-- 검색 창 끝 -->
				</div>
			</div>
		</div>
		<!-- //통합로딩바 -->
		<div id="top_loading" style="display: none;">
			<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
		</div>
		<!-- //통합로딩바끝 -->
	</div>		
</div>
<form id="excelForm" name="excelForm" action="./doDownWrittenList" method="post">
	<input type="hidden" id="s_team_id" name="s_team_id"/>
	<input type="hidden" id="s_user_no" name="s_user_no"/>
	<input type="hidden" id="s_out_user" name="s_out_user"/>
	<input type="hidden" id="s_base_date" name="s_base_date"/>
</form>
</body>
</html>