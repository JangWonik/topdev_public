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
			
		/*수정 버튼*/
		.btn-equipment-mod-s {
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
			width:25px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FFBF00;
		}	
	</style>
	<script language="javascript">
		$(document).ready( function(){
			$("#srchStatus").select2();
			$("#srchCenterList").select2();
			$("#tmSearchMain").select2();
			$("#srchBaseYear").select2();
			
			$("#srchStatus").val(0).trigger('change');
			$("#srchBaseYear").val('2023').trigger('change');			
			$("#srchUserName").focus();
		});
		
		
		//목표건수 수정 
		function doInfoModify( p_idx ){
			$("#info_view_"+p_idx).hide();
			$("#info_edit_"+p_idx).show();
		}
		
		//목표건수 수정 취소
		function doInfoCancel( p_idx ){
			$("#info_view_"+p_idx).show();
			$("#info_edit_"+p_idx).hide();
		}
		
		//목표건수 수정 저장
		function doInfoSave( p_idx, p_user_no, p_base_year ){
			
			var editTargetVal = $("#edit_target_val_"+p_idx).val();
			var param = {};			
			param.user_no = p_user_no;
			param.base_year = p_base_year;
			param.target_val = editTargetVal;
			
			var url = "/updateBonusMemberTargetVal";
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){
       	        	doInfoCancel(p_idx);
       	        	fnSearch();
       	        }
       	    });						
		}
		
		//목표건수 추가 저장
		function doInfoAddSave( p_idx, p_user_no ){
			
			var addTargetVal = $("#add_target_val_"+p_idx).val();
			var addBaseYear = $("#add_base_year_"+p_idx).val();
			
			if( addBaseYear == '' ){
				alert("기준년도를 입력해주세요.");
				$("#add_base_year_"+p_idx).focus();
				return;
			}
			
			if( addTargetVal == '' ){
				alert("목표건수를 입력해주세요.");
				$("#add_target_val_"+p_idx).focus();
				return;
			}
			
			var param = {};			
			param.user_no = p_user_no;
			param.base_year = addBaseYear;
			param.target_val = addTargetVal;			
			
			var url = "/insertBonusMemberTargetVal";
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){
       	        	doInfoAddCancel(p_idx);
       	        	fnSearch();
       	        }
       	    });						
		}
		
		//목표건 추가
		function doInfoAdd( p_idx ){
			$("#info_view_"+p_idx).hide();
			$("#info_add_"+p_idx).show();
		}
		
		function doInfoAddCancel( p_idx ){
			$("#info_view_"+p_idx).show();
			$("#info_add_"+p_idx).hide();
		}
		
		function enterKey(){
			if( event.keyCode == 13 ){			
				fnSearch();			
			}
		}
		
		//검색
		function fnSearch(){			
			var formData = $("#searchFrm").serialize();
			$.ajax({
	 			type : "post",	 			
	 			url : "/getBonusMemberYearListAjax",
	 			data : formData,
	 			success : function(result){
	 				$("#divMemberList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
		}
		
		//엑셀다운로드
		/*
		function doDownload(){
			$("#searchFrm").attr("action","schBonusListExcel");
			$("#searchFrm").submit();
		}
		*/
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
								<li class="on" id="mainTab"><a href="#">성과급 직원 연간목표관리</a></li>																								
							</ul>
						</div>
						<!-- 검색 창 시작 -->
						<div class= "tableStyle2" style="padding-top: 10px;">
							<form id="searchFrm">
								<input type="text" style="display:none;"/>					
								<div id="search-box"  align="center">
									<!-- 검색 창 시작 -->				
									<table style="width: 100%;height:30px;" align="center">										
										<tr>
											<th width="80px">기준연도</th>
											<td>
												<select id="srchBaseYear" name="srchBaseYear" style="width:80px;text-align:left;">
													<option value="9999"> - 전체 - </option>
													<option value="2023">2023년</option>
													<option value="2024">2024년</option>													
												</select>
											</td>
											<th width="100px">재직상태</th>
											<td width="100px">
												<select id="srchStatus" name="srchStatus" style="width:80px;text-align:left;">
													<option value="9999"> - 전체 - </option>
													<option value="0">재직자</option>
													<option value="1">퇴사자</option>
												</select>												
											</td>
											<th width="80px">센터명</th>
											<td width="190px">
												<select id="srchCenterList" name="srchCenterList" style="width:170px;text-align:left;">
													<option value=""> - 전체 - </option>													
													<c:forEach items="${centerList}" var="centerVo">
														<option value="${centerVo.teamCenter}">${centerVo.centerName}</option>
													</c:forEach>
												</select>
											</td>
											<th width="80px">팀명</th>
											<td width="190px">
												<select id="tmSearchMain" name="tmSearchMain" style="width:170px;text-align:left;">
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
											<th width="80px">이름</th>
											<td width="150px">
												<input type="text" id="srchUserName" name="srchUserName" onkeydown="javascript:enterKey();" style="width:130px;"/>												
											</td>																					
											<td>
												<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:fnSearch();'>검 색</a>
											</td>
										</tr>
									</table>
									<!-- 검색 창 끝 -->
									<!-- 목록 시작 -->
									<div class="guestcnt4" style="display:block;height:750px;">
										<div class="tableStyle2">
											<table>									
												<tr>
													<th width="50px;">순번</th>
													<th width="100px;">기준년도</th>
													<th width="100px;">센터명</th>
													<th width="100px;">팀명</th>
													<th width="100px;">성명</th>
													<th width="50px;">직위</th>
													<th width="100px;">직책</th>
													<th width="100px;">입사일자</th>
													<th width="150px;">목표건수</th>
													<th width="100px;">재직상태</th>
													<th width="10px;"></th>													
												</tr>
											</table>
											<div id="divMemberList" style="overflow:auto;width:100%; height:660px;"></div>
										</div><!-- //tableStyle2 -->							
									</div>
									<!-- 목록 끝 -->
								</div> 
							</form>
						</div>
						<!-- 검색 창 끝 -->						
					</div>
				</div>
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
