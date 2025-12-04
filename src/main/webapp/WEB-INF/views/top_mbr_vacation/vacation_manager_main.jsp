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

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>	
		
		
	
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
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
								<li class="on" id="mainTab" id="allCnt"><a href="#">관리자 휴가신청 내역</a></li>																
							</ul>
						</div>
						
						<div class="guestcnt8" id="allList">
							<%-- <c:import url="/vacationApprovalAll" ></c:import> --%>
							<c:import url="/vacationManagerAll" ></c:import>
						</div>
																	
						<div id="vacation-detail-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center">
						</div>						
						<script>
							$(document).ready(function(){								
								$("#approval-all-btn-search").click(function(){				
									$("#searchFrm").attr("action","vacationManager");
									searchFrm.submit();
								});
							});
							
							//상세보기 처리
							function openDetailView(serial_no){
								
								//var url = "/vacationDetailNewModal";		//상세내역페이지
								var url = "/vacationDetailManagerNewModal";		//상세내역페이지
								
								var param = {};
								param.serial_no = serial_no;	
								param.view_type = 'view';
																
							    $.ajax({
							        type: "POST",
							        url: url,
							        data: param,
							        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
							        timeout: 20000,
							        dataType: "HTML", 
							        success: function(data){
							        	$("#vacation-detail-dialog").html();
							        	$("#vacation-detail-dialog").html(data);
										$("#vacation-detail-dialog").dialog({
											height: 580,
											width: 800,
											closeOnEscape : true,
											draggable : true,
											title: "휴가 결재 내역 상세",
											//buttons : modalButtons,
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
<script>
/* 페이지 이동 */
function fnGoPage(pageIdx) {	
    $("#pageIdx").val(pageIdx);    
	$("#listFrm").submit();				        
}

function fnGoResultPage(pageIdx) {	
    $("#pageIdxResult").val(pageIdx);    
	$("#resultFrm").submit();				        
}

function fnGoSearchPage(pageIdx) {	
    $("#pageIdxSearch").val(pageIdx);    
	$("#searchFrm").submit();
}

function fnGoAnnualPage(pageIdx) {	
    $("#pageIdxAnnual").val(pageIdx);    
	$("#annualFrm").submit();
}
</script>
</body>
</html>
