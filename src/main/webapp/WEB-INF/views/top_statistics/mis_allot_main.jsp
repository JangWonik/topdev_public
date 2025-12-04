<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>

	<style>
		.sub-p{
			border-top:1px solid #e6e6e6;
		}
	</style>

	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_21}' == 0){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
			
			var tabMenu = '${tabMenu}';
			
			if( tabMenu == 'member' ){				
				//doMemberTabClick();
				doFirstLoading();
			}else if( tabMenu == 'team' ){
				doTeamTabClick();
			}else if( tabMenu == 'center' ){
				doCenterTabClick();
			}else if( tabMenu == 'sector' ){
				doSectorTabClick();
			}else if( tabMenu == 'ptnr' ){
				doPtnrTabClick();
			}
			
		});
		
		function goMisAllotTmMbr(id, nm, type, written_flag){
			misSearchForm.action = "./getMisAllotTmMbr";
			misSearchForm.team_id.value = id;
			misSearchForm.team_name.value = nm;
			misSearchForm.team_type.value = type;
			misSearchForm.team_written.value = written_flag;
	        misSearchForm.submit();
		}
		
		//보험사별 일일배당현황 팝업
		function openPtnrByCenterModal( p_ptnrId , p_ptnrName ){
			
			var url = "./openPtnrByCenterModal";
			
			var param = {};
			param.ptnr_id = p_ptnrId;
			param.ptnr_name = p_ptnrName;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#ptnr-center-dialog").html();
		        	$("#ptnr-center-dialog").html(data);
					$("#ptnr-center-dialog").dialog({						
						height: 800,
						width: 1600,
						closeOnEscape : true,
						draggable : true,
						title: "보험사 기준 센터별 일일 배당현황",
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
		
		//센터별 보험사 팝업
		function openCenterByPtnrModal( p_centerId , p_centerName ){
			
			var url = "./openCenterByPtnrModal";
			
			var param = {};
			param.team_center = p_centerId;
			param.center_name = p_centerName;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#ptnr-center-dialog").html();
		        	$("#ptnr-center-dialog").html(data);
					$("#ptnr-center-dialog").dialog({						
						height: 800,
						width: 1600,
						closeOnEscape : true,
						draggable : true,
						title: "센터 기준 보험사별 일일 배당현황",
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
		
		//페이지 최초 로딩시 처리
		function doFirstLoading(){
			$("#firstLoadDiv").show();
			
			$("#memberTab").attr("class","on");
			$("#teamTab").attr("class","");
			$("#centerTab").attr("class","");
			$("#sectorTab").attr("class","");
			$("#ptnrTab").attr("class","");
			
			$("#tabMenu").val("member");
			
			var formData = $("#mainSearchForm").serialize();
			
			var url = "misAllotTmMbrAjax"; 
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: formData,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#dataList").html(data);
		        	$("#firstLoadDiv").hide();
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		//전체 개인별 일일배당 클릭시
		function doMemberTabClick(){
			
			$("#top_loading").show();
			
			$("#memberTab").attr("class","on");
			$("#teamTab").attr("class","");
			$("#centerTab").attr("class","");
			$("#sectorTab").attr("class","");
			$("#ptnrTab").attr("class","");
			
			$("#tabMenu").val("member");
			
			var formData = $("#mainSearchForm").serialize();
			
			var url = "misAllotTmMbrAjax"; 
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: formData,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#dataList").html(data);							
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		function doTeamTabClick(){
			
			$("#top_loading").show();
			
			$("#memberTab").attr("class","");
			$("#teamTab").attr("class","on");
			$("#centerTab").attr("class","");
			$("#sectorTab").attr("class","");
			$("#ptnrTab").attr("class","");
			
			$("#tabMenu").val("team");
			
			var formData = $("#mainSearchForm").serialize();
			
			var url = "misAllotTmAjax"; 
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: formData,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#dataList").html(data);							
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		function doCenterTabClick(){
			
			$("#top_loading").show();
			
			$("#memberTab").attr("class","");
			$("#teamTab").attr("class","");
			$("#centerTab").attr("class","on");
			$("#sectorTab").attr("class","");
			$("#ptnrTab").attr("class","");
			
			$("#tabMenu").val("center");
			
			var formData = $("#mainSearchForm").serialize();
			
			var url = "misAllotCenterAjax"; 
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: formData,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#dataList").html(data);							
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		function doSectorTabClick(){
			
			$("#top_loading").show();
			
			$("#memberTab").attr("class","");
			$("#teamTab").attr("class","");
			$("#centerTab").attr("class","");
			$("#sectorTab").attr("class","on");
			$("#ptnrTab").attr("class","");
			
			$("#tabMenu").val("sector");
			
			var formData = $("#mainSearchForm").serialize();
			
			var url = "misAllotSectorAjax"; 
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: formData,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#dataList").html(data);							
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		function doPtnrTabClick(){
			
			$("#top_loading").show();
			
			$("#memberTab").attr("class","");
			$("#teamTab").attr("class","");
			$("#centerTab").attr("class","");
			$("#sectorTab").attr("class","");
			$("#ptnrTab").attr("class","on");
			
			$("#tabMenu").val("ptnr");
			
			var formData = $("#mainSearchForm").serialize();
			
			//var url = "misAllotPtnrAjax"; 
			var url = "misAllotPtnrNewAjax";
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: formData,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#dataList").html(data);							
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
	</script>

</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_statistics/statistics_menu.jsp"></c:import>
	<!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns2">
			<div class="center_cnt2">

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">

							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b><!-- 팀별 일일 배당 현황 -->전체 개인별 일일배당</b>
								<font color="red">*주의* 접수건중 반송&취소건은 제외된 건수입니다!</font>								
							</div>
							<div style="text-align: right;">								
								<b>&middot; 연간수임 :</b> ${nowVO.year_from} ~ ${nowVO.year_to} 의 <b>수임건수</b><br/>
								<b>&middot; 당월종결 :</b> ${nowVO.now_from} ~ ${nowVO.now_to} 의 <b>종결건수</b><br/>
								<b>&middot; 연간종결 :</b> ${nowVO.year_from} ~ ${nowVO.year_to} 의 <b>종결건수</b>								
							</div>
							<form id="mainSearchForm" name="mainSearchForm">
								<input type="hidden" id="tabMenu" name="tabMenu"/>
							</form>

							<form name="misSearchForm" id="misSearchForm" method="GET" action="./getMisAllotTmMbr">								
								<input type="hidden" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}" />
								<input type="hidden" id="viewToDate" name="viewToDate" value="${inVO.viewToDate}" />
								<input type="hidden" id="team_id" name="team_id" />
								<input type="hidden" id="team_name" name="team_name" />
								<input type="hidden" id="team_type" name="team_type" />
								<input type="hidden" id="team_written" name="team_written" />
							</form>
						</div>
					</div>
				</div><!-- //centercnt_top -->

				<div class="centercnt_bot2" style="margin:0 auto;">
					<div class="guest">

						<div class="guestTap">
							<ul>
								<li id="memberTab"><a href="#" onclick="javascript:doMemberTabClick();">전체 개인별 일일배당</a></li>
								<li id="teamTab"><a href="#" onclick="javascript:doTeamTabClick();">팀별 일일 배당 현황</a></li>								
								<li id="centerTab"><a href="#" onclick="javascript:doCenterTabClick();">센터별 일일 배당 현황</a></li>
								<li id="sectorTab"><a href="#" onclick="javascript:doSectorTabClick();">부문별 일일 배당 현황</a></li>
								<li id="ptnrTab"><a href="#" onclick="javascript:doPtnrTabClick();">보험사별 일일 배당 현황</a></li>								
							</ul>							
						</div>
						<div id="dataList"></div>
						<div id="firstLoadDiv" style="height:500px;display:none;">
							<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />																	
						</div>
						<div id="ptnr-center-dialog" title="보험사별 일일 배당현황 센터별 보기" style="font-size: 12px;" align="center"></div>						
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>

</html>
