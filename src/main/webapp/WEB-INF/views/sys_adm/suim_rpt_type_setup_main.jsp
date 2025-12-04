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
			$("#srchRptType").select2();
			$("#srchTypeName").focus();
		});
		
		//목표건수 수정 저장
		function doTypeModify( p_idx, p_suimType1, p_workloadType ){			
			
			var suimType1Val = p_suimType1;
			var workloadTypeVal = p_workloadType;
			var checkTypeVal = $("input[name='div_type_"+p_idx+"']:checked").val();			
			
			var param = {};			
			param.suim_rpt_type1 = suimType1Val;
			param.workload_type = workloadTypeVal;
			param.div_type = checkTypeVal;
			
			var url = "/updateSuimTypeCodeVal";
			
			$.ajax({
       	        type: "POST",
       	        url: url,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){       	        	
       	        	alert("수정하였습니다.");
       	        	fnSearch();
       	        }
       	    });			
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
	 			url : "/getSuimRptTypeCodeListAjax",
	 			data : formData,
	 			success : function(result){
	 				$("#divCodeList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
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
								<li class="on" id="mainTab"><a href="#">보험사 코드분류 관리</a></li>																								
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
											<td width="40%" style="text-align:left;padding-left:10px;font-weight:bold;color:blue;">* 참고 : sysadm_codedic2 (col_nm='workload_type_div') </td>
											<th width="100px">분류조건</th>
											<td width="120px">
												<select id="srchRptType" name="srchRptType" style="width:110px;text-align:left;">
													<option value="9999"> - 전체 - </option>
													<option value="5">물보험 조사</option>
													<option value="10">물보험 심사</option>
													<option value="15">물보험 기타</option>													
												</select>												
											</td>											
											<th width="180px">기준업무량 상세구분명</th>
											<td width="190px">
												<input type="text" id="srchTypeName" name="srchTypeName" onkeydown="javascript:enterKey();" style="width:180px;"/>
												<!-- <input type="text" id="srchUserName" name="srchUserName" onkeydown="javascript:enterKey();" style="width:130px;"/> -->												
											</td>																																
											<td width="100px">
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
													<th width="50px">순번</th>
													<th width="120px">처리구분 명</th>
													<th width="220px">상세구분 명</th>
													<th width="100px">suim_rpt_type1</th>
													<th width="100px">workload_type</th>
													<th width="300px">분류 설정</th>
													<th width="80px">-</th>
													<th width="10px"></th>													
												</tr>
											</table>
											<div id="divCodeList" style="overflow:auto;width:100%; height:660px;"></div>											
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
