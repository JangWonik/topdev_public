<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script src="./resources/tooltipsy/tooltipsy.min.js"></script>
	
	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>    
    <%--spiner end --%>
	
	<style>
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
		
		.buttonAssistanceDocu{
			width:70px;
			height:23px;
		    background-color:#9900CC;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
		
		.tableStyle2 td{
			letter-spacing : 0px;
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
			color:#ffffff  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #2E7EE8;			
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 0px grey;		    
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		.buttonMiniView{
			width:100px;
			height:20px;
		    background-color:#F7F7F7;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 12px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
		
	</style>
	
</head>
<script>
	$(document).ready(function(){
		
		doOrderSearch();
		
	});
	
	function doOrderSearch(){
		
		var param = {}; 
		
		$.ajax({
			type : "post",			
			url : "topPtnrListOrderAjax",
			data : param,
			success : function(result){				
				$("#ptnrOrderList").html(result);
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	function doUpOrder( p_ptnr_id, p_ptnr_order){
		
		var orderVal = p_ptnr_order;
		
		if( orderVal < 2 ){
			alert('정렬순서를 상위로 더 올릴 수 없습니다.');
			return;
		}
		
		var param = {};
		
		param.ptnr_id = p_ptnr_id;
		param.statistics_order = p_ptnr_order;
		param.action = "Up";
		
		var url = "./topPtnrListOrderAction";
		
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",				
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공
					//목록을 다시 불러온다.
					doOrderSearch();											
				}                	
			}                
	    });
		
	}
	
	function doDownOrder( p_ptnr_id, p_ptnr_order ){
		
		var param = {};
		
		param.ptnr_id = p_ptnr_id;
		param.statistics_order = p_ptnr_order;
		param.action = "Down";
		
		var url = "./topPtnrListOrderAction";
		
		$.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",				
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공
					//목록을 다시 불러온다.
					doOrderSearch();											
				}                	
			}                
	    });
		
	}
								
</script>
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
				<div class="center_cnt_vacation" style="height:950px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" id="mainTab"><a href="#">보험사 통계순서 관리 </a></li>																						
							</ul>
						</div>						
						
						<div class="guestcnt8" id="ptnrCompany" style="margin-top:0px;" >							
							<div class= "tableStyle2" style="border-top: 0px;">
								<table>
									<tr>											
										<th width="7%">순서</th>
										<th width="13%">정렬순서</th>										
										<th width="14%">로고</th>
										<th width="30%">회사명</th>
										<th width="9%">회사구분</th>										
										<th width="9%">공지사항</th>										
										<th width="9%">PRM</th>
										<th width="9%">홈페이지</th>																					
									</tr>
								</table>
								<div id="ptnrOrderList"></div>
							</div>							
						</div>
					</div>
				</div>
				<!-- //centercnt_bot -->
			<!-- //center_cnt -->
			</div>
		</div>		
		<!-- //통합로딩바 -->
		<div id="top_loading" style="display: none;">
			<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
		</div>
		<!-- //통합로딩바끝 -->
		<!-- //contents -->
	</div>
</div>
<!-- //wrapper -->
</body>
</html>
