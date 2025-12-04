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
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>
	<script language="javascript">
		$(document).ready( function(){			
			_initCalendar();		
			_initMask();
			$("#top_loading").hide();
		});
		
		function _initCalendar(){    	 
	  		$('.calendar').datepicker({
	  			showOn: 'button',
	  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	  			buttonImageOnly: true,
	  			buttonText: "달력", 
	  			changeMonth: true,
	  			changeYear: true,	    	   
	  			showButtonPanel: false,
	  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	  			dayNamesMin: ['일','월','화','수','목','금','토'],
	  			dateFormat: 'yy-mm-dd',
	  			firstDay: 0,
	  			isRTL: false,
	  			showMonthAfterYear: true
	  	    });
	  	}
		
		function _initMask(){
		    var options = {
		        onKeyPress : function(cep, event, currentField, options){
		            var tid = event.currentTarget.id;
		            var tidx = tid.substr(tid.length - 1, 1);
		        },
		        reverse : true
		    };		    
		    
		  	//날짜입력 패턴 추가
		    $('input.calendar').mask('0000-00-00',options);		    
		}
		
		function fnSearch(){			
			$("#top_loading").show();			
			$("#searchForm").submit();
		}
	</script>
	
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
			background: #CEE3F6;
		}
		.tableStyle2 td {letter-spacing:0px;}
	</style>	
	
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_sysadm_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns2">
			<!-- centercnt_top -->
			<div class="center_cnt2">
				<!-- centercnt_bot -->
				<div class="center_cnt2" >
					<div class="guest">
						<div class="guestTap">
							<ul>								
								<li class="on" id="teamTab"><a href="#">부서별현황</a></li>
								<!-- <li id="monthTab"><a href="#">월별장비현황</a></li> -->																
							</ul>
						</div>						
						<div class="guestcnt8" id="equipmentTeamList" style="padding: 0 0 0 0;overflow-x:hidden;overflow-y:hidden;">							
							<c:import url="/equipment_manage_stat_team" ></c:import>
						</div>						
						
						<!-- 작업중.. -->
						<%-- <div class="guestcnt8" id="equipmentList" style="display:none;" >
							<c:import url="/equipment_manage_list" ></c:import>
						</div> --%>						
						
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
