<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	<link rel="stylesheet" href="./resources/jquery/themes/smoothness/jquery-ui.css">
	<script src="./resources/jquery/jquery-ui.js"></script>
	<style>
		.ui-widget-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: #FFF; opacity: .80; filter:Alpha(Opacity=30); }
	</style>
	<script>
	$(document).ready(function(){
		//연봉신청팝업
//			var cw=screen.availWidth;
//			var ch=screen.availHeight;
//			var sw=1050; //띄울 창의 넓이
//			var sh=800;  //띄울 창의 높이

//			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
//			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

		if ("${salFlag}" == 1){
			$("#sal-dialog").dialog({
//				autoOpen: false,
				height: 250,
				width: 500,
				closeOnEscape : true,
				draggable : false,
				buttons:{
					"연봉계약서 작성하기" : function(){
						memberSalDtlPop();
						$(this).dialog("close");
					},
	 				/* "나의 등급 확인" : function(){
						$(this).dialog("close");
					}, */	
					"나중에 작성하기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			return false;
		}
		//form start
		
		
		if ("${internSalFlag}" == 1){
			$("#intern-dialog").dialog({
//				autoOpen: false,
				height: 250,
				width: 500,
				closeOnEscape : true,
				draggable : false,
				buttons:{
					"인턴사원 근로계약서 작성하기" : function(){
						internContractPop();
						$(this).dialog("close");
					},
					"나중에 작성하기" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
				
			});
			return false;
		}
		//form start
		
		function memberSalDtlPop(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1040; //띄울 창의 넓이
			var sh=800;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('member_request_salary','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no');
			//window.open('memberSalDtlPop','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no');
		}
		
		function internContractPop(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1040; //띄울 창의 넓이
			var sh=800;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('member_request_intern','','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			//window.open('internContract','','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	});
	</script>
</head>

<body>
	<div id="sal-dialog" title="연봉 계약 체결 대상자" style="font-size: 15px;">
		<br/>
        <div style="padding-left: 30px;">
            연봉 계약 체결 대상자 입니다. 지금 바로 확인하시겠습니까?
            <br/><br/>
            (My Menu에서 확인 가능합니다.)<br /><!-- <br /> -->
            <!-- 정식 연봉 계약 작업 시 주석 해제, 연봉계약기간이 아닌경우 주석 처리 by top3009<br />-->
            <!-- <span style="color: blue">&#8251; 2025년 연봉계약 체결기간</span><br/>
            <span style="color: blue;margin-left: 18px;">2024.12.26(목) ~ 2024.12.31(화) 18시</span> -->
        </div>
	</div>

	<div id="intern-dialog" title="인턴사원 근로계약 체결 대상자" style="font-size: 15px;">
		<br/><br/>
		<center>
			인턴사원 근로계약 체결 대상자 입니다. 
			<br/>지금 바로 확인하시겠습니까?
			<br/><br/>
			(My Menu에서 확인 가능합니다.)
			<br /><br />
		</center> 
	</div>	
	
	
</body>


</html>
