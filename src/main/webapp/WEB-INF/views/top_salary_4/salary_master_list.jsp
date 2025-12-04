<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>급여 통합조회</title>
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
		
		/*보기 녹색 버튼*/
		.btn-equipment-green {
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
			width:100px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #009966;
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
			width:100px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #0033FF;
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
			width:30px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #6633FF;
		}
		
		.btn-equipment-cancel-s {
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
			width:30px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF0099;
		}
		
		.btn-equipment-del-s {
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
			width:30px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF3333;
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
			width:100px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3399FF;
		}
		
		/*저장 버튼*/
		.btn-equipment-save-s {
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
			width:30px;
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
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 10px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
		
		.btn-vacation-detail {
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
			background: #CEE3F6;
		}
	</style>
	<script>
	$(document).ready(function(){		
		
		$("#yearprev").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        var imsiyeartxtSub = --imsiyeartxt; 
	        $("#yeartxt").text(imsiyeartxtSub);
        	$("#base_sdate").val(imsiyeartxtSub+"-12-21");
        	$("#base_edate").val(++imsiyeartxt+"-01-20");
        	
        	$("#chk_sdate").val(imsiyeartxtSub+"-12-01");
        	$("#chk_edate").val(imsiyeartxtSub+"-12-31");
        	
        	$("#sales_date").val(imsiyeartxt+"-01-31");
        	
        	doMasterSearch();
	    });
	    $("#yearnext").click(function(){
	        var imsiyeartxt = $("#yeartxt").text();
	        var imsiyeartxtSub = ++imsiyeartxt;
	        $("#yeartxt").text(imsiyeartxtSub);
        	$("#base_sdate").val($("#yeartxt").text()+"-12-21");
        	$("#base_edate").val(++imsiyeartxtSub+"-01-20");
        	
        	$("#chk_sdate").val($("#yeartxt").text()+"-12-01");
        	$("#chk_edate").val($("#yeartxt").text()+"-12-31");
        	
        	$("#sales_date").val(imsiyeartxtSub+"-01-31");
        	
        	doMasterSearch();
	    });

	    //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
	    $(".monthbtn").click(function(){
	    	var imsimonth = $(this).attr("id");
	    	var imsiMonthStart = imsimonth -1;
	    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
	    	var imsiMonthStartStr = "0"+imsiMonthStart;
	    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
	        	$("#base_sdate").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "21");
	        	$("#base_edate").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "20");
	        	
	        	$("#chk_sdate").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "01");
	        	//스크립트로 마지막날 구하기
	        	var lastDay = new Date( $("#yeartxt").text(), imsiMonthStart, 0 );	        	
	        	$("#chk_edate").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ lastDay.getDate());
	        	
	        	var lastDaySub = new Date( $("#yeartxt").text(), imsimonth, 0 );
	        	$("#sales_date").val($("#yeartxt").text()+"-"+imsimonth +"-"+ lastDaySub.getDate());	        	
	        	
	        if(imsimonth == 1){	        	
	        	$("#base_sdate").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "21");
	        	$("#chk_sdate").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "01");
	        	$("#chk_edate").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "31");
	        	$("#sales_date").val($("#yeartxt").text()+"-"+"01" +"-"+ "31");
	        }	        
	        
	        doMasterSearch();
	    });
		
	});
	</script>
</head>
<body>
<div id="wrapper">
	<!-- top menu import -->
	<c:import url="../top_salary_4/salary_menu.jsp"></c:import>
	<!-- contents -->
	<div id="container">
		<div class="contetns2">
		<!-- centercnt_top -->
			<div class="center_cnt2">
				<!-- centercnt_bot -->
				<div class="centercnt_top" >	
					<div class="nociteA log_top">			
						<div class="guest">
							<div style="float: left;padding:10px 0 10px;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
								&nbsp;&nbsp;<b>급여 통합조회</b>								
	                          	</div>
	                        <div style="text-align: right;">
								<img id="yearprev" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="yeartxt" href="#">${srchParam.base_edate.substring(0,4)}</a>
								<img id="yearnext" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<!-- 탭 메뉴 시작 -->
				<div class="centercnt_bot2" style="margin:0 auto;height:800px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li id="tabMenu1" class="on"><a href="#">급여 통합조회</a></li>								
							</ul>
						</div>								
						<div class="guestcnt2" id="base_page">									
								<c:import url="./salary_master_person_list.jsp"></c:import>
						</div>													
					</div>
				</div>					
				<!-- 탭 메뉴 끝 -->				
			</div>
		</div>		
	</div>
</div>
</body>
</html>